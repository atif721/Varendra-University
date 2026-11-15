<?php
/**
 * Global configuration for the Medicine Shop Billing System.
 * Raw PHP only - no frameworks.
 */

define('APP_NAME', 'Medicine Shop Billing System');
define('APP_SHORT_NAME', 'Medicine Shop');
define('CURRENCY', 'BDT');
define('ROOT_PATH', dirname(__DIR__));

// Shop details printed on the invoice.
define('SHOP_NAME', 'Medicine Shop');
define('SHOP_ADDRESS', '123 Main Road, Dhaka 1205');
define('SHOP_PHONE', '+880 1700-000000');

date_default_timezone_set('Asia/Dhaka');

// Start the session once for every page that loads this file.
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

/**
 * Work out the URL path of the project folder so links keep working
 * whether the project is served from htdocs root or a sub-folder.
 */
if (!defined('BASE_URL')) {
    $document_root = str_replace('\\', '/', (string) realpath($_SERVER['DOCUMENT_ROOT'] ?? ''));
    $app_root      = str_replace('\\', '/', (string) realpath(ROOT_PATH));
    $base_path     = ($document_root !== '' && strpos($app_root, $document_root) === 0)
        ? substr($app_root, strlen($document_root))
        : '';

    define('BASE_URL', rtrim($base_path, '/'));
}
