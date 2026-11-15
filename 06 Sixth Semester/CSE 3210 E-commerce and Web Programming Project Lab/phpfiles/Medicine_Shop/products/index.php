<?php
/**
 * Product list with name search and category filter.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

$q           = trim($_GET['q'] ?? '');
$category_id = (int) ($_GET['category_id'] ?? 0);

$conditions = [];

if ($q !== '') {
    $like         = mysqli_real_escape_string($conn, $q);
    $conditions[] = "(p.name LIKE '%$like%' OR p.generic_name LIKE '%$like%')";
}

if ($category_id > 0) {
    $conditions[] = "p.category_id = $category_id";
}

$where = $conditions ? 'WHERE ' . implode(' AND ', $conditions) : '';

$products = mysqli_query(
    $conn,
    "SELECT p.*, c.name AS category_name
     FROM products p
     INNER JOIN categories c ON c.id = p.category_id
     $where
     ORDER BY p.name ASC"
);

$categories = mysqli_query($conn, "SELECT id, name FROM categories ORDER BY name ASC");

$pageTitle = 'Products';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <h1 class="page-title h4 mb-1">Products</h1>
        <p class="text-muted small mb-0">Manage medicines, prices, stock and expiry dates.</p>
    </div>
    <a href="<?= url('products/create.php') ?>" class="btn btn-success">
        <i class="bi bi-plus-lg me-1"></i>Add Product
    </a>
</div>

<div class="card mb-3">
    <div class="card-body py-3">
        <form method="get" action="<?= url('products/index.php') ?>" class="row g-2 align-items-end">
            <div class="col-md-5">
                <label for="q" class="form-label small text-muted mb-1">Search by name or generic name</label>
                <input type="text" class="form-control" id="q" name="q"
                       value="<?= e($q) ?>" placeholder="e.g. Paracetamol">
            </div>

            <div class="col-md-4">
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

            <div class="col-md-3 d-flex gap-2">
                <button type="submit" class="btn btn-success flex-grow-1">
                    <i class="bi bi-search me-1"></i>Filter
                </button>
                <a href="<?= url('products/index.php') ?>" class="btn btn-outline-secondary">Reset</a>
            </div>
        </form>
    </div>
</div>

<div class="card">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th>Product</th>
                    <th>Category</th>
                    <th class="text-end">Cost</th>
                    <th class="text-end">Selling</th>
                    <th class="text-end">MRP</th>
                    <th class="text-center">Stock</th>
                    <th>Expiry</th>
                    <th class="text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
            <?php if ($products && mysqli_num_rows($products) > 0): ?>
                <?php while ($row = mysqli_fetch_assoc($products)): ?>
                    <?php
                    $status      = expiry_status($row['expiry_date']);
                    $low_stock   = (int) $row['stock'] <= (int) $row['reorder_level'];
                    $mrp_warning = (float) $row['selling_price'] > (float) $row['mrp'];
                    ?>
                    <tr>
                        <td>
                            <div class="fw-semibold"><?= e($row['name']) ?></div>
                            <div class="small text-muted">
                                <?= $row['generic_name'] !== null && $row['generic_name'] !== '' ? e($row['generic_name']) : '&mdash;' ?>
                            </div>
                        </td>
                        <td><?= e($row['category_name']) ?></td>
                        <td class="text-end"><?= e(format_money($row['cost_price'])) ?></td>
                        <td class="text-end">
                            <?= e(format_money($row['selling_price'])) ?>
                            <?php if ($mrp_warning): ?>
                                <i class="bi bi-exclamation-triangle text-warning" title="Selling price is higher than MRP"></i>
                            <?php endif; ?>
                        </td>
                        <td class="text-end"><?= e(format_money($row['mrp'])) ?></td>
                        <td class="text-center">
                            <span class="badge <?= (int) $row['stock'] === 0 ? 'text-bg-danger' : ($low_stock ? 'text-bg-warning' : 'text-bg-light border') ?>">
                                <?= (int) $row['stock'] ?> <?= e($row['unit']) ?>
                            </span>
                            <div class="small text-muted">Reorder: <?= (int) $row['reorder_level'] ?></div>
                        </td>
                        <td>
                            <?= e(date('d M Y', strtotime($row['expiry_date']))) ?>
                            <?php if ($status === 'expired'): ?>
                                <div><span class="badge text-bg-danger">Expired</span></div>
                            <?php elseif ($status === 'expiring'): ?>
                                <div><span class="badge text-bg-warning">Expiring soon</span></div>
                            <?php endif; ?>
                        </td>
                        <td class="text-end text-nowrap">
                            <a href="<?= url('products/edit.php?id=' . (int) $row['id']) ?>"
                               class="btn btn-sm btn-outline-primary">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <form method="post" action="<?= url('products/delete.php') ?>" class="d-inline"
                                  onsubmit="return confirm('Delete this product? Past sales keep their own product details.');">
                                <input type="hidden" name="id" value="<?= (int) $row['id'] ?>">
                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="8" class="text-center text-muted py-4">
                        No products found<?= $q !== '' || $category_id > 0 ? ' for the selected filters' : '' ?>.
                        <a href="<?= url('products/create.php') ?>">Add a product</a>.
                    </td>
                </tr>
            <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
