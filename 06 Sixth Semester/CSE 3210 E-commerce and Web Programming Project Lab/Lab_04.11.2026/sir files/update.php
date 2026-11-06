<?php
include "connect.php";
$id=$_GET["id"];

$query="select * from student where id='$id' ";
$execute=mysqli_query($conn,$query);
$row=mysqli_fetch_assoc($execute);

$pre_student_id= $row["student_id"];
$pre_student_name= $row["student_name"];
$pre_semester= $row["semester"];
$pre_section= $row["section"];

if (isset($_POST['update'])) {
    $student_id   = $_POST['student_id'];
    $student_name = $_POST['student_name'];
    $semester     = $_POST['semester'];
    $section      = $_POST['section'];

    if (empty($student_id)) {
        $id_error = "* Input student ID";
    }
    if (empty($student_name)) {
        $name_error = "* Input student name";
    }
    if (empty($semester)) {
        $semester_error = "* Input semester";
    }
    if (empty($section)) {
        $section_error = "* Input section";
    }

    if (!isset($id_error) && !isset($name_error) && !isset($semester_error) && !isset($section_error)) {
        $sql = "update student set student_id='$student_id', student_name='$student_name',semester='$semester', section='$section' where id='$id' ";
        $result = mysqli_query($conn, $sql);

        if ($result) {
            echo "Record updated successfully!";
        } else {
            die("Updation failed: " . mysqli_error($conn));
        } 
    }

}



?>

    <form method="post" action="">
        Student ID: <input type="text" name="student_id" value="<?php echo isset($pre_student_id) ? $pre_student_id : '' ?>">
        <span style="color:red"><?php echo isset($id_error) ? $id_error : '' ?></span><br><br>

        Student Name: <input type="text" name="student_name" value="<?php echo isset($pre_student_name) ? $pre_student_name : '' ?>">
        <span style="color:red"><?php echo isset($name_error) ? $name_error : '' ?></span><br><br>

        Semester: <input type="text" name="semester" value="<?php echo isset($pre_semester) ? $pre_semester : '' ?>">
        <span style="color:red"><?php echo isset($semester_error) ? $semester_error : '' ?></span><br><br>

        Section: <input type="text" name="section" value="<?php echo isset($pre_section) ? $pre_section : '' ?>">
        <span style="color:red"><?php echo isset($section_error) ? $section_error : '' ?></span><br><br>

        <input type="submit" name="update" value="Update">
    </form>