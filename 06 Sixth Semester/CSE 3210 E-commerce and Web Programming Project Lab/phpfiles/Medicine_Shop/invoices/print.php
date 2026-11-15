<?php
/**
 * Printable customer invoice.
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
    set_flash('error', 'Invoice not found.');
    redirect('sales/index.php');
}

$items = mysqli_query($conn, "SELECT * FROM sale_items WHERE sale_id = $id ORDER BY id ASC");

$pageTitle = 'Invoice ' . $sale['invoice_no'];
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4 no-print">
    <div>
        <h1 class="page-title h4 mb-1">Invoice</h1>
        <p class="text-muted small mb-0"><?= e($sale['invoice_no']) ?></p>
    </div>
    <div class="d-flex gap-2">
        <a href="<?= url('sales/view.php?id=' . (int) $sale['id']) ?>" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-receipt me-1"></i>Bill Details
        </a>
        <a href="<?= url('sales/index.php') ?>" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Sales History
        </a>
        <button type="button" class="btn btn-success btn-sm" data-print>
            <i class="bi bi-printer me-1"></i>Print Invoice
        </button>
    </div>
</div>

<div class="card invoice-box mx-auto">
    <div class="card-body p-4 p-md-5">
        <div class="d-flex flex-wrap justify-content-between gap-3 border-bottom pb-3 mb-4">
            <div>
                <h2 class="h4 mb-1 text-success"><?= e(SHOP_NAME) ?></h2>
                <div class="small text-muted"><?= e(SHOP_ADDRESS) ?></div>
                <div class="small text-muted">Phone: <?= e(SHOP_PHONE) ?></div>
            </div>
            <div class="text-md-end">
                <div class="h5 mb-1">INVOICE</div>
                <div class="small"><strong>No:</strong> <?= e($sale['invoice_no']) ?></div>
                <div class="small"><strong>Date:</strong> <?= e(date('d M Y, h:i A', strtotime($sale['created_at']))) ?></div>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-sm-6">
                <div class="small text-muted mb-1">Billed To</div>
                <div class="fw-semibold"><?= $sale['customer_name'] !== null && $sale['customer_name'] !== '' ? e($sale['customer_name']) : 'Walk-in Customer' ?></div>
                <?php if ($sale['customer_phone'] !== null && $sale['customer_phone'] !== ''): ?>
                    <div class="small text-muted"><?= e($sale['customer_phone']) ?></div>
                <?php endif; ?>
            </div>
            <div class="col-sm-6 text-sm-end">
                <div class="small text-muted mb-1">Served By</div>
                <div><?= e($sale['cashier_name'] ?? 'Admin') ?></div>
                <div class="small text-muted">Payment: <?= e($sale['payment_method']) ?></div>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-borderless align-middle mb-0">
                <thead class="border-top border-bottom">
                    <tr>
                        <th class="text-muted small text-uppercase">SL</th>
                        <th class="text-muted small text-uppercase">Medicine</th>
                        <th class="text-center text-muted small text-uppercase">Qty</th>
                        <th class="text-end text-muted small text-uppercase">Unit Price</th>
                        <th class="text-end text-muted small text-uppercase">Amount</th>
                    </tr>
                </thead>
                <tbody>
                <?php $sl = 1; while ($item = mysqli_fetch_assoc($items)): ?>
                    <tr class="border-bottom">
                        <td><?= $sl++ ?></td>
                        <td>
                            <div class="fw-semibold"><?= e($item['product_name']) ?></div>
                        </td>
                        <td class="text-center"><?= (int) $item['quantity'] ?></td>
                        <td class="text-end"><?= e(format_money($item['unit_price'])) ?></td>
                        <td class="text-end"><?= e(format_money($item['line_total'])) ?></td>
                    </tr>
                <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <div class="row justify-content-end mt-3">
            <div class="col-sm-7 col-md-5">
                <div class="d-flex justify-content-between py-1">
                    <span class="text-muted">Subtotal</span>
                    <span><?= e(format_money($sale['subtotal'])) ?></span>
                </div>
                <div class="d-flex justify-content-between py-1">
                    <span class="text-muted">Discount</span>
                    <span>- <?= e(format_money($sale['discount'])) ?></span>
                </div>
                <div class="d-flex justify-content-between border-top pt-2 mt-1 fs-5 fw-bold">
                    <span>Grand Total</span>
                    <span><?= e(format_money($sale['grand_total'])) ?></span>
                </div>
            </div>
        </div>

        <div class="border-top mt-4 pt-3 text-center small text-muted">
            Thank you for your purchase. Medicines are not returnable after they leave the counter.
        </div>
    </div>
</div>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
