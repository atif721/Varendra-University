<?php
/**
 * Category list.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

$result = mysqli_query(
    $conn,
    "SELECT c.id, c.name, c.description, c.created_at, COUNT(p.id) AS product_count
     FROM categories c
     LEFT JOIN products p ON p.category_id = c.id
     GROUP BY c.id, c.name, c.description, c.created_at
     ORDER BY c.name ASC"
);

$pageTitle = 'Categories';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <h1 class="page-title h4 mb-1">Categories</h1>
        <p class="text-muted small mb-0">Manage medicine categories used by products.</p>
    </div>
    <a href="<?= url('categories/create.php') ?>" class="btn btn-success">
        <i class="bi bi-plus-lg me-1"></i>Add Category
    </a>
</div>

<div class="card">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th style="width: 70px;">#</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th class="text-center">Products</th>
                    <th>Created</th>
                    <th class="text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
            <?php if ($result && mysqli_num_rows($result) > 0): ?>
                <?php $i = 1; while ($row = mysqli_fetch_assoc($result)): ?>
                    <tr>
                        <td class="text-muted"><?= $i++ ?></td>
                        <td class="fw-semibold"><?= e($row['name']) ?></td>
                        <td class="text-muted"><?= $row['description'] !== null && $row['description'] !== '' ? e($row['description']) : '&mdash;' ?></td>
                        <td class="text-center">
                            <span class="badge text-bg-light border"><?= (int) $row['product_count'] ?></span>
                        </td>
                        <td class="text-muted small"><?= e(date('d M Y', strtotime($row['created_at']))) ?></td>
                        <td class="text-end">
                            <a href="<?= url('categories/edit.php?id=' . (int) $row['id']) ?>"
                               class="btn btn-sm btn-outline-primary">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <form method="post" action="<?= url('categories/delete.php') ?>" class="d-inline"
                                  onsubmit="return confirm('Delete this category? This cannot be undone.');">
                                <input type="hidden" name="id" value="<?= (int) $row['id'] ?>">
                                <button type="submit" class="btn btn-sm btn-outline-danger"
                                        <?= (int) $row['product_count'] > 0 ? 'disabled title="Categories with products cannot be deleted"' : '' ?>>
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr>
                    <td colspan="6" class="text-center text-muted py-4">
                        No categories found. <a href="<?= url('categories/create.php') ?>">Add the first category</a>.
                    </td>
                </tr>
            <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
