<?php
session_start();
include "db.php";

if (isset($_POST["submit_contact"])) {
    $name  = $_POST["name"];
    $email = $_POST["email"];
    $msg   = "Form submitted by " . $name . " (" . $email . ")";
}

include "header.php";
include "sidebar.php";
?>

<?php if (isset($msg)) { ?>
    <div class="alert-box"><?php echo $msg; ?></div>
<?php } ?>

<!-- 1. Four Image Cards Grid -->
<section class="cards-grid">
    <div class="media-card">
        <img src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600&q=80" alt="Workspace">
    </div>
    <div class="media-card">
        <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=600&q=80" alt="Growth Chart">
    </div>
    <div class="media-card">
        <img src="https://images.unsplash.com/photo-1518770660439-4636190af475?w=600&q=80" alt="Gears and Tech">
    </div>
    <div class="media-card">
        <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=600&q=80" alt="Mountain Lake">
    </div>
</section>

<!-- 2. Bottom Two-Column Form Section -->
<section class="forms-grid">
    <div class="form-card">
        <h2>Form</h2>
        <form method="post" action="">
            <input type="text" name="name" placeholder="Enter name..." required>
            <input type="email" name="email" placeholder="Enter email..." required>
            <button type="submit" name="submit_contact" class="btn-submit">Submit</button>
        </form>
    </div>

    <div class="form-card">
        <h2>Form</h2>
        <form method="post" action="">
            <textarea name="message" rows="4" placeholder="Your message..."></textarea>
            <div class="reset-wrap">
                <button type="reset" class="btn-reset">Reset</button>
            </div>
        </form>
    </div>
</section>

<?php include "footer.php"; ?>
