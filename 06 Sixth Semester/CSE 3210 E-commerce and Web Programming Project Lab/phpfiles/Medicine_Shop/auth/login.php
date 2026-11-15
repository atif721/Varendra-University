<?php
/**
 * Admin login.
 */

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../includes/functions.php';

if (!empty($_SESSION['admin_id'])) {
    redirect('index.php');
}

$error    = '';
$username = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($username === '' || $password === '') {
        $error = 'Please enter both username and password.';
    } else {
        $username_escaped = mysqli_real_escape_string($conn, $username);

        $result = mysqli_query(
            $conn,
            "SELECT id, username, password, full_name
             FROM admins
             WHERE username = '$username_escaped'
             LIMIT 1"
        );

        $admin = $result ? mysqli_fetch_assoc($result) : null;

        if ($admin && password_verify($password, $admin['password'])) {
            session_regenerate_id(true);

            $_SESSION['admin_id']   = (int) $admin['id'];
            $_SESSION['admin_name'] = $admin['full_name'];
            $_SESSION['admin_user'] = $admin['username'];

            redirect('index.php');
        }

        $error = 'Invalid username or password.';
    }
}

if ($error === '') {
    $error = (string) get_flash('error');
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | <?= e(APP_SHORT_NAME) ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<?= url('assets/css/style.css') ?>" rel="stylesheet">
</head>
<body class="login-page d-flex align-items-center justify-content-center py-5">

<div class="card shadow-sm login-card w-100">
    <div class="card-body p-4 p-md-5">
        <div class="text-center mb-4">
            <div class="login-icon mb-2"><i class="bi bi-capsule-pill"></i></div>
            <h1 class="h4 mb-1"><?= e(APP_SHORT_NAME) ?></h1>
            <p class="text-muted small mb-0">Admin Billing Panel</p>
        </div>

        <?php if ($error !== ''): ?>
            <div class="alert alert-danger py-2 small" role="alert"><?= e($error) ?></div>
        <?php endif; ?>

        <form method="post" action="<?= url('auth/login.php') ?>" autocomplete="off">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <input type="text" class="form-control" id="username" name="username"
                           value="<?= e($username) ?>" required autofocus>
                </div>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
            </div>

            <button type="submit" class="btn btn-success w-100">
                <i class="bi bi-box-arrow-in-right me-1"></i>Login
            </button>
        </form>

        <p class="text-center text-muted small mt-4 mb-0">
            Default login: <strong>admin</strong> / <strong>admin123</strong>
        </p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
