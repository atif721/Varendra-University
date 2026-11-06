<?php
$servername = "localhost";
$username = "phpuser";
$password = "root123";
$dbname = "mytestdb";

$conn = mysqli_connect($servername, $username, $password);

if (!$conn) {
  die("Server connection failed: " . mysqli_connect_error());
}

echo "Server connected successfully!<br>";

$sql = "CREATE DATABASE IF NOT EXISTS $dbname";

if (mysqli_query($conn, $sql)) {
  echo "Database created or already exists!<br>";
} else {
  die("Database creation failed: " . mysqli_error($conn));
}

if (mysqli_select_db($conn, $dbname)) {
  echo "Database selected successfully!<br>";
} else {
  die("Database selection failed: " . mysqli_error($conn));
}

$sql = "CREATE TABLE IF NOT EXISTS student (
    student_id VARCHAR(20) PRIMARY KEY,
    student_name VARCHAR(100),
    semester VARCHAR(20),
    section VARCHAR(20)
)";

if (mysqli_query($conn, $sql)) {
  echo "Student table created or already exists!<br>";
} else {
  die("Table creation failed: " . mysqli_error($conn));
}

echo "All operations completed successfully!";