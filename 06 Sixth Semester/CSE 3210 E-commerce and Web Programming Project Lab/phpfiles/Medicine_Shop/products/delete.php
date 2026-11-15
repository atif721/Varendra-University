<?php
/**
 * Delete a product. Only POST requests are accepted.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('products/index.php');
}

$id      = (int) ($_POST['id'] ?? 0);
$product = get_product($conn, $id);

if (!$product) {
    set_flash('error', 'Product not found.');
    redirect('products/index.php');
}

if (mysqli_query($conn, "DELETE FROM products WHERE id = $id")) {
    set_flash('success', 'Product "' . $product['name'] . '" deleted successfully.');
} else {
    set_flash('error', 'The product could not be deleted.');
}

redirect('products/index.php');
