<?php
session_start();
include "db.php";

if (isset($_POST["save_settings"])) {
    $site_title = $_POST["site_title"];
    $admin_email = $_POST["admin_email"];
    $saved_msg = "Settings updated for " . $site_title . " (" . $admin_email . ").";
}

include "header.php";
include "sidebar.php";
?>

<?php if (isset($saved_msg)) { ?>
    <div class="alert-box"><?php echo $saved_msg; ?></div>
<?php } ?>

<div class="page-card">
    <h2>Application Settings</h2>
    <p class="page-subtitle">Update your general application preferences.</p>

    <form method="post" action="" class="settings-form">
        <label>Application Name</label>
        <input type="text" name="site_title" value="MyApp" required>

        <label>Contact Email</label>
        <input type="email" name="admin_email" value="admin@myapp.com" required>

        <button type="submit" name="save_settings" class="btn-submit">Save Settings</button>
    </form>
</div>

<?php include "footer.php"; ?>
