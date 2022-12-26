<?php
include("../includes/dbconn.php");

$date = $_POST['date'];
$time = $_POST['time'];
$name = $_POST['name'];


$class_subject_id = $_POST['var1'];
$date_selected = $_POST['var2'];
$new_date_selected = date("Y-m-d");



$type = 1;
$absent = 0;
$portion = strrchr($name, '-');
$student_reg_no = str_replace($portion, ("/" . substr($portion, 1)), $name);
$date_today = date("Y-m-d");


$stmt = $conn->prepare("SELECT `class_id` FROM `class_subject` WHERE `id` = ?");
$stmt->bind_param("s",$class_subject_id);
$stmt->execute();
$stmt->store_result();
$stmt->bind_result($class_id);
$stmt->fetch();

$stmt = $conn->prepare("SELECT `id` FROM `students` WHERE `class_id` = ?");
$stmt->bind_param("s",$class_id);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $array_student_ids[] = $row;
}
for ($i=0; $i < sizeof($array_student_ids); $i++) { 
	$student_ids[$i] = $array_student_ids[$i]['id'];
}

$stmt = $conn->prepare("SELECT `id` FROM `students` WHERE `id_no` = ? LIMIT 1");
$stmt->bind_param("s",$student_reg_no);
$stmt->execute();
$stmt->store_result();
$stmt->bind_result($student_id_no);
$stmt->fetch();



$stmt = $conn->prepare("SELECT `id` FROM `attendance_list` WHERE `class_subject_id` = ? AND `doc` = ? LIMIT 1");
$stmt->bind_param("ss",$class_subject_id,$date_selected);
$stmt->execute();
$stmt->store_result();
$stmt->bind_result($attendance_list_exists);
$stmt->fetch();

if ($attendance_list_exists == null) {
	$stmt = $conn->prepare("INSERT INTO `attendance_list` (`class_subject_id`,`doc`)VALUES(?,?)");
	$stmt->bind_param("ss",$class_subject_id,$date_selected);
    if($stmt->execute()){
        $stmt->insert_id;
        $array_result=array();
         foreach ($stmt as $key => $value) {
         $array_result[$key]=$stmt->$key;
        }
    }
    $attendance_list_id =  $array_result['insert_id'];

	$student_ids_neww = $student_ids;

	if (($key = array_search($student_id_no, $student_ids_neww)) != false) {
	    unset($student_ids_neww[$key]);
	}

	for ($y=0; $y < sizeof($student_ids_neww); $y++) { 
		$id___no = $student_ids_neww[$y];

		$stmt = $conn->prepare("SELECT `id` FROM `attendance_record` WHERE `attendance_id` = ? AND `student_id` = ? AND (`type` = ? OR `type` = ?) AND DATE(`date_created`) = ? LIMIT 1");
		
		$stmt->bind_param("sssss",$attendance_list_id,$id___no,$type,$absent,$new_date_selected);
		$stmt->execute();
		$stmt->store_result();
		$stmt->bind_result($record_exists);
		$stmt->fetch();

		if($record_exists == null){
			$stmt = $conn->prepare("INSERT INTO `attendance_record` (`attendance_id`,`student_id`,`type`)VALUES(?,?,?)");
			$stmt->bind_param("sss",$attendance_list_id,$id___no,$absent);
			$stmt->execute();
		}
	}

    if (in_array($student_id_no, $student_ids)) {

		$stmt = $conn->prepare("SELECT `id` FROM `attendance_record` WHERE `attendance_id` = ? AND `student_id` = ? AND `type` = ? AND DATE(`date_created`) = ? LIMIT 1");
		$stmt->bind_param("ssss",$attendance_list_id,$student_id_no,$type,$new_date_selected);
		$stmt->execute();
		$stmt->store_result();
		$stmt->bind_result($exists_stude);
		$stmt->fetch();
    	


    	if($exists_stude == null){
			$stmt = $conn->prepare("SELECT `id`,`type` FROM `attendance_record` WHERE `attendance_id` = ? AND `student_id` = ? AND `type` = ? AND DATE(`date_created`) = ? LIMIT 1");
			$stmt->bind_param("ssss",$attendance_list_id,$student_id_no,$type,$new_date_selected);
			$stmt->execute();
			$stmt->store_result();
			$stmt->bind_result($rec_id,$type_fetched);
			$stmt->fetch();

			if($type_fetched == null){
				$stmt = $conn->prepare("INSERT INTO `attendance_record` (`attendance_id`,`student_id`,`type`)VALUES(?,?,?)");
				$stmt->bind_param("sss",$attendance_list_id,$student_id_no,$type);
				$stmt->execute();

				$stmt = $conn->prepare("DELETE FROM `attendance_record` WHERE `attendance_id` = ? AND `student_id` = ? AND `type` = ? AND DATE(`date_created`) = ?");
				$stmt->bind_param("ssss",$attendance_list_id,$student_id_no,$absent,$new_date_selected);
				$stmt->execute();
			}elseif ($type_fetched == "0") {
				$stmt = $conn->prepare("UPDATE `attendance_record` SET `type` = ? WHERE `id` = ?");
				$stmt->bind_param("si",$type,$rec_id1);
				$stmt->execute();
			}
		}


		echo "Attendance recorded for:- ".$student_reg_no;

	}else{
		echo "Attendance NOT recorded for: ".$student_reg_no. ". Student is not enrolled to course class";
	}
}else{
	$stmt = $conn->prepare("SELECT `id` FROM `attendance_record` WHERE `attendance_id` = ? AND `student_id` = ? AND `type` = ? AND DATE(`date_created`) = ? LIMIT 1");
	$stmt->bind_param("ssss",$attendance_list_exists,$student_id_no,$type,$new_date_selected);
	$stmt->execute();
	$stmt->store_result();
	$stmt->bind_result($exists);
	$stmt->fetch();


	$student_ids_neww = $student_ids;

	if (($key = array_search($student_id_no, $student_ids_neww)) != false) {
	    unset($student_ids_neww[$key]);
	}

	for ($y=0; $y < sizeof($student_ids_neww); $y++) { 
		$id___no = $student_ids_neww[$y];

		$stmt = $conn->prepare("SELECT `id` FROM `attendance_record` WHERE `attendance_id` = ? AND `student_id` = ? AND (`type` = ? OR `type` = ?) AND DATE(`date_created`) = ? LIMIT 1");
		
		$stmt->bind_param("sssss",$attendance_list_exists,$id___no,$type,$absent,$new_date_selected);
		$stmt->execute();
		$stmt->store_result();
		$stmt->bind_result($record_exists);
		$stmt->fetch();

		if($record_exists == null){
			$stmt = $conn->prepare("INSERT INTO `attendance_record` (`attendance_id`,`student_id`,`type`)VALUES(?,?,?)");
			$stmt->bind_param("sss",$attendance_list_exists,$id___no,$absent);
			$stmt->execute();
		}
	}
	//file_put_contents("list.txt", "val: $attendance_list_exists");

	if (in_array($student_id_no, $student_ids)) {
		if($exists == null){

			$stmt = $conn->prepare("SELECT `id`,`type` FROM `attendance_record` WHERE `attendance_id` = ? AND `student_id` = ? AND `type` = ? AND DATE(`date_created`) = ? LIMIT 1");
			$stmt->bind_param("ssss",$attendance_list_exists,$student_id_no,$type,$new_date_selected);
			$stmt->execute();
			$stmt->store_result();
			$stmt->bind_result($rec_id1,$type_fetched1);
			$stmt->fetch();

			if($type_fetched1 == null){
				$stmt = $conn->prepare("INSERT INTO `attendance_record` (`attendance_id`,`student_id`,`type`)VALUES(?,?,?)");
				$stmt->bind_param("sss",$attendance_list_exists,$student_id_no,$type);
				$stmt->execute();

				$stmt = $conn->prepare("DELETE FROM `attendance_record` WHERE `attendance_id` = ? AND `student_id` = ? AND `type` = ? AND DATE(`date_created`) = ?");
				$stmt->bind_param("ssss",$attendance_list_exists,$student_id_no,$absent,$new_date_selected);
				$stmt->execute();

			}elseif ($type_fetched1 == "0") {
				$stmt = $conn->prepare("UPDATE `attendance_record` SET `type` = ? WHERE `id` = ?");
				$stmt->bind_param("si",$type,$rec_id1);
				$stmt->execute();
			}



			echo "Attendance recorded for: ".$student_reg_no;
		}else{
			echo "Attendance was already recorded for: ".$student_reg_no;
		}
	}else{
		echo "Attendance NOT recorded for: ".$student_reg_no. ". Student is not enrolled to course class";
	}	
}
?>