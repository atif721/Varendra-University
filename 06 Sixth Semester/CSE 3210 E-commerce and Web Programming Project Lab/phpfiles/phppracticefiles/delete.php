<?php
include "connect.php";

$id = $_GET["id"];

$gemp = "SELECT emp_id FROM employe WHERE id='$id'";
$execute = mysqli_query($conn, $gemp);
$row = mysqli_fetch_assoc($execute);
$emp_id = $row["emp_id"];

$sql = "DELETE FROM employe WHERE id='$id'";
$sql2 = "DELETE FROM user WHERE emp_id='$emp_id'";
$result = mysqli_query($conn, $sql);
$result2 = mysqli_query($conn, $sql2);

if($result && $result2){
  echo "Record deleted successfully!";
  header("location:employe.php");
}else{
  die("Deletion failed: ".mysqli_error($conn));
}