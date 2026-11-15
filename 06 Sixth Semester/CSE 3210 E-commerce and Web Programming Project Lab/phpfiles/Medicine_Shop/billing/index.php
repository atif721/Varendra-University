<?php
/**
 * Billing (POS) - search products, manage the cart and save a sale.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

if (!isset($_SESSION['cart']) || !is_array($_SESSION['cart'])) {
    $_SESSION['cart'] = [];
}

$payment_methods = ['Cash', 'Card', 'Mobile Banking'];

/* ------------------------------------------------------------
 * POST actions: add, update, remove, clear, checkout
 * ---------------------------------------------------------- */
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'add') {
        $product_id = (int) ($_POST['product_id'] ?? 0);
        $quantity   = filter_var($_POST['quantity'] ?? 1, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
        $quantity   = $quantity === false ? 1 : $quantity;
        $product    = get_product($conn, $product_id);

        if (!$product) {
            set_flash('error', 'Product not found.');
        } elseif (expiry_status($product['expiry_date']) === 'expired') {
            set_flash('error', 'Expired medicines cannot be sold.');
        } elseif ((int) $product['stock'] <= 0) {
            set_flash('error', 'This product is out of stock.');
        } else {
            $in_cart = (int) ($_SESSION['cart'][$product_id] ?? 0);
            $wanted  = $in_cart + $quantity;

            if ($wanted > (int) $product['stock']) {
                set_flash('error', 'Only ' . (int) $product['stock'] . ' ' . $product['unit'] . ' of "' . $product['name'] . '" are in stock.');
            } else {
                $_SESSION['cart'][$product_id] = $wanted;
                set_flash('success', '"' . $product['name'] . '" added to the cart.');
            }
        }

        redirect('billing/index.php');
    }

    if ($action === 'update') {
        $quantities = $_POST['qty'] ?? [];
        $warnings   = [];

        if (is_array($quantities)) {
            foreach ($quantities as $product_id => $quantity) {
                $product_id = (int) $product_id;
                $quantity   = filter_var($quantity, FILTER_VALIDATE_INT, ['options' => ['min_range' => 0]]);

                if ($quantity === false || !isset($_SESSION['cart'][$product_id])) {
                    continue;
                }

                if ($quantity === 0) {
                    unset($_SESSION['cart'][$product_id]);
                    continue;
                }

                $product = get_product($conn, $product_id);

                if (!$product) {
                    unset($_SESSION['cart'][$product_id]);
                    $warnings[] = 'A product in the cart no longer exists and was removed.';
                } elseif (expiry_status($product['expiry_date']) === 'expired') {
                    unset($_SESSION['cart'][$product_id]);
                    $warnings[] = '"' . $product['name'] . '" has expired and was removed from the cart.';
                } elseif ($quantity > (int) $product['stock']) {
                    $_SESSION['cart'][$product_id] = (int) $product['stock'];
                    $warnings[] = 'Only ' . (int) $product['stock'] . ' ' . $product['unit'] . ' of "' . $product['name'] . '" are available.';
                } else {
                    $_SESSION['cart'][$product_id] = $quantity;
                }
            }
        }

        if ($warnings) {
            set_flash('warning', implode(' ', $warnings));
        } else {
            set_flash('success', 'Cart updated.');
        }

        redirect('billing/index.php');
    }

    if ($action === 'remove') {
        $product_id = (int) ($_POST['product_id'] ?? 0);
        unset($_SESSION['cart'][$product_id]);
        set_flash('success', 'Item removed from the cart.');
        redirect('billing/index.php');
    }

    if ($action === 'clear') {
        $_SESSION['cart'] = [];
        set_flash('success', 'Cart cleared.');
        redirect('billing/index.php');
    }

    if ($action === 'checkout') {
        $errors   = [];
        $subtotal = 0.0;
        $total_cost = 0.0;
        $items    = [];

        $customer_name  = trim($_POST['customer_name'] ?? '');
        $customer_phone = trim($_POST['customer_phone'] ?? '');
        $discount       = $_POST['discount'] ?? '0';
        $payment        = $_POST['payment_method'] ?? 'Cash';

        if (!$_SESSION['cart']) {
            $errors[] = 'The cart is empty.';
        }

        if (mb_strlen($customer_name) > 100) {
            $errors[] = 'Customer name cannot be longer than 100 characters.';
        }

        if (mb_strlen($customer_phone) > 20) {
            $errors[] = 'Customer phone cannot be longer than 20 characters.';
        }

        if (!is_numeric($discount) || (float) $discount < 0) {
            $errors[] = 'Discount must be zero or a positive amount.';
            $discount = 0;
        }

        if (!in_array($payment, $payment_methods, true)) {
            $errors[] = 'Please select a valid payment method.';
        }

        $ids = array_map('intval', array_keys($_SESSION['cart']));

        if ($ids) {
            $id_list  = implode(',', $ids);
            $products = mysqli_query($conn, "SELECT * FROM products WHERE id IN ($id_list)");

            while ($products && ($row = mysqli_fetch_assoc($products))) {
                $quantity = (int) ($_SESSION['cart'][$row['id']] ?? 0);

                if ($quantity <= 0) {
                    continue;
                }

                if (expiry_status($row['expiry_date']) === 'expired') {
                    $errors[] = '"' . $row['name'] . '" has expired and cannot be sold.';
                }

                if ($quantity > (int) $row['stock']) {
                    $errors[] = 'Insufficient stock for "' . $row['name'] . '". Available: ' . (int) $row['stock'] . '.';
                }

                $line_total      = (float) $row['selling_price'] * $quantity;
                $line_cost_total = (float) $row['cost_price'] * $quantity;
                $subtotal       += $line_total;
                $total_cost     += $line_cost_total;

                $row['cart_quantity'] = $quantity;
                $row['line_total']    = $line_total;
                $items[]              = $row;
            }
        }

        $discount = round((float) $discount, 2);

        if ($discount > $subtotal) {
            $errors[] = 'Discount cannot be greater than the subtotal.';
        }

        if ($items && $subtotal <= 0) {
            $errors[] = 'The sale total must be greater than zero.';
        }

        if ($errors) {
            set_flash('error', implode(' ', $errors));
            redirect('billing/index.php');
        }

        $grand_total = round($subtotal - $discount, 2);
        $admin_id    = (int) $_SESSION['admin_id'];

        $customer_name_sql  = mysqli_real_escape_string($conn, $customer_name);
        $customer_phone_sql = mysqli_real_escape_string($conn, $customer_phone);
        $payment_sql        = mysqli_real_escape_string($conn, $payment);

        $subtotal_sql    = number_format($subtotal, 2, '.', '');
        $discount_sql    = number_format($discount, 2, '.', '');
        $grand_total_sql = number_format($grand_total, 2, '.', '');
        $total_cost_sql  = number_format($total_cost, 2, '.', '');

        mysqli_begin_transaction($conn);

        try {
            $invoice_no = generate_invoice_no($conn);

            $sale_sql = "INSERT INTO sales
                            (invoice_no, customer_name, customer_phone, subtotal, discount,
                             grand_total, payment_method, total_cost, sold_by)
                         VALUES
                            ('$invoice_no', '$customer_name_sql', '$customer_phone_sql',
                             $subtotal_sql, $discount_sql, $grand_total_sql,
                             '$payment_sql', $total_cost_sql, $admin_id)";

            if (!mysqli_query($conn, $sale_sql)) {
                throw new RuntimeException('The sale could not be saved.');
            }

            $sale_id = (int) mysqli_insert_id($conn);

            foreach ($items as $item) {
                $product_id    = (int) $item['id'];
                $quantity      = (int) $item['cart_quantity'];
                $product_name  = mysqli_real_escape_string($conn, $item['name']);
                $unit_price    = number_format((float) $item['selling_price'], 2, '.', '');
                $cost_price    = number_format((float) $item['cost_price'], 2, '.', '');
                $line_total    = number_format((float) $item['line_total'], 2, '.', '');

                $item_sql = "INSERT INTO sale_items
                                (sale_id, product_id, product_name, quantity, unit_price, cost_price, line_total)
                             VALUES
                                ($sale_id, $product_id, '$product_name', $quantity,
                                 $unit_price, $cost_price, $line_total)";

                if (!mysqli_query($conn, $item_sql)) {
                    throw new RuntimeException('A sold item could not be saved.');
                }

                $stock_sql = "UPDATE products
                              SET stock = stock - $quantity
                              WHERE id = $product_id AND stock >= $quantity";

                if (!mysqli_query($conn, $stock_sql) || mysqli_affected_rows($conn) !== 1) {
                    throw new RuntimeException('Stock for "' . $item['name'] . '" changed. Please review the cart.');
                }
            }

            mysqli_commit($conn);

            $_SESSION['cart'] = [];
            set_flash('success', 'Sale saved successfully. Invoice: ' . $invoice_no);
            redirect('invoices/print.php?id=' . $sale_id);
        } catch (Throwable $exception) {
            mysqli_rollback($conn);
            set_flash('error', $exception->getMessage());
            redirect('billing/index.php');
        }
    }
}

