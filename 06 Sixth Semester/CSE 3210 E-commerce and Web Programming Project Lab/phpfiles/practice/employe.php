<?php
session_start();
require "connect.php";

if (isset($_POST['submit'])) {
  $emp_id = $_POST['emp_id'];
  $emp_name = $_POST['emp_name'];
  $emp_dept = $_POST['emp_dept'];
  $emp_join_year = $_POST['empjoin_year'];
  $password = $_POST['password'];

  if (empty($emp_id)) {
    $id_error = "* Input employee id";
  }

  if (empty($emp_name)) {
    $name_error = "* Input employee name";
  }

  if (empty($emp_dept)) {
    $dept_error = "* Input employee department";
  }

  if (empty($emp_join_year)) {
    $empjoin_error = "* Input employee joining year";
  }

  if (empty($password)) {
    $password_error = "* Input password";
  }

  if (!isset($id_error) && !isset($name_error) && !isset($dept_error) && !isset($empjoin_error) && !isset($password_error)) {
    $sql = "SELECT * FROM employe WHERE emp_id='$emp_id'";
    $result = mysqli_query($conn, $sql);
    $count = mysqli_num_rows($result);

    if ($count > 0) {
      echo "This id already exist";
    } else {
      $sql = "INSERT INTO employe (emp_id, emp_name, emp_dept, empjoin_year) VALUES ('$emp_id', '$emp_name','$emp_dept','$emp_join_year')";
      $result = mysqli_query($conn, $sql);

      if ($result) {
        $hashed_password = md5($password);
        $sql = "INSERT INTO user (emp_id,password) VALUES ('$emp_id','$hashed_password')";
        $execute = mysqli_query($conn, $sql);
        if ($execute) {
          echo "Record inserted Successfully";
        }
      } else {
        die("Insertion failed: " . mysqli_error($conn));
      }
    }
  }
}
?>

<?php
if (isset($_SESSION["message"])) {
  echo $_SESSION["message"];
  unset($_SESSION["message"]);
}
?>

<form method="post" action="">
  <br><br>
  Employee id: <input type="text" name="emp_id" value="<?php echo isset($emp_id) ? $emp_id : "" ?>" maxlength="9">
  <span style="color: red;">
    <?php echo $id_error ?? "" ?>
  </span>
  <br><br>
  Employee name: <input type="text" name="emp_name" value="<?php echo isset($emp_name) ? $emp_name : "" ?>">
  <span style="color: red;">
    <?php echo $name_error ?? "" ?>
  </span>
  <br><br>
  Employee department: <input type="text" name="emp_dept" value="<?php echo isset($emp_dept) ? $emp_dept : "" ?>">
  <span style="color: red;">
    <?php echo $dept_error ?? "" ?>
  </span>
  <br><br>
  Employee joining year: <input type="number" name="empjoin_year" value="<?php echo $emp_join_year ?? "" ?>">
  <span style="color: red;">
    <?php echo $empjoin_error ?? "" ?>
  </span>
  <br><br>
  Password : <input type="password" name="password">
  <span style="color: red;">
    <?php echo $password_error ?? "" ?>
  </span>
  <br><br>
  <input type="submit" name="submit" value="Insert">
</form>

<table border="1">
  <tr>
    <th>Employee ID</th>
    <th>Employee name</th>
    <th>Employee Department</th>
    <th>Employee Joining year</th>
    <th>Update / Delete</th>
  </tr>

  <?php
  $sql = "SELECT * FROM employe";
  $execute = mysqli_query($conn, $sql);

  while ($row = mysqli_fetch_assoc($execute)) { ?>
    <tr>
      <td><?php echo $row["emp_id"]; ?></td>
      <td><?php echo $row["emp_name"]; ?></td>
      <td><?php echo $row["emp_dept"]; ?></td>
      <td><?php echo $row["empjoin_year"]; ?></td>
      <td><a href="update.php?id=<?php echo $row['id'];?>" target="_blank">Update</a>&nbsp; <a href="delete.php?id=<?php echo $row['id'];?>" target="_blank">Delete</a></td>
    </tr>
  <?php }
  ?>
</table>
<br><br>
<a href="logout.php">Logout</a>