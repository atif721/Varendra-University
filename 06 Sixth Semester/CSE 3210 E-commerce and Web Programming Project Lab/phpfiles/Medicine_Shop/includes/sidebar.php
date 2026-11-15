<?php
/**
 * Sidebar navigation. Opens the main content wrapper that footer.php closes.
 */

require_once __DIR__ . '/functions.php';

$script   = str_replace('\\', '/', $_SERVER['SCRIPT_NAME'] ?? '');
$base     = rtrim(BASE_URL, '/');
$relative = trim(substr($script, strlen($base)), '/');

$activeDashboard = ($relative === 'index.php');
$activeCategories = strpos($relative, 'categories/') === 0;
$activeProducts   = strpos($relative, 'products/') === 0;
$activeBilling    = strpos($relative, 'billing/') === 0;
$activeSales      = strpos($relative, 'sales/') === 0;
$activeInvoices   = strpos($relative, 'invoices/') === 0;
$activeReports    = strpos($relative, 'reports/') === 0;

$error   = get_flash('error');
$success = get_flash('success');
$warning = get_flash('warning');
?>
<div class="app-shell d-flex">
    <aside class="app-sidebar">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link<?= $activeDashboard ? ' active' : '' ?>" href="<?= url('index.php') ?>">
                    <i class="bi bi-speedometer2 me-2"></i>Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link<?= $activeCategories ? ' active' : '' ?>" href="<?= url('categories/index.php') ?>">
                    <i class="bi bi-tags me-2"></i>Categories
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link<?= $activeProducts ? ' active' : '' ?>" href="<?= url('products/index.php') ?>">
                    <i class="bi bi-box-seam me-2"></i>Products
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link<?= $activeBilling ? ' active' : '' ?>" href="<?= url('billing/index.php') ?>">
                    <i class="bi bi-cart3 me-2"></i>Billing (POS)
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link<?= $activeSales ? ' active' : '' ?>" href="<?= url('sales/index.php') ?>">
                    <i class="bi bi-receipt me-2"></i>Sales History
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link<?= $activeReports ? ' active' : '' ?>" href="<?= url('reports/profit_loss.php') ?>">
                    <i class="bi bi-graph-up-arrow me-2"></i>Profit / Loss
                </a>
            </li>
            <li class="nav-item mt-3">
                <a class="nav-link" href="<?= url('auth/change_password.php') ?>">
                    <i class="bi bi-key me-2"></i>Change Password
                </a>
            </li>
        </ul>
    </aside>

    <main class="app-main flex-grow-1">
        <?php if ($error): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <?= e($error) ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>

        <?php if ($success): ?>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <?= e($success) ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>

        <?php if ($warning): ?>
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <?= e($warning) ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>
