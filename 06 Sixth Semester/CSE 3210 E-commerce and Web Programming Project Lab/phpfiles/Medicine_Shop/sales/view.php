<?php
/**
 * View a single bill with its sold items.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

$id = (int) ($_GET['id'] ?? 0);

$sale_result = mysqli_query(
    $conn,
    "SELECT s.*, a.full_name AS cashier_name
     FROM sales s
     LEFT JOIN admins a ON a.id = s.sold_by
     WHERE s.id = $id
     LIMIT 1"
);

$sale = $sale_result ? mysqli_fetch_assoc($sale_result) : null;

if (!$sale) {
    set_flash('error', 'Bill not found.');
    redirect('sales/index.php');
}

$items = mysqli_query($conn, "SELECT * FROM sale_items WHERE sale_id = $id ORDER BY id ASC");

$pageTitle = 'Bill ' . $sale['invoice_no'];
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <h1 class="page-title h4 mb-1">Bill Details</h1>
        <p class="text-muted small mb-0"><?= e($sale['invoice_no']) ?></p>
    </div>
    <div class="d-flex gap-2">
        <a href="<?= url('sales/index.php') ?>" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Back to Sales
        </a>
        <a href="<?= url('invoices/print.php?id=' . (int) $sale['id']) ?>" class="btn btn-success btn-sm">
            <i class="bi bi-printer me-1"></i>Print Invoice
        </a>
    </div>
</div>

<div class="row g-3">
    <div class="col-lg-8">
        <div class="card">
            <div class="card-header bg-white fw-semibold">Sold Items</div>
            <div class="table-responsive">
                <table class="table align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Medicine</th>
                            <th class="text-center">Qty</th>
                            <th class="text-end">Unit Price</th>
                            <th class="text-end">Line Total</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php $sl = 1; while ($item = mysqli_fetch_assoc($items)): ?>
                        <tr>
                            <td class="text-muted"><?= $sl++ ?></td>
                            <td class="fw-semibold"><?= e($item['product_name']) ?></td>
                            <td class="text-center"><?= (int) $item['quantity'] ?></td>
                            <td class="text-end"><?= e(format_money($item['unit_price'])) ?></td>
                            <td class="text-end"><?= e(format_money($item['line_total'])) ?></td>
                        </tr>
                    <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <div class="card mb-3">
            <div class="card-header bg-white fw-semibold">Bill Summary</div>
            <div class="card-body">
                <dl class="row small mb-0">
                    <dt class="col-5 text-muted fw-normal">Invoice</dt>
                    <dd class="col-7 text-end fw-semibold"><?= e($sale['invoice_no']) ?></dd>

                    <dt class="col-5 text-muted fw-normal">Date</dt>
                    <dd class="col-7 text-end"><?= e(date('d M Y', strtotime($sale['created_at']))) ?></dd>

                    <dt class="col-5 text-muted fw-normal">Time</dt>
                    <dd class="col-7 text-end"><?= e(date('h:i A', strtotime($sale['created_at']))) ?></dd>

                    <dt class="col-5 text-muted fw-normal">Cashier</dt>
                    <dd class="col-7 text-end"><?= e($sale['cashier_name'] ?? 'Admin') ?></dd>

                    <dt class="col-5 text-muted fw-normal">Customer</dt>
                    <dd class="col-7 text-end"><?= $sale['customer_name'] !== null && $sale['customer_name'] !== '' ? e($sale['customer_name']) : 'Walk-in' ?></dd>

                    <?php if ($sale['customer_phone'] !== null && $sale['customer_phone'] !== ''): ?>
                        <dt class="col-5 text-muted fw-normal">Phone</dt>
                        <dd class="col-7 text-end"><?= e($sale['customer_phone']) ?></dd>
                    <?php endif; ?>

                    <dt class="col-5 text-muted fw-normal">Payment</dt>
                    <dd class="col-7 text-end"><?= e($sale['payment_method']) ?></dd>
                </dl>

                <hr>

                <div class="d-flex justify-content-between small mb-1">
                    <span class="text-muted">Subtotal</span>
                    <span><?= e(format_money($sale['subtotal'])) ?></span>
                </div>
                <div class="d-flex justify-content-between small mb-1">
                    <span class="text-muted">Discount</span>
                    <span>- <?= e(format_money($sale['discount'])) ?></span>
                </div>
                <div class="d-flex justify-content-between fs-5 fw-bold border-top pt-2 mt-2">
                    <span>Grand Total</span>
                    <span><?= e(format_money($sale['grand_total'])) ?></span>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header bg-white fw-semibold">Profit on this Bill</div>
            <div class="card-body">
                <?php $bill_profit = (float) $sale['grand_total'] - (float) $sale['total_cost']; ?>
                <div class="d-flex justify-content-between small mb-1">
                    <span class="text-muted">Cost of Goods</span>
                    <span><?= e(format_money($sale['total_cost'])) ?></span>
                </div>
                <div class="d-flex justify-content-between fw-semibold <?= $bill_profit < 0 ? 'text-danger' : 'text-success' ?>">
                    <span><?= $bill_profit < 0 ? 'Loss' : 'Profit' ?></span>
                    <span><?= e(format_money(abs($bill_profit))) ?></span>
                </div>
                <div class="form-text mt-2">Discount is deducted from revenue before profit is calculated.</div>
            </div>
        </div>
    </div>
</div>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
