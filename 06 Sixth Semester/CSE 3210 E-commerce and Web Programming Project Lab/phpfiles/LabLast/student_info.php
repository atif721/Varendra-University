<?php
session_start();
// echo md5(123);
//include "connect.php";
require "connect.php";
$name="Mr X";
$_SESSION["name"]="Mr Y";

if (isset($_POST['submit'])) {
    $student_id   = $_POST['student_id'];
    $student_name = $_POST['student_name'];
    $semester     = $_POST['semester'];
    $section      = $_POST['section'];
    $password     = $_POST['password'];

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

    if (empty($password)) {
        $password_error = "* Input password";
    }

    if (!isset($id_error) && !isset($name_error) && !isset($semester_error) && !isset($section_error)) {
        $sql="select * from student where student_id='$student_id'";
        $result=mysqli_query($conn,$sql);
        $count=mysqli_num_rows($result);
        if($count>0){
            echo "This id already exists.";
        }

        else{
            $sql = "INSERT INTO student (student_id, student_name, semester, section)
            VALUES ('$student_id', '$student_name', '$semester', '$section')";
            $result = mysqli_query($conn, $sql);

            if ($result) {
                //echo "Record inserted successfully!";
                $hashed_password=md5($password);
                $sql="Insert into user (student_id,password) values('$student_id','$hashed_password')";
                $execute = mysqli_query($conn, $sql);

                if($execute){
                    echo "Record inserted successfully!";
                }

            } else {
                die("Insertion failed: " . mysqli_error($conn));
            }

        }
 
    }

}

?>

<?php
  if(isset($_SESSION['message'])){
    echo $_SESSION['message'];
    unset($_SESSION['message']);
  }
?>
<form method="post" action="">
        Student ID: <input type="text" name="student_id" value="<?php echo isset($student_id) ? $student_id : '' ?>">
        <span style="color:red"><?php echo isset($id_error) ? $id_error : '' ?></span><br><br>

        Student Name: <input type="text" name="student_name" value="<?php echo isset($student_name) ? $student_name : '' ?>">
        <span style="color:red"><?php echo isset($name_error) ? $name_error : '' ?></span><br><br>

        Semester: <input type="text" name="semester" value="<?php echo isset($semester) ? $semester : '' ?>">
        <span style="color:red"><?php echo isset($semester_error) ? $semester_error : '' ?></span><br><br>

        Section: <input type="text" name="section" value="<?php echo isset($section) ? $section : '' ?>">
        <span style="color:red"><?php echo isset($section_error) ? $section_error : '' ?></span><br><br>

        Password: <input type="password" name="password" value="<?php echo isset($password) ? $password : '' ?>">
        <span style="color:red"><?php echo isset($password_error) ? $password_error : '' ?></span><br><br>

        <input type="submit" name="submit" value="Insert">
    </form>


<table border="1">
    <tr>
        <th>Student ID</th>
        <th>Student Name</th>
        <th>Semester</th>
        <th>Section</th>
        <th>Action</th>
    </tr>
    <?php
        $query="select * from student";
        $execute=mysqli_query($conn,$query);

        while($row=mysqli_fetch_assoc($execute)){ ?>
            <tr>
                <td><?php echo $row["student_id"];?></td>
                <td><?php echo $row["student_name"];?></td>
                <td><?php echo $row["semester"];?></td>
                <td><?php echo $row["section"];?></td>
                <td><a href="update.php?id=<?php echo $row['id'];?>" target="_blank">Update</a>&nbsp;<a href="delete.php?id=<?php echo $row['id'];?>" target="_blank">Delete</a></td>
            </tr>
    <?php  }
    ?>
    
</table>

<a href="logout.php">Logout</a>

