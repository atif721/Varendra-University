<?php
session_start();
include "connect.php";

if (isset($_SESSION["user_id"])) {
  $_SESSION["message"] = "Already logged in";
  header("location: employe.php");
}

if (isset($_POST["login"])) {
  $userid = $_POST["userid"];
  $usrpassword = $_POST["password"];

  if (empty($userid)) {
    $userid_error = "* Input userid";
  }

  if (empty($usrpassword)) {
    $usrpassword_error = "* Input password";
  }

  if (!isset($userid_error) && !isset($usrpassword_error)) {
    $hashed_password = md5($usrpassword);
    $sql = "SELECT * FROM user WHERE emp_id='$userid' AND password='$hashed_password'";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
      $_SESSION["user_id"] = $userid;
      header("location: employe.php");
      exit();
    } else{
      echo "Invalid userid or password";
    }
  }
}

?>

<h2>Login</h2>
<form method="post" action="">
  Employee ID:
  <input type="text" maxlength="9" name="userid">
  <span style="color: red;">
    <?php echo $userid_error ?? "" ?>
  </span><br><br>

  Password:
  <input type="password" name="password">
  <span style="color: red;">
    <?php echo $usrpassword_error ?? "" ?>
  </span><br><br>
  <input type="submit" name="login" value="Login">
</form>