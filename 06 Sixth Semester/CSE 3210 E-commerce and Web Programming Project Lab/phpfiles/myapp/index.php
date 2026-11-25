<?php
session_start();

// Database Connection
$servername = "localhost";
$username = "phpuser";
$password = "root123";
$dbname = "myappdb";

$conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

// Current page router
$page = $_GET["page"] ?? "dashboard";

// 1. Handle Logout
if ($page == "logout") {
  session_destroy();
  header("location: index.php");
  exit();
}

// 2. Handle Login Form
if (isset($_POST["login"])) {
  $uname = $_POST["username"];
  $pass = $_POST["password"];

  if (empty($uname) || empty($pass)) {
    $auth_error = "Both username and password are required.";
  } else {
    $hashed = md5($pass);
    $sql = "SELECT * FROM users WHERE username='$uname' AND password='$hashed'";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
      $row = mysqli_fetch_assoc($result);
      $_SESSION["user_id"] = $row["id"];
      $_SESSION["username"] = $row["username"];
      header("location: index.php");
      exit();
    } else {
      $auth_error = "Invalid username or password.";
    }
  }
}

// 3. Handle Signup Form
if (isset($_POST["signup"])) {
  $uname = $_POST["username"];
  $pass = $_POST["password"];

  if (empty($uname) || empty($pass)) {
    $auth_error = "Both username and password are required.";
  } else {
    $check = mysqli_query($conn, "SELECT * FROM users WHERE username='$uname'");
    if (mysqli_num_rows($check) > 0) {
      $auth_error = "Username already exists.";
    } else {
      $hashed = md5($pass);
      $sql = "INSERT INTO users (username, password) VALUES ('$uname', '$hashed')";
      if (mysqli_query($conn, $sql)) {
        header("location: index.php?page=login&registered=1");
        exit();
      } else {
        $auth_error = "Signup failed: " . mysqli_error($conn);
      }
    }
  }
}

// 4. Handle Dashboard Contact Form
if (isset($_POST["submit_contact"])) {
  $name = $_POST["name"];
  $email = $_POST["email"];
  $alert_msg = "Form submitted by " . $name . " (" . $email . ")";
}

// 5. Handle Settings Form
if (isset($_POST["save_settings"])) {
  $site_title = $_POST["site_title"];
  $admin_email = $_POST["admin_email"];
  $alert_msg = "Settings updated for " . $site_title . " (" . $admin_email . ").";
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MyApp</title>
  <link rel="stylesheet" href="style.css">
</head>

<?php if ($page == "login" || $page == "signup") { ?>
  <!-- ================= SEPARATE LOGIN / SIGNUP LAYOUT ================= -->

  <body class="auth-body">

    <div class="auth-card">
      <h2><?php echo ($page == "login") ? "Login to MyApp" : "Create Account"; ?></h2>

      <?php if (isset($_GET["registered"])) { ?>
        <p class="success-msg">Account created! Please login.</p>
      <?php } ?>

      <?php if (isset($auth_error)) { ?>
        <p class="error-msg"><?php echo $auth_error; ?></p>
      <?php } ?>

      <form method="post" action="">
        <label>Username</label>
        <input type="text" name="username" placeholder="Enter username">

        <label>Password</label>
        <input type="password" name="password" placeholder="Enter password">

        <?php if ($page == "login") { ?>
          <button type="submit" name="login" class="btn-submit">Login</button>
        <?php } else { ?>
          <button type="submit" name="signup" class="btn-submit">Signup</button>
        <?php } ?>
      </form>

      <p class="auth-switch">
        <?php if ($page == "login") { ?>
          Don't have an account? <a href="index.php?page=signup">Signup</a>
        <?php } else { ?>
          Already have an account? <a href="index.php?page=login">Login</a>
        <?php } ?>
        | <a href="index.php">Home</a>
      </p>
    </div>

  </body>
<?php } else { ?>
  <!-- ================= MAIN DASHBOARD LAYOUT ================= -->

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
        <a href="index.php?page=dashboard" class="nav-link">Home</a>
        <a href="index.php?page=users" class="nav-link">Users</a>

        <!-- Pure CSS Dropdown -->
        <div class="dropdown">
          <button class="dropbtn">More &#9662;</button>
          <div class="dropdown-content">
            <a href="index.php?page=dashboard">Dashboard</a>
            <a href="index.php?page=users">Manage Users</a>
            <a href="index.php?page=settings">Settings</a>
          </div>
        </div>

        <!-- Conditional Login/Signup vs Logout -->
        <?php if (isset($_SESSION["user_id"])) { ?>
          <span class="user-badge"><?php echo strtoupper(substr($_SESSION["username"], 0, 1)); ?></span>
          <span class="welcome-text"><?php echo $_SESSION["username"]; ?></span>
          <a href="index.php?page=logout" class="btn-auth btn-logout">Logout</a>
        <?php } else { ?>
          <a href="index.php?page=login" class="btn-auth btn-login">Login</a>
          <a href="index.php?page=signup" class="btn-auth btn-signup">Signup</a>
        <?php } ?>
      </nav>
    </header>

    <div class="layout-wrapper">
      <!-- Sidebar with 3 Clickable Pages -->
      <aside class="sidebar">
        <ul class="sidebar-menu">
          <li>
            <a href="index.php?page=dashboard" class="<?php if ($page == 'dashboard')
              echo 'active'; ?>">
              <span class="icon">&#8962;</span> Dashboard
            </a>
          </li>
          <li>
            <a href="index.php?page=users" class="<?php if ($page == 'users')
              echo 'active'; ?>">
              <span class="icon">&#128100;</span> Users
            </a>
          </li>
          <li>
            <a href="index.php?page=settings" class="<?php if ($page == 'settings')
              echo 'active'; ?>">
              <span class="icon">&#9881;</span> Settings
            </a>
          </li>
        </ul>

        <?php if (isset($_SESSION["user_id"])) { ?>
          <div class="sidebar-bottom">
            <a href="index.php?page=logout" class="sidebar-logout"><span class="icon">&#10162;</span> Logout</a>
          </div>
        <?php } ?>
      </aside>

      <!-- Dynamic Body Content -->
      <main class="main-content">

        <?php if (isset($alert_msg)) { ?>
          <div class="alert-box"><?php echo $alert_msg; ?></div>
        <?php } ?>

        <?php if ($page == "users") {
          $users_res = mysqli_query($conn, "SELECT id, username FROM users ORDER BY id ASC");
          ?>
          <!-- PAGE 2: USERS -->
          <div class="page-card">
            <h2>Registered Users</h2>
            <p class="page-subtitle">List of accounts stored in the MySQL database.</p>

            <table class="data-table">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Username</th>
                </tr>
              </thead>
              <tbody>
                <?php while ($u = mysqli_fetch_assoc($users_res)) { ?>
                  <tr>
                    <td><?php echo $u["id"]; ?></td>
                    <td><?php echo $u["username"]; ?></td>
                  </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>

        <?php } elseif ($page == "settings") { ?>
          <!-- PAGE 3: SETTINGS -->
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

        <?php } else { ?>
          <!-- PAGE 1: DASHBOARD (DEFAULT) -->
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
        <?php } ?>

      </main>
    </div>

  </body>
<?php } ?>

</html>