/* ------------------------------------------------------------
 * Cart contents
 * ---------------------------------------------------------- */
$cart_items = [];
$cart_total = 0.0;
$cart_count = 0;

if ($_SESSION['cart']) {
    $id_list  = implode(',', array_map('intval', array_keys($_SESSION['cart'])));
    $products = mysqli_query($conn, "SELECT * FROM products WHERE id IN ($id_list)");

    while ($products && ($row = mysqli_fetch_assoc($products))) {
        $quantity = (int) ($_SESSION['cart'][$row['id']] ?? 0);

        if ($quantity <= 0) {
            continue;
        }

        $row['cart_quantity'] = $quantity;
        $row['line_total']    = (float) $row['selling_price'] * $quantity;
        $cart_total          += $row['line_total'];
        $cart_count          += $quantity;
        $cart_items[]         = $row;
    }
}

/* ------------------------------------------------------------
 * Product search
 * ---------------------------------------------------------- */
$q           = trim($_GET['q'] ?? '');
$category_id = (int) ($_GET['category_id'] ?? 0);
$conditions  = [];

if ($q !== '') {
    $like         = mysqli_real_escape_string($conn, $q);
    $conditions[] = "(p.name LIKE '%$like%' OR p.generic_name LIKE '%$like%')";
}

if ($category_id > 0) {
    $conditions[] = "p.category_id = $category_id";
}

