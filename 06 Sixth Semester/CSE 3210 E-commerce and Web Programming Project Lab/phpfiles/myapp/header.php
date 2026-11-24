<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyApp Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="navbar">
    <!-- Left: Brand Logo & Name -->
    <div class="nav-left">
        <a href="index.php" class="brand">
            <span class="brand-icon">&#11042;</span>
            <span class="brand-name">MyApp</span>
        </a>
    </div>

    <!-- Right: Nav Items, Dropdown & Login/Signup or Logout -->
    <nav class="nav-right">
        <a href="index.php" class="nav-link">Home</a>
        <a href="users.php" class="nav-link">Users</a>

        <!-- Pure CSS Dropdown -->
        <div class="dropdown">
            <button class="dropbtn">More &#9662;</button>
            <div class="dropdown-content">
                <a href="index.php">Dashboard</a>
                <a href="users.php">Manage Users</a>
                <a href="settings.php">Settings</a>
            </div>
        </div>

        <!-- Conditional Login/Signup vs Logout -->
        <?php if (isset($_SESSION["user_id"])) { ?>
            <span class="user-badge"><?php echo strtoupper(substr($_SESSION["username"], 0, 1)); ?></span>
            <span class="welcome-text"><?php echo $_SESSION["username"]; ?></span>
            <a href="logout.php" class="btn-auth btn-logout">Logout</a>
        <?php } else { ?>
            <a href="login.php" class="btn-auth btn-login">Login</a>
            <a href="signup.php" class="btn-auth btn-signup">Signup</a>
        <?php } ?>
    </nav>
</header>

<div class="layout-wrapper">
