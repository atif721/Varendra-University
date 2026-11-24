<?php
session_start();
include "db.php";

$result = mysqli_query($conn, "SELECT id, username FROM users ORDER BY id ASC");

include "header.php";
include "sidebar.php";
?>

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
            <?php while ($row = mysqli_fetch_assoc($result)) { ?>
                <tr>
                    <td><?php echo $row["id"]; ?></td>
                    <td><?php echo $row["username"]; ?></td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
</div>

<?php include "footer.php"; ?>
