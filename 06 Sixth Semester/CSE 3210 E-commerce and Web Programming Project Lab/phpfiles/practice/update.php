<?php
require "connect.php";

$id = $_GET["id"];

$query = "SELECT * FROM employe WHERE id='$id'";
$execute = mysqli_query($conn, $query);
$row = mysqli_fetch_assoc($execute);

$pre_emp_id = $row["emp_id"];
$pre_emp_name = $row["emp_name"];
$pre_emp_dept = $row["emp_dept"];
$pre_empjoin_year = $row["empjoin_year"];

if (isset($_POST['update'])) {

  $emp_id = $_POST['emp_id'];
  $emp_name = $_POST['emp_name'];
  $emp_dept = $_POST['emp_dept'];
  $emp_join_year = $_POST['empjoin_year'];

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

  if (!isset($id_error) && !isset($name_error) && !isset($dept_error) && !isset($empjoin_error)) {
    $sql = "UPDATE employe SET emp_id='$emp_id', emp_name='$emp_name', emp_dept='$emp_dept', empjoin_year='$emp_join_year' WHERE  id='$id'";
    $result = mysqli_query($conn, $sql);

    if ($result) {
      echo "Record Updated Successfully";
    } else {
      die("Update failed: " . mysqli_error($conn));
    }
    header("location:employe.php");
  }
}


?>

<form method="post" action="">
  <br><br>
  Employee id: <input type="text" name="emp_id" value="<?php echo $pre_emp_id ?? "" ?>" maxlength="9">
  <span style="color: red;">
    <?php echo $id_error ?? "" ?>
  </span>
  <br><br>
  Employee name: <input type="text" name="emp_name"value="<?php echo $pre_emp_name ?? "" ?>">
  <span style="color: red;">
    <?php echo $name_error ?? "" ?>
  </span>
  <br><br>
  Employee department: <input type="text" name="emp_dept" value="<?php echo $pre_emp_dept ?? "" ?>">
  <span style="color: red;">
    <?php echo $dept_error ?? "" ?>
  </span>
  <br><br>
  Employee joining year: <input type="number" name="empjoin_year" value="<?php echo $pre_empjoin_year ?? "" ?>">
  <span style="color: red;">
    <?php echo $empjoin_error ?? "" ?>
  </span>
  <br><br>
  <input type="submit" name="update" value="Update">
</form>