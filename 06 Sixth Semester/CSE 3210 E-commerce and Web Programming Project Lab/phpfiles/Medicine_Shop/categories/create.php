<?php
/**
 * Add a category.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

$errors      = [];
$name        = '';
$description = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name        = trim($_POST['name'] ?? '');
    $description = trim($_POST['description'] ?? '');

    if ($name === '') {
        $errors[] = 'Category name is required.';
    } elseif (mb_strlen($name) > 100) {
        $errors[] = 'Category name cannot be longer than 100 characters.';
    }

    if (mb_strlen($description) > 255) {
        $errors[] = 'Description cannot be longer than 255 characters.';
    }

    if (!$errors) {
        $name_esc = mysqli_real_escape_string($conn, $name);
        $check    = mysqli_query($conn, "SELECT id FROM categories WHERE name = '$name_esc' LIMIT 1");

        if ($check && mysqli_num_rows($check) > 0) {
            $errors[] = 'A category with this name already exists.';
        }
    }

    if (!$errors) {
        $desc_esc = mysqli_real_escape_string($conn, $description);

        if (mysqli_query($conn, "INSERT INTO categories (name, description) VALUES ('$name_esc', '$desc_esc')")) {
            set_flash('success', 'Category "' . $name . '" added successfully.');
            redirect('categories/index.php');
        }

        $errors[] = 'The category could not be saved. Please try again.';
    }
}

$pageTitle = 'Add Category';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <h1 class="page-title h4 mb-0">Add Category</h1>
    <a href="<?= url('categories/index.php') ?>" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left me-1"></i>Back to Categories
    </a>
</div>

<div class="row">
    <div class="col-lg-6">
        <?php if ($errors): ?>
            <div class="alert alert-danger">
                <ul class="mb-0 ps-3">
                    <?php foreach ($errors as $error): ?><li><?= e($error) ?></li><?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <div class="card">
            <div class="card-body">
                <form method="post" action="<?= url('categories/create.php') ?>">
                    <div class="mb-3">
                        <label for="name" class="form-label">Category Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="name" name="name"
                               maxlength="100" value="<?= e($name) ?>" required autofocus>
                    </div>

                    <div class="mb-4">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description"
                                  rows="3" maxlength="255"><?= e($description) ?></textarea>
                    </div>

                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check2-circle me-1"></i>Save Category
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
