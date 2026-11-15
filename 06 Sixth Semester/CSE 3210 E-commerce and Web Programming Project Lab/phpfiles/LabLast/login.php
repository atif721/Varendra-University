<?php
include "connect.php";
session_start();

if(isset($_SESSION['user_id'])){
    $_SESSION['message']="Already logged in";
    header("location: student_info.php");
}

if (isset($_POST['login'])) {
    $uname = $_POST['username'];
    $upass = $_POST['password'];

    if (empty($uname)) {
        $uname_error = "* Input username";
    }
    if (empty($upass)) {
        $upass_error = "* Input password";
    }

    if (!isset($uname_error) && !isset($upass_error)) {
        $hashed_password=md5($upass);
        $sql    = "SELECT * FROM user WHERE student_id = '$uname' AND password = '$hashed_password'";
        $result = mysqli_query($conn, $sql);

        if (mysqli_num_rows($result) >0) {
            $_SESSION['user_id']  = $uname;
            header("Location: student_info.php");
            exit;
        } else {
            $login_error = "Invalid username or password";
        }
    }
}
?>

<!DOCTYPE html>
<html>

<head>
    <title>Login</title>
</head>

<body>

    <h2>Login</h2>

    <form method="post" action="">
        Student ID: <input type="text" name="username" value="<?php echo isset($uname) ? $uname : '' ?>">
        <span style="color:red"><?php echo isset($uname_error) ? $uname_error : '' ?></span><br><br>

        Password: <input type="password" name="password">
        <span style="color:red"><?php echo isset($upass_error) ? $upass_error : '' ?></span><br><br>

        <input type="submit" name="login" value="Login">
    </form>

</body>

</html>