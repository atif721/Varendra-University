<?php
/**
 * Delete a category. Only POST requests are accepted.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('categories/index.php');
}

$id       = (int) ($_POST['id'] ?? 0);
$category = get_category($conn, $id);

if (!$category) {
    set_flash('error', 'Category not found.');
    redirect('categories/index.php');
}

$count_result = mysqli_query($conn, "SELECT COUNT(*) AS total FROM products WHERE category_id = $id");
$count        = $count_result ? (int) mysqli_fetch_assoc($count_result)['total'] : 0;

if ($count > 0) {
    set_flash('error', 'This category cannot be deleted because ' . $count . ' product(s) use it.');
    redirect('categories/index.php');
}

if (mysqli_query($conn, "DELETE FROM categories WHERE id = $id")) {
    set_flash('success', 'Category "' . $category['name'] . '" deleted successfully.');
} else {
    set_flash('error', 'The category could not be deleted.');
}

redirect('categories/index.php');
