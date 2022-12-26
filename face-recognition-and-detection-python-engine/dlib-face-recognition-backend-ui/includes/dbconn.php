<?php
                        date_default_timezone_set("Africa/Nairobi");
                        $db_hostname = "localhost";
                        $db_password = "pass";
                        $db_database = "student_attendance_db";
                        $db_username = "root";
                        $conn = mysqli_connect($db_hostname, $db_username, $db_password, $db_database);
                        if ($conn->connect_error) {
                            die("CONNECTION FAILED:" . $conn->connect_error);
                        }

?>