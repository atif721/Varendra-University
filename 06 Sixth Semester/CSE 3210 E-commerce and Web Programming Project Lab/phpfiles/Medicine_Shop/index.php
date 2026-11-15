<?php
/**
 * Dashboard - today's sales, profit, low stock and expiry overview.
 */

require_once __DIR__ . '/config/db.php';
require_once __DIR__ . '/includes/auth.php';

/* Today's sales and profit */
$today_result = mysqli_query(
    $conn,
    "SELECT COUNT(*) AS bills,
            COALESCE(SUM(grand_total), 0) AS revenue,
            COALESCE(SUM(total_cost), 0) AS cost
     FROM sales
     WHERE DATE(created_at) = CURDATE()"
);
$today = $today_result
    ? mysqli_fetch_assoc($today_result)
    : ['bills' => 0, 'revenue' => 0, 'cost' => 0];

$today_profit = (float) $today['revenue'] - (float) $today['cost'];

/* Counters */
$low_stock_count = (int) mysqli_fetch_assoc(
    mysqli_query($conn, "SELECT COUNT(*) AS total FROM products WHERE stock <= reorder_level")
)['total'];

$expired_count = (int) mysqli_fetch_assoc(
    mysqli_query($conn, "SELECT COUNT(*) AS total FROM products WHERE expiry_date < CURDATE()")
)['total'];

$expiring_count = (int) mysqli_fetch_assoc(
    mysqli_query(
        $conn,
        "SELECT COUNT(*) AS total FROM products
         WHERE expiry_date >= CURDATE()
           AND expiry_date <= DATE_ADD(CURDATE(), INTERVAL 60 DAY)"
    )
)['total'];

$product_count = (int) mysqli_fetch_assoc(
    mysqli_query($conn, "SELECT COUNT(*) AS total FROM products")
)['total'];

/* Low stock products */
$low_stock = mysqli_query(
    $conn,
    "SELECT p.*, c.name AS category_name
     FROM products p
     INNER JOIN categories c ON c.id = p.category_id
     WHERE p.stock <= p.reorder_level
     ORDER BY p.stock ASC, p.name ASC
     LIMIT 8"
);

/* Expired and expiring medicines */
$expiring = mysqli_query(
    $conn,
    "SELECT p.*, c.name AS category_name
     FROM products p
     INNER JOIN categories c ON c.id = p.category_id
     WHERE p.expiry_date <= DATE_ADD(CURDATE(), INTERVAL 60 DAY)
     ORDER BY p.expiry_date ASC
     LIMIT 8"
);

/* Products per category */
$category_counts = mysqli_query(
    $conn,
    "SELECT c.id, c.name, COUNT(p.id) AS product_count
     FROM categories c
     LEFT JOIN products p ON p.category_id = c.id
     GROUP BY c.id, c.name
     ORDER BY c.name ASC"
);

$max_category_count = 0;
$category_rows      = [];

while ($category_counts && ($row = mysqli_fetch_assoc($category_counts))) {
    $max_category_count = max($max_category_count, (int) $row['product_count']);
    $category_rows[]    = $row;
}

/* Recent sales */
$recent_sales = mysqli_query(
    $conn,
    "SELECT id, invoice_no, customer_name, grand_total, payment_method, created_at
     FROM sales
     ORDER BY created_at DESC
     LIMIT 6"
);

$pageTitle = 'Dashboard';
require_once __DIR__ . '/includes/header.php';
require_once __DIR__ . '/includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <h1 class="page-title h4 mb-1">Dashboard</h1>
        <p class="text-muted small mb-0"><?= date('l, d F Y') ?></p>
    </div>
    <a href="<?= url('billing/index.php') ?>" class="btn btn-success">
        <i class="bi bi-cart-plus me-1"></i>New Sale
    </a>
</div>

<div class="row g-3 mb-4">
    <div class="col-sm-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body">
                <p class="text-muted small mb-1">Today's Sales</p>
                <div class="stat-value"><?= e(format_money($today['revenue'])) ?></div>
                <div class="small text-muted"><?= (int) $today['bills'] ?> bill(s) today</div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body">
                <p class="text-muted small mb-1">Today's Profit</p>
                <div class="stat-value <?= $today_profit < 0 ? 'text-danger' : 'text-success' ?>">
                    <?= e(format_money(abs($today_profit))) ?>
                </div>
                <div class="small text-muted"><?= $today_profit < 0 ? 'Loss today' : 'Profit today' ?></div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body">
                <p class="text-muted small mb-1">Low Stock Products</p>
                <div class="stat-value"><?= $low_stock_count ?></div>
                <div class="small text-muted">Of <?= $product_count ?> product(s) in total</div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body">
                <p class="text-muted small mb-1">Expired Medicines</p>
                <div class="stat-value <?= $expired_count > 0 ? 'text-danger' : '' ?>"><?= $expired_count ?></div>
                <div class="small text-muted"><?= $expiring_count ?> expiring within 60 days</div>
            </div>
        </div>
    </div>
</div>

<div class="row g-3 mb-3">
    <div class="col-xl-7">
        <div class="card h-100">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <span class="fw-semibold"><i class="bi bi-exclamation-triangle me-1 text-warning"></i>Low Stock Products</span>
                <a href="<?= url('products/index.php') ?>" class="small text-decoration-none">All products</a>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Medicine</th>
                            <th>Category</th>
                            <th class="text-center">Stock</th>
                            <th class="text-center">Reorder</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php if ($low_stock && mysqli_num_rows($low_stock) > 0): ?>
                        <?php while ($row = mysqli_fetch_assoc($low_stock)): ?>
                            <tr>
                                <td>
                                    <a href="<?= url('products/edit.php?id=' . (int) $row['id']) ?>"
                                       class="fw-semibold text-decoration-none"><?= e($row['name']) ?></a>
                                </td>
                                <td class="small text-muted"><?= e($row['category_name']) ?></td>
                                <td class="text-center">
                                    <span class="badge <?= (int) $row['stock'] === 0 ? 'text-bg-danger' : 'text-bg-warning' ?>">
                                        <?= (int) $row['stock'] ?>
                                    </span>
                                </td>
                                <td class="text-center small text-muted"><?= (int) $row['reorder_level'] ?></td>
                            </tr>
                        <?php endwhile; ?>
                    <?php else: ?>
                        <tr><td colspan="4" class="text-center text-muted py-4">No low-stock products.</td></tr>
                    <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="col-xl-5">
        <div class="card h-100">
            <div class="card-header bg-white fw-semibold">
                <i class="bi bi-calendar-x me-1 text-danger"></i>Expiry Watch
            </div>
            <div class="list-group list-group-flush">
                <?php if ($expiring && mysqli_num_rows($expiring) > 0): ?>
                    <?php while ($row = mysqli_fetch_assoc($expiring)): ?>
                        <?php $status = expiry_status($row['expiry_date']); ?>
                        <div class="list-group-item d-flex justify-content-between align-items-start gap-2">
                            <div>
                                <div class="fw-semibold small"><?= e($row['name']) ?></div>
                                <div class="text-muted small">
                                    <?= e($row['category_name']) ?> &middot;
                                    <?= e(date('d M Y', strtotime($row['expiry_date']))) ?>
                                </div>
                            </div>
                            <span class="badge <?= $status === 'expired' ? 'text-bg-danger' : 'text-bg-warning' ?>">
                                <?= $status === 'expired' ? 'Expired' : 'Soon' ?>
                            </span>
                        </div>
                    <?php endwhile; ?>
                <?php else: ?>
                    <div class="list-group-item text-center text-muted py-4">
                        No expired or soon-to-expire medicines.
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<div class="row g-3">
    <div class="col-xl-5">
        <div class="card h-100">
            <div class="card-header bg-white fw-semibold">
                <i class="bi bi-tags me-1"></i>Products per Category
            </div>
            <div class="card-body">
                <?php if ($category_rows): ?>
                    <?php foreach ($category_rows as $row): ?>
                        <?php
                        $count = (int) $row['product_count'];
                        $width = $max_category_count > 0 ? round(($count / $max_category_count) * 100) : 0;
                        ?>
                        <div class="mb-2">
                            <div class="d-flex justify-content-between small mb-1">
                                <span><?= e($row['name']) ?></span>
                                <span class="text-muted"><?= $count ?></span>
                            </div>
                            <div class="progress" style="height: 6px;">
                                <div class="progress-bar bg-success" style="width: <?= $width ?>%"></div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                <?php else: ?>
                    <p class="text-muted mb-0">No categories yet.</p>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <div class="col-xl-7">
        <div class="card h-100">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <span class="fw-semibold"><i class="bi bi-clock-history me-1"></i>Recent Sales</span>
                <a href="<?= url('sales/index.php') ?>" class="small text-decoration-none">Sales history</a>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Invoice</th>
                            <th>Customer</th>
                            <th>Payment</th>
                            <th class="text-end">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php if ($recent_sales && mysqli_num_rows($recent_sales) > 0): ?>
                        <?php while ($row = mysqli_fetch_assoc($recent_sales)): ?>
                            <tr>
                                <td>
                                    <a href="<?= url('sales/view.php?id=' . (int) $row['id']) ?>"
                                       class="text-decoration-none fw-semibold"><?= e($row['invoice_no']) ?></a>
                                    <div class="text-muted small"><?= e(date('d M, h:i A', strtotime($row['created_at']))) ?></div>
                                </td>
                                <td class="small"><?= $row['customer_name'] !== null && $row['customer_name'] !== '' ? e($row['customer_name']) : 'Walk-in' ?></td>
                                <td class="small"><span class="badge text-bg-light border"><?= e($row['payment_method']) ?></span></td>
                                <td class="text-end fw-semibold"><?= e(format_money($row['grand_total'])) ?></td>
                            </tr>
                        <?php endwhile; ?>
                    <?php else: ?>
                        <tr><td colspan="4" class="text-center text-muted py-4">No sales recorded yet.</td></tr>
                    <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<?php require_once __DIR__ . '/includes/footer.php'; ?>
