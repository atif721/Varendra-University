<?php
/**
 * Shared helper functions.
 */

require_once __DIR__ . '/../config/config.php';

/** Escape output for HTML. */
function e($value)
{
    return htmlspecialchars((string) $value, ENT_QUOTES, 'UTF-8');
}

/** Build an application URL from a relative path. */
function url($path = '')
{
    return BASE_URL . '/' . ltrim($path, '/');
}

/** Redirect to a page inside the project and stop execution. */
function redirect($path)
{
    header('Location: ' . url($path));
    exit;
}

/** Store a one-time flash message. */
function set_flash($type, $message)
{
    $_SESSION['flash'][$type] = $message;
}

/** Read and clear a flash message. */
function get_flash($type)
{
    if (!isset($_SESSION['flash'][$type])) {
        return null;
    }

    $message = $_SESSION['flash'][$type];
    unset($_SESSION['flash'][$type]);

    return $message;
}

/** Format an amount with the project currency. */
function format_money($amount)
{
    return CURRENCY . ' ' . number_format((float) $amount, 2);
}

/** Return the expiry status of a medicine. */
function expiry_status($expiry_date)
{
    $expiry = strtotime($expiry_date);
    $today  = strtotime(date('Y-m-d'));

    if ($expiry === false) {
        return 'unknown';
    }

    if ($expiry < $today) {
        return 'expired';
    }

    if ($expiry <= strtotime('+60 days', $today)) {
        return 'expiring';
    }

    return 'valid';
}

/** Show the active sidebar state if the current page matches the given folder. */
function nav_active($folder)
{
    $current = dirname($_SERVER['SCRIPT_NAME'] ?? '');

    return basename($current) === $folder ? ' active' : '';
}

/**
 * Generate a unique invoice number such as INV-20261114-A1B2C3.
 * A short random suffix avoids clashes even for simultaneous sales.
 */
function generate_invoice_no($conn)
{
    do {
        $invoice_no = 'INV-' . date('Ymd') . '-' . strtoupper(bin2hex(random_bytes(3)));
        $escaped    = mysqli_real_escape_string($conn, $invoice_no);
        $result     = mysqli_query($conn, "SELECT id FROM sales WHERE invoice_no = '$escaped' LIMIT 1");
    } while ($result && mysqli_num_rows($result) > 0);

    return $invoice_no;
}

/** Validate a YYYY-MM-DD date and return it, or an empty string when invalid. */
function valid_date($value)
{
    $value = trim((string) $value);

    if ($value === '') {
        return '';
    }

    $date = DateTime::createFromFormat('Y-m-d', $value);

    return ($date && $date->format('Y-m-d') === $value) ? $value : '';
}

/** Fetch one product by id. */
function get_product($conn, $id)
{
    $id = (int) $id;

    if ($id <= 0) {
        return null;
    }

    $result = mysqli_query($conn, "SELECT * FROM products WHERE id = $id LIMIT 1");

    return $result ? mysqli_fetch_assoc($result) : null;
}

/** Fetch one category by id. */
function get_category($conn, $id)
{
    $id = (int) $id;

    if ($id <= 0) {
        return null;
    }

    $result = mysqli_query($conn, "SELECT * FROM categories WHERE id = $id LIMIT 1");

    return $result ? mysqli_fetch_assoc($result) : null;
}
