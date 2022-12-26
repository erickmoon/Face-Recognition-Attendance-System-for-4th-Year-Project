<?php
$date_selected = $_POST['date_selected'];
$attendance_id = $_POST['attendance_id'];

$input="$attendance_id $date_selected peter";
exec("C:\\Users\\ERICK\\PycharmProjects\\faceRecognition\\triggerapp.bat $input",$output);
print_r($output[0]);
?>

