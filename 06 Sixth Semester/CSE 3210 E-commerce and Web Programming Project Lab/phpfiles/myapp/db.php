<?php
$servername = "localhost";
$username   = "phpuser";
$password   = "root123";
$dbname     = "myappdb";

$conn = mysqli_connect($servername, $username, $password, $dbname);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
