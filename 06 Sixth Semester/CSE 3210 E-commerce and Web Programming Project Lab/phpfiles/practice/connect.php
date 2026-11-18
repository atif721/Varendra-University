<?php

$servername = "localhost";
$username = "phpuser";
$password = "root123";
$dbname = "practicedb";

$conn = mysqli_connect($servername, $username, $password, $dbname);

if (!$conn) {
  die("Server connection failed: " . mysqli_connect_errno());
}

// echo "Server Connected Successfully!<br>";