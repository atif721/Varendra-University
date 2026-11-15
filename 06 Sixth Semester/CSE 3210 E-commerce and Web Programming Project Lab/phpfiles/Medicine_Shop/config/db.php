<?php
/**
 * Database connection using procedural MySQLi only.
 * Adjust the four variables below to match your local server.
 */

require_once __DIR__ . '/config.php';

$db_host = getenv('MEDICINE_DB_HOST') ?: 'localhost';
$db_port = (int) (getenv('MEDICINE_DB_PORT') ?: 3306);
$db_user = getenv('MEDICINE_DB_USER') ?: 'phpuser';
$db_pass = getenv('MEDICINE_DB_PASS') !== false ? getenv('MEDICINE_DB_PASS') : 'root123';
$db_name = getenv('MEDICINE_DB_NAME') ?: 'medicine_shop';

$conn = mysqli_connect($db_host, $db_user, $db_pass, $db_name, $db_port);

if (!$conn) {
    die('Database connection failed: ' . mysqli_connect_error());
}

mysqli_set_charset($conn, 'utf8mb4');