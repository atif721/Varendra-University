<?php
require "connect.php";

if (isset($_POST["submit"])) {
  $studentid = $_POST["student_id"];
  $studentname = $_POST["student_name"];
  $semester = $_POST["semester"];
  $section = $_POST["section"];

  $query = "insert into student (student_id,student_name,semester,section) values('$studentid','$studentname','$semester','$section')";
  $execute = mysqli_query($conn, $query);

  if ($execute) {
    echo "Inserted";
  } else {
    echo "Try again";
  }
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Php practice document</title>
</head>

<body>

  <form action="" method="post">
    <input type="text" name="student_id" placeholder="Student ID">
    <input type="text" name="student_name" placeholder="Student Name">
    <input type="text" name="semester" placeholder="Semester">
    <input type="text" name="section" placeholder="Section">
    <input type="submit" name="submit" value="Submit">
  </form>

  <table border="1">
    <tr>
      <th>Student ID</th>
      <th>Student Name</th>
      <th>Semester</th>
      <th>Section</th>
    </tr>
    <?php
    $query = "select * from student";
    $execute = mysqli_query($conn, $query);

    while ($row = mysqli_fetch_assoc($execute)) { ?>
      <tr>
        <td><?php echo $row["student_id"]; ?></td>
        <td><?php echo $row["student_name"]; ?></td>
        <td><?php echo $row["semester"]; ?></td>
        <td><?php echo $row["section"]; ?></td>
      </tr>
    <?php }
    ?>
  </table>

</body>

</html>