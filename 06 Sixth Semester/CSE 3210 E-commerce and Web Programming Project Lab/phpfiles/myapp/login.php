<?php
session_start();
include "db.php";

if (isset($_SESSION["user_id"])) {
    header("location: index.php");
    exit();
}

if (isset($_POST["login"])) {
    $username = $_POST["username"];
    $password = $_POST["password"];

    if (empty($username) || empty($password)) {
        $error = "Both username and password are required.";
    } else {
        $hashed = md5($password);
        $sql = "SELECT * FROM users WHERE username='$username' AND password='$hashed'";
        $result = mysqli_query($conn, $sql);

        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $_SESSION["user_id"]  = $row["id"];
            $_SESSION["username"] = $row["username"];
            header("location: index.php");
            exit();
        } else {
            $error = "Invalid username or password.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - MyApp</title>
    <link rel="stylesheet" href="style.css">
</head>
<body class="auth-body">

<div class="auth-card">
    <h2>Login to MyApp</h2>
    <?php if (isset($error)) { ?>
        <p class="error-msg"><?php echo $error; ?></p>
    <?php } ?>

    <form method="post" action="">
        <label>Username</label>
        <input type="text" name="username" placeholder="Enter username">

        <label>Password</label>
        <input type="password" name="password" placeholder="Enter password">

        <button type="submit" name="login" class="btn-submit">Login</button>
    </form>

    <p class="auth-switch">Don't have an account? <a href="signup.php">Signup</a> | <a href="index.php">Home</a></p>
</div>

</body>
</html>
