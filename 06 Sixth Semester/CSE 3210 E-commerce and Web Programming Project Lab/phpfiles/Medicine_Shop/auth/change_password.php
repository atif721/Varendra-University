<?php
/**
 * Change the logged-in admin's password.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/auth.php';

$errors  = [];
$current = '';
$new     = '';
$confirm = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $current = $_POST['current_password'] ?? '';
    $new     = $_POST['new_password'] ?? '';
    $confirm = $_POST['confirm_password'] ?? '';

    $admin_id = (int) $_SESSION['admin_id'];
    $result   = mysqli_query($conn, "SELECT id, password FROM admins WHERE id = $admin_id LIMIT 1");
    $admin    = $result ? mysqli_fetch_assoc($result) : null;

    if (!$admin) {
        $errors[] = 'Admin account could not be found.';
    } elseif (!password_verify($current, $admin['password'])) {
        $errors[] = 'The current password is incorrect.';
    }

    if (strlen($new) < 6) {
        $errors[] = 'The new password must be at least 6 characters long.';
    }

    if ($new !== $confirm) {
        $errors[] = 'The new password and confirmation do not match.';
    }

    if (!$errors) {
        $hashed    = password_hash($new, PASSWORD_DEFAULT);
        $hashed_esc = mysqli_real_escape_string($conn, $hashed);

        if (mysqli_query($conn, "UPDATE admins SET password = '$hashed_esc' WHERE id = $admin_id")) {
            set_flash('success', 'Your password has been changed successfully.');
            redirect('auth/change_password.php');
        }

        $errors[] = 'The password could not be updated. Please try again.';
    }
}

$pageTitle = 'Change Password';
require_once __DIR__ . '/../includes/header.php';
require_once __DIR__ . '/../includes/sidebar.php';
?>
<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <h1 class="page-title h4 mb-1">Change Password</h1>
        <p class="text-muted small mb-0">Update the password used to sign in to the admin panel.</p>
    </div>
</div>

<div class="row">
    <div class="col-lg-6">
        <?php if ($errors): ?>
            <div class="alert alert-danger">
                <ul class="mb-0 ps-3">
                    <?php foreach ($errors as $error): ?>
                        <li><?= e($error) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <div class="card">
            <div class="card-body">
                <form method="post" action="<?= url('auth/change_password.php') ?>" autocomplete="off">
                    <div class="mb-3">
                        <label for="current_password" class="form-label">Current Password</label>
                        <input type="password" class="form-control" id="current_password"
                               name="current_password" required>
                    </div>

                    <div class="mb-3">
                        <label for="new_password" class="form-label">New Password</label>
                        <input type="password" class="form-control" id="new_password"
                               name="new_password" minlength="6" required>
                        <div class="form-text">Use at least 6 characters.</div>
                    </div>

                    <div class="mb-4">
                        <label for="confirm_password" class="form-label">Confirm New Password</label>
                        <input type="password" class="form-control" id="confirm_password"
                               name="confirm_password" minlength="6" required>
                    </div>

                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check2-circle me-1"></i>Update Password
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