$where = $conditions ? 'WHERE ' . implode(' AND ', $conditions) : '';
$limit = $conditions ? 25 : 12;

$search_results = mysqli_query(
    $conn,
    "SELECT p.*, c.name AS category_name
     FROM products p
     INNER JOIN categories c ON c.id = p.category_id
     $where
     ORDER BY p.name ASC
     LIMIT $limit"
);

$categories = mysqli_query($conn, "SELECT id, name FROM categories ORDER BY name ASC");

$pageTitle = 'Billing (POS)';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <h1 class="page-title h4 mb-1">Billing (POS)</h1>
        <p class="text-muted small mb-0">Search medicines, build the cart and complete the sale.</p>
    </div>
    <span class="badge text-bg-success fs-6"><?= $cart_count ?> item<?= $cart_count === 1 ? '' : 's' ?> in cart</span>
</div>

<div class="row g-3">
    <!-- Product search -->
    <div class="col-xl-7">
        <div class="card mb-3">
            <div class="card-body pb-3">
                <form method="get" action="<?= url('billing/index.php') ?>" class="row g-2 align-items-end">
                    <div class="col-sm-5">
                        <label for="q" class="form-label small text-muted mb-1">Search product</label>
                        <input type="text" class="form-control" id="q" name="q"
                               value="<?= e($q) ?>" placeholder="Name or generic name" autofocus>
                    </div>
                    <div class="col-sm-4">
                        <label for="category_id" class="form-label small text-muted mb-1">Category</label>
                        <select class="form-select" id="category_id" name="category_id">
                            <option value="0">All categories</option>
                            <?php mysqli_data_seek($categories, 0); ?>
                            <?php while ($category = mysqli_fetch_assoc($categories)): ?>
                                <option value="<?= (int) $category['id'] ?>"
                                    <?= $category_id === (int) $category['id'] ? 'selected' : '' ?>>
                                    <?= e($category['name']) ?>
                                </option>
                            <?php endwhile; ?>
                        </select>
                    </div>
                    <div class="col-sm-3 d-flex gap-2">
                        <button type="submit" class="btn btn-success flex-grow-1">
                            <i class="bi bi-search"></i>
                        </button>
                        <a href="<?= url('billing/index.php') ?>" class="btn btn-outline-secondary">Reset</a>
                    </div>
                </form>
            </div>
        </div>

        <div class="card">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <span class="fw-semibold">Products</span>
                <?php if (!$conditions): ?>
                    <span class="small text-muted">Showing <?= $limit ?> products</span>
                <?php endif; ?>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Medicine</th>
                            <th class="text-end">Price</th>
                            <th class="text-center">Stock</th>
                            <th>Expiry</th>
                            <th class="text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php if ($search_results && mysqli_num_rows($search_results) > 0): ?>
                        <?php while ($row = mysqli_fetch_assoc($search_results)): ?>
                            <?php
                            $status    = expiry_status($row['expiry_date']);
                            $can_sell  = $status !== 'expired' && (int) $row['stock'] > 0;
                            ?>
                            <tr>
                                <td>
                                    <div class="fw-semibold"><?= e($row['name']) ?></div>
                                    <div class="small text-muted">
                                        <?= e($row['category_name']) ?>
                                        <?= $row['generic_name'] !== null && $row['generic_name'] !== '' ? ' &middot; ' . e($row['generic_name']) : '' ?>
                                    </div>
                                </td>
                                <td class="text-end"><?= e(format_money($row['selling_price'])) ?></td>
                                <td class="text-center">
                                    <span class="badge <?= (int) $row['stock'] > 0 ? 'text-bg-light border' : 'text-bg-danger' ?>">
                                        <?= (int) $row['stock'] ?>
                                    </span>
                                </td>
                                <td class="small">
                                    <?= e(date('d M Y', strtotime($row['expiry_date']))) ?>
                                    <?php if ($status === 'expired'): ?>
                                        <div><span class="badge text-bg-danger">Expired</span></div>
                                    <?php elseif ($status === 'expiring'): ?>
                                        <div><span class="badge text-bg-warning">Expiring</span></div>
                                    <?php endif; ?>
                                </td>
                                <td class="text-end">
                                    <?php if ($can_sell): ?>
                                        <form method="post" action="<?= url('billing/index.php') ?>" class="d-inline">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="product_id" value="<?= (int) $row['id'] ?>">
                                            <input type="hidden" name="quantity" value="1">
                                            <button type="submit" class="btn btn-sm btn-success">
                                                <i class="bi bi-cart-plus me-1"></i>Add
                                            </button>
                                        </form>
                                    <?php else: ?>
                                        <button type="button" class="btn btn-sm btn-outline-secondary" disabled>
                                            <?= $status === 'expired' ? 'Expired' : 'Out of stock' ?>
                                        </button>
                                    <?php endif; ?>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    <?php else: ?>
                        <tr>
                            <td colspan="5" class="text-center text-muted py-4">No products match your search.</td>
                        </tr>
                    <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Cart -->
    <div class="col-xl-5">
        <div class="card">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <span class="fw-semibold"><i class="bi bi-cart3 me-1"></i>Cart</span>
                <?php if ($cart_items): ?>
                    <form method="post" action="<?= url('billing/index.php') ?>"
                          onsubmit="return confirm('Clear all items from the cart?');">
                        <input type="hidden" name="action" value="clear">
                        <button type="submit" class="btn btn-sm btn-outline-danger">Clear</button>
                    </form>
                <?php endif; ?>
            </div>

            <?php if ($cart_items): ?>
                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Item</th>
                                <th class="text-center" style="width: 130px;">Qty</th>
                                <th class="text-end">Total</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php foreach ($cart_items as $item): ?>
                            <tr>
                                <td>
                                    <div class="fw-semibold small"><?= e($item['name']) ?></div>
                                    <div class="text-muted small"><?= e(format_money($item['selling_price'])) ?> each</div>
                                </td>
                                <td>
                                    <form method="post" action="<?= url('billing/index.php') ?>" class="d-flex gap-1">
                                        <input type="hidden" name="action" value="update">
                                        <input type="number" class="form-control form-control-sm" name="qty[<?= (int) $item['id'] ?>]"
                                               value="<?= (int) $item['cart_quantity'] ?>" min="0" max="<?= (int) $item['stock'] ?>" step="1">
                                        <button type="submit" class="btn btn-sm btn-outline-secondary" title="Update quantity">
                                            <i class="bi bi-arrow-repeat"></i>
                                        </button>
                                    </form>
                                </td>
                                <td class="text-end small"><?= e(format_money($item['line_total'])) ?></td>
                                <td class="text-end">
                                    <form method="post" action="<?= url('billing/index.php') ?>">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="product_id" value="<?= (int) $item['id'] ?>">
                                        <button type="submit" class="btn btn-sm btn-outline-danger" title="Remove">
                                            <i class="bi bi-x-lg"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>

                <div class="card-body border-top">
                    <form method="post" action="<?= url('billing/index.php') ?>" id="checkout-form">
                        <input type="hidden" name="action" value="checkout">

                        <div class="row g-2 mb-3">
                            <div class="col-sm-6">
                                <label for="customer_name" class="form-label small mb-1">Customer Name</label>
                                <input type="text" class="form-control form-control-sm" id="customer_name"
                                       name="customer_name" maxlength="100" placeholder="Optional">
                            </div>
                            <div class="col-sm-6">
                                <label for="customer_phone" class="form-label small mb-1">Customer Phone</label>
                                <input type="text" class="form-control form-control-sm" id="customer_phone"
                                       name="customer_phone" maxlength="20" placeholder="Optional">
                            </div>
                        </div>

                        <div class="row g-2 mb-3">
                            <div class="col-sm-6">
                                <label for="discount" class="form-label small mb-1">Discount (<?= e(CURRENCY) ?>)</label>
                                <input type="number" class="form-control form-control-sm" id="discount"
                                       name="discount" min="0" max="<?= e(number_format($cart_total, 2, '.', '')) ?>"
                                       step="0.01" value="0">
                            </div>
                            <div class="col-sm-6">
                                <label for="payment_method" class="form-label small mb-1">Payment Method</label>
                                <select class="form-select form-select-sm" id="payment_method" name="payment_method" required>
                                    <?php foreach ($payment_methods as $method): ?>
                                        <option value="<?= e($method) ?>"><?= e($method) ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between small mb-1">
                            <span class="text-muted">Subtotal</span>
                            <span><?= e(format_money($cart_total)) ?></span>
                        </div>
                        <div class="d-flex justify-content-between small mb-1">
                            <span class="text-muted">Discount</span>
                            <span id="discount-display"><?= e(format_money(0)) ?></span>
                        </div>
                        <div class="d-flex justify-content-between fs-5 fw-bold border-top pt-2 mb-3">
                            <span>Grand Total</span>
                            <span id="grand-total-display"><?= e(format_money($cart_total)) ?></span>
                        </div>

                        <button type="submit" class="btn btn-success w-100">
                            <i class="bi bi-check2-circle me-1"></i>Complete Sale
                        </button>
                    </form>
                </div>
            <?php else: ?>
                <div class="card-body text-center text-muted py-5">
                    <i class="bi bi-cart-x fs-2 d-block mb-2"></i>
                    The cart is empty. Search for a medicine and add it.
                </div>
            <?php endif; ?>
        </div>
    </div>
</div>

<script>
(function () {
    var subtotal = <?= (float) $cart_total ?>;
    var discount = document.getElementById('discount');
    var discountDisplay = document.getElementById('discount-display');
    var totalDisplay = document.getElementById('grand-total-display');

    if (!discount) {
        return;
    }

    function money(value) {
        return '<?= e(CURRENCY) ?> ' + value.toFixed(2);
    }

    function updateTotals() {
        var value = parseFloat(discount.value) || 0;
        if (value < 0) {
            value = 0;
        }
        if (value > subtotal) {
            value = subtotal;
        }
        discountDisplay.textContent = money(value);
        totalDisplay.textContent = money(subtotal - value);
    }

    discount.addEventListener('input', updateTotals);
})();
</script>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
