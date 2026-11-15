<?php
/**
 * Session guard. Include this at the top of every protected page.
 */

require_once __DIR__ . '/functions.php';

if (empty($_SESSION['admin_id'])) {
    $_SESSION['flash']['error'] = 'Please log in to continue.';
    header('Location: ' . BASE_URL . '/auth/login.php');
    exit;
}
