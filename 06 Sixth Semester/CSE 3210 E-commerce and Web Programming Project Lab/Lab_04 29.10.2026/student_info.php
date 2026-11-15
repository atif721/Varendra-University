<?php
//include "connect.php";
require "connect.php";

$studentid=123;
$studentname="Saif";
$semester="6th";
$section="A";

// $query="insert into student (student_id,student_name,semester,section) values('$studentid','$studentname','$semester','$section')";
// $execute=mysqli_query($conn,$query);

// if($execute){
//     echo "Inserted";
// }
// else{
//     echo "Try again";
// }

?>
<form action="">

</form>

<table border="1">
    <tr>
        <th>Student ID</th>
        <th>Student Name</th>
        <th>Semester</th>
        <th>Section</th>
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
            </tr>
    <?php  }
    ?>
    
</table>

