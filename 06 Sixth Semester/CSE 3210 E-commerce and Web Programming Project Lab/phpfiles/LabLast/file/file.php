<?php

if (isset($_POST["submit"])) {

        $target_dir = "uploads/";

        // NEW: create the folder if it doesn't exist
        if (!is_dir($target_dir)) {
            mkdir($target_dir, 0755, true);
        }

        $imageFileType = strtolower(pathinfo($_FILES["fileUpload"]["name"], PATHINFO_EXTENSION));

        // NEW name: image_time_random.ext
        $name = "image_" . time() . "_" . rand(1000, 9999) . "." . $imageFileType;
        $target_file = $target_dir . $name;
        $uploadOk = 1;

        // Is it a real image?
        if (getimagesize($_FILES["fileUpload"]["tmp_name"]) === false) {
            echo "File is not an image.<br>";
            $uploadOk = 0;
        }

        // Size limit (5 MB)
        if ($_FILES["fileUpload"]["size"] > 5 * 1024 * 1024) {
            echo "Sorry, your file is too large.<br>";
            $uploadOk = 0;
        }

        // Allowed types
        if (!in_array($imageFileType, ["jpg", "jpeg", "png", "gif"])) {
            echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.<br>";
            $uploadOk = 0;
        }

        if ($uploadOk == 0) {
            echo "Your file was not uploaded.";
        } else {
            if (move_uploaded_file($_FILES["fileUpload"]["tmp_name"], $target_file)) {

                echo "The file " . $name . " has been uploaded.";
            } else {
                echo "Sorry, there was an error uploading your file.";
            }
        }
    }

?>

<form method="POST" action="" enctype="multipart/form-data">
    Select image to upload:
    <input type="file" name="fileUpload" required>
    <input type="submit" name="submit" value="Upload Image">
</form>