<?php
/**
 * Edit a product.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

$id      = (int) ($_POST['id'] ?? $_GET['id'] ?? 0);
$product = get_product($conn, $id);

if (!$product) {
    set_flash('error', 'Product not found.');
    redirect('products/index.php');
}

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    foreach (['name', 'generic_name', 'unit', 'cost_price', 'selling_price', 'mrp', 'stock', 'reorder_level', 'expiry_date'] as $field) {
        $product[$field] = trim($_POST[$field] ?? '');
    }
    $product['category_id'] = (int) ($_POST['category_id'] ?? 0);

    if ($product['name'] === '') {
        $errors[] = 'Product name is required.';
    }

    if (!get_category($conn, $product['category_id'])) {
        $errors[] = 'Please select a valid category.';
    }

    if ($product['unit'] === '') {
        $errors[] = 'Unit is required.';
    }

    $expiry = valid_date($product['expiry_date']);
    if ($expiry === '') {
        $errors[] = 'A valid expiry date is required.';
    }

    foreach (['cost_price', 'selling_price', 'mrp'] as $price_field) {
        if (!is_numeric($product[$price_field]) || (float) $product[$price_field] < 0) {
            $errors[] = ucwords(str_replace('_', ' ', $price_field)) . ' must be zero or a positive number.';
        }
    }

    $stock         = filter_var($product['stock'], FILTER_VALIDATE_INT, ['options' => ['min_range' => 0]]);
    $reorder_level = filter_var($product['reorder_level'], FILTER_VALIDATE_INT, ['options' => ['min_range' => 0]]);

    if ($stock === false) {
        $errors[] = 'Stock must be a whole number (0 or more).';
    }

    if ($reorder_level === false) {
        $errors[] = 'Reorder level must be a whole number (0 or more).';
    }

    if (!$errors) {
        $name     = mysqli_real_escape_string($conn, $product['name']);
        $generic  = mysqli_real_escape_string($conn, $product['generic_name']);
        $unit     = mysqli_real_escape_string($conn, $product['unit']);
        $category = (int) $product['category_id'];
        $cost     = (float) $product['cost_price'];
        $selling  = (float) $product['selling_price'];
        $mrp      = (float) $product['mrp'];

        $sql = "UPDATE products SET
                    name = '$name',
                    generic_name = '$generic',
                    category_id = $category,
                    unit = '$unit',
                    cost_price = $cost,
                    selling_price = $selling,
                    mrp = $mrp,
                    stock = $stock,
                    reorder_level = $reorder_level,
                    expiry_date = '$expiry'
                WHERE id = $id";

        if (mysqli_query($conn, $sql)) {
            set_flash('success', 'Product "' . $product['name'] . '" updated successfully.');

            if ($selling > $mrp) {
                set_flash('warning', 'Selling price is higher than the printed MRP for "' . $product['name'] . '".');
            }

            redirect('products/index.php');
        }

        $errors[] = 'The product could not be updated. Please try again.';
    }
}

$categories = mysqli_query($conn, "SELECT id, name FROM categories ORDER BY name ASC");

$pageTitle = 'Edit Product';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <h1 class="page-title h4 mb-0">Edit Product</h1>
    <a href="<?= url('products/index.php') ?>" class="btn btn-outline-secondary btn-sm">
        <i class="bi bi-arrow-left me-1"></i>Back to Products
    </a>
</div>

<?php
$form_action = url('products/edit.php?id=' . $id);
require __DIR__ . '/_form.php';
?>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
