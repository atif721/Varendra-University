<?php
$current_page = basename($_SERVER["PHP_SELF"]);
?>
<aside class="sidebar">
    <ul class="sidebar-menu">
        <li>
            <a href="index.php" class="<?php if ($current_page == 'index.php') echo 'active'; ?>">
                <span class="icon">&#8962;</span> Dashboard
            </a>
        </li>
        <li>
            <a href="users.php" class="<?php if ($current_page == 'users.php') echo 'active'; ?>">
                <span class="icon">&#128100;</span> Users
            </a>
        </li>
        <li>
            <a href="settings.php" class="<?php if ($current_page == 'settings.php') echo 'active'; ?>">
                <span class="icon">&#9881;</span> Settings
            </a>
        </li>
    </ul>

    <?php if (isset($_SESSION["user_id"])) { ?>
        <div class="sidebar-bottom">
            <a href="logout.php" class="sidebar-logout"><span class="icon">&#10162;</span> Logout</a>
        </div>
    <?php } ?>
</aside>

<main class="main-content">
