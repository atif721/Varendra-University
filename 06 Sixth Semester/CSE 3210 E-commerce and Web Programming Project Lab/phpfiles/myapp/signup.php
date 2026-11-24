<?php
session_start();
include "db.php";

if (isset($_SESSION["user_id"])) {
    header("location: index.php");
    exit();
}

if (isset($_POST["signup"])) {
    $username = $_POST["username"];
    $password = $_POST["password"];

    if (empty($username) || empty($password)) {
        $error = "Both username and password are required.";
    } else {
        $check = mysqli_query($conn, "SELECT * FROM users WHERE username='$username'");
        if (mysqli_num_rows($check) > 0) {
            $error = "Username already exists.";
        } else {
            $hashed = md5($password);
            $sql = "INSERT INTO users (username, password) VALUES ('$username', '$hashed')";
            if (mysqli_query($conn, $sql)) {
                header("location: login.php");
                exit();
            } else {
                $error = "Signup failed: " . mysqli_error($conn);
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Signup - MyApp</title>
    <link rel="stylesheet" href="style.css">
</head>
<body class="auth-body">

<div class="auth-card">
    <h2>Create Account</h2>
    <?php if (isset($error)) { ?>
        <p class="error-msg"><?php echo $error; ?></p>
    <?php } ?>

    <form method="post" action="">
        <label>Username</label>
        <input type="text" name="username" placeholder="Choose username">

        <label>Password</label>
        <input type="password" name="password" placeholder="Choose password">

        <button type="submit" name="signup" class="btn-submit">Signup</button>
    </form>

    <p class="auth-switch">Already have an account? <a href="login.php">Login</a> | <a href="index.php">Home</a></p>
</div>

</body>
</html>
