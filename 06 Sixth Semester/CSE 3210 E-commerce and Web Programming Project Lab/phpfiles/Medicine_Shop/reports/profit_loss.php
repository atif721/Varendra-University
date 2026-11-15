<?php
/**
 * Profit / loss report for a selected date range.
 *
 * Profit = (subtotal - discount) - total cost of goods sold
 *        = grand_total - total_cost
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

$filtered = isset($_GET['from']) || isset($_GET['to']);

$from = $filtered ? valid_date($_GET['from'] ?? '') : date('Y-m-01');
$to   = $filtered ? valid_date($_GET['to'] ?? '') : date('Y-m-d');

if ($from !== '' && $to !== '' && $from > $to) {
    [$from, $to] = [$to, $from];
}

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
            COALESCE(SUM(s.grand_total), 0) AS revenue,
            COALESCE(SUM(s.total_cost), 0) AS cost
     FROM sales s
     $where"
);

$summary = $summary_result
    ? mysqli_fetch_assoc($summary_result)
    : ['bills' => 0, 'subtotal' => 0, 'discount' => 0, 'revenue' => 0, 'cost' => 0];

$profit = (float) $summary['revenue'] - (float) $summary['cost'];

$sales = mysqli_query(
    $conn,
    "SELECT s.id, s.invoice_no, s.created_at, s.subtotal, s.discount,
            s.grand_total, s.total_cost,
            (SELECT COALESCE(SUM(si.quantity), 0) FROM sale_items si WHERE si.sale_id = s.id) AS item_count
     FROM sales s
     $where
     ORDER BY s.created_at DESC"
);

$pageTitle = 'Profit / Loss Report';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <h1 class="page-title h4 mb-1">Profit / Loss Report</h1>
        <p class="text-muted small mb-0">
            <?= $from !== '' ? e(date('d M Y', strtotime($from))) : 'Beginning' ?>
            &ndash;
            <?= $to !== '' ? e(date('d M Y', strtotime($to))) : 'Today' ?>
        </p>
    </div>
    <?php if ($from !== '' || $to !== ''): ?>
        <a href="<?= url('sales/index.php?from=' . urlencode($from) . '&to=' . urlencode($to)) ?>"
           class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-receipt me-1"></i>View Bills in Range
        </a>
    <?php endif; ?>
</div>

<div class="card mb-3">
    <div class="card-body py-3">
        <form method="get" action="<?= url('reports/profit_loss.php') ?>" class="row g-2 align-items-end">
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
                    <i class="bi bi-funnel me-1"></i>Show Report
                </button>
                <a href="<?= url('reports/profit_loss.php') ?>" class="btn btn-outline-secondary">This Month</a>
                <a href="<?= url('reports/profit_loss.php?from=' . date('Y-m-d') . '&to=' . date('Y-m-d')) ?>"
                   class="btn btn-outline-success">Today</a>
            </div>
        </form>
    </div>
</div>

<div class="row g-3 mb-4">
    <div class="col-sm-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body">
                <p class="text-muted small mb-1">Sales Revenue</p>
                <div class="stat-value"><?= e(format_money($summary['revenue'])) ?></div>
                <div class="small text-muted"><?= (int) $summary['bills'] ?> bill(s)</div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body">
                <p class="text-muted small mb-1">Discount Given</p>
                <div class="stat-value"><?= e(format_money($summary['discount'])) ?></div>
                <div class="small text-muted">Subtotal <?= e(format_money($summary['subtotal'])) ?></div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card stat-card h-100">
            <div class="card-body">
                <p class="text-muted small mb-1">Cost of Goods Sold</p>
                <div class="stat-value"><?= e(format_money($summary['cost'])) ?></div>
                <div class="small text-muted">Cost prices saved with each sale</div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-xl-3">
        <div class="card stat-card h-100 border-<?= $profit < 0 ? 'danger' : 'success' ?>">
            <div class="card-body">
                <p class="text-muted small mb-1"><?= $profit < 0 ? 'Net Loss' : 'Net Profit' ?></p>
                <div class="stat-value <?= $profit < 0 ? 'text-danger' : 'text-success' ?>">
                    <?= e(format_money(abs($profit))) ?>
                </div>
                <div class="small text-muted">Revenue &minus; cost of goods</div>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header bg-white fw-semibold">Bill-wise Breakdown</div>
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th>Invoice</th>
                    <th>Date</th>
                    <th class="text-center">Qty</th>
                    <th class="text-end">Subtotal</th>
                    <th class="text-end">Discount</th>
                    <th class="text-end">Grand Total</th>
                    <th class="text-end">Cost</th>
                    <th class="text-end">Profit / Loss</th>
                </tr>
            </thead>
            <tbody>
            <?php if ($sales && mysqli_num_rows($sales) > 0): ?>
                <?php while ($row = mysqli_fetch_assoc($sales)): ?>
                    <?php $row_profit = (float) $row['grand_total'] - (float) $row['total_cost']; ?>
                    <tr>
                        <td class="fw-semibold"><?= e($row['invoice_no']) ?></td>
                        <td class="small"><?= e(date('d M Y', strtotime($row['created_at']))) ?></td>
                        <td class="text-center"><?= (int) $row['item_count'] ?></td>
                        <td class="text-end"><?= e(format_money($row['subtotal'])) ?></td>
                        <td class="text-end"><?= e(format_money($row['discount'])) ?></td>
                        <td class="text-end"><?= e(format_money($row['grand_total'])) ?></td>
                        <td class="text-end"><?= e(format_money($row['total_cost'])) ?></td>
                        <td class="text-end fw-semibold <?= $row_profit < 0 ? 'text-danger' : 'text-success' ?>">
                            <?= $row_profit < 0 ? '-' : '' ?><?= e(format_money(abs($row_profit))) ?>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="8" class="text-center text-muted py-4">No sales found in this date range.</td>
                </tr>
            <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>

<div class="alert alert-light border mt-3 small text-muted">
    <i class="bi bi-info-circle me-1"></i>
    Discount is treated as a reduction of revenue: net profit = (subtotal &minus; discount) &minus; cost of goods sold.
    The cost stored on each sold item is used, so later price changes do not alter old reports.
</div>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
