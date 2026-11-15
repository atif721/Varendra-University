<?php
session_start();
echo $name;
echo $_SESSION["name"];
session_destroy();
?>