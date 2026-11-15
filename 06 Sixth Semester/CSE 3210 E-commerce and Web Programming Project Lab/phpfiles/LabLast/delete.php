<?php
    include "connect.php";
    $id=$_GET["id"];

    $sql="delete from student where id='$id' ";
    $result=mysqli_query($conn,$sql);
    if($result){
        echo "Record deleted successfully!";
        //header("location:student_info.php");
    }
    else{
        die("Deletion failed: " . mysqli_error($conn));
    }

?>