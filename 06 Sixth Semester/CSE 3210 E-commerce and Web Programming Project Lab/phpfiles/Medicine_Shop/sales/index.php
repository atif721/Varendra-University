<?php
/**
 * Sales history with optional date range filter.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

$from = valid_date($_GET['from'] ?? '');
$to   = valid_date($_GET['to'] ?? '');

$conditions = [];

if ($from !== '') {
    $conditions[] = "DATE(s.created_at) >= '$from'";
}

if ($to !== '') {
    $conditions[] = "DATE(s.created_at) <= '$to'";
}

$where = $conditions ? 'WHERE ' . implode(' AND ', $conditions) : '';

$summary_result = mysqli_query(
    $conn,
    "SELECT COUNT(*) AS bills,
            COALESCE(SUM(s.subtotal), 0) AS subtotal,
            COALESCE(SUM(s.discount), 0) AS discount,
            COALESCE(SUM(s.grand_total), 0) AS total
     FROM sales s
     $where"
);

$summary = $summary_result ? mysqli_fetch_assoc($summary_result) : ['bills' => 0, 'subtotal' => 0, 'discount' => 0, 'total' => 0];

$sales = mysqli_query(
    $conn,
    "SELECT s.*, a.full_name AS cashier_name,
            (SELECT COALESCE(SUM(si.quantity), 0) FROM sale_items si WHERE si.sale_id = s.id) AS item_count
     FROM sales s
     LEFT JOIN admins a ON a.id = s.sold_by
     $where
     ORDER BY s.created_at DESC"
);

$pageTitle = 'Sales History';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <h1 class="page-title h4 mb-1">Sales History</h1>
        <p class="text-muted small mb-0">Browse saved bills and filter them by date.</p>
    </div>
    <a href="<?= url('billing/index.php') ?>" class="btn btn-success">
        <i class="bi bi-cart-plus me-1"></i>New Sale
    </a>
</div>

<div class="card mb-3">
    <div class="card-body py-3">
        <form method="get" action="<?= url('sales/index.php') ?>" class="row g-2 align-items-end">
            <div class="col-sm-4 col-md-3">
                <label for="from" class="form-label small text-muted mb-1">From Date</label>
                <input type="date" class="form-control" id="from" name="from" value="<?= e($from) ?>">
            </div>
            <div class="col-sm-4 col-md-3">
                <label for="to" class="form-label small text-muted mb-1">To Date</label>
                <input type="date" class="form-control" id="to" name="to" value="<?= e($to) ?>">
            </div>
            <div class="col-sm-4 col-md-6 d-flex flex-wrap gap-2">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-funnel me-1"></i>Filter
                </button>
                <a href="<?= url('sales/index.php') ?>" class="btn btn-outline-secondary">Reset</a>
                <a href="<?= url('sales/index.php?from=' . date('Y-m-d') . '&to=' . date('Y-m-d')) ?>"
                   class="btn btn-outline-success">Today</a>
            </div>
        </form>
    </div>
</div>

<div class="row g-3 mb-3">
    <div class="col-sm-4">
        <div class="card stat-card">
            <div class="card-body">
                <p class="text-muted small mb-1">Bills</p>
                <div class="stat-value"><?= (int) $summary['bills'] ?></div>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="card stat-card">
            <div class="card-body">
                <p class="text-muted small mb-1">Discount Given</p>
                <div class="stat-value"><?= e(format_money($summary['discount'])) ?></div>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="card stat-card">
            <div class="card-body">
                <p class="text-muted small mb-1">Sales Total</p>
                <div class="stat-value"><?= e(format_money($summary['total'])) ?></div>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th>Invoice</th>
                    <th>Date &amp; Time</th>
                    <th>Customer</th>
                    <th class="text-center">Items</th>
                    <th>Payment</th>
                    <th class="text-end">Grand Total</th>
                    <th class="text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
            <?php if ($sales && mysqli_num_rows($sales) > 0): ?>
                <?php while ($row = mysqli_fetch_assoc($sales)): ?>
                    <tr>
                        <td class="fw-semibold"><?= e($row['invoice_no']) ?></td>
                        <td class="small"><?= e(date('d M Y, h:i A', strtotime($row['created_at']))) ?></td>
                        <td>
                            <?= $row['customer_name'] !== null && $row['customer_name'] !== '' ? e($row['customer_name']) : 'Walk-in' ?>
                            <?php if ($row['customer_phone'] !== null && $row['customer_phone'] !== ''): ?>
                                <div class="small text-muted"><?= e($row['customer_phone']) ?></div>
                            <?php endif; ?>
                        </td>
                        <td class="text-center"><?= (int) $row['item_count'] ?></td>
                        <td><span class="badge text-bg-light border"><?= e($row['payment_method']) ?></span></td>
                        <td class="text-end fw-semibold"><?= e(format_money($row['grand_total'])) ?></td>
                        <td class="text-end text-nowrap">
                            <a href="<?= url('sales/view.php?id=' . (int) $row['id']) ?>"
                               class="btn btn-sm btn-outline-secondary" title="View bill">
                                <i class="bi bi-eye"></i>
                            </a>
                            <a href="<?= url('invoices/print.php?id=' . (int) $row['id']) ?>"
                               class="btn btn-sm btn-outline-primary" title="Invoice">
                                <i class="bi bi-printer"></i>
                            </a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="7" class="text-center text-muted py-4">
                        No sales found<?= $from !== '' || $to !== '' ? ' for the selected dates' : '' ?>.
                    </td>
                </tr>
            <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
