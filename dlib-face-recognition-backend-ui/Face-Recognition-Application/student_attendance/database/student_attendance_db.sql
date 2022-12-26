-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2022 at 01:31 PM
-- Server version: 8.0.30
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student_attendance_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance_list`
--

CREATE TABLE `attendance_list` (
  `id` int NOT NULL,
  `class_subject_id` int NOT NULL,
  `doc` date NOT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendance_list`
--

INSERT INTO `attendance_list` (`id`, `class_subject_id`, `doc`, `date_created`) VALUES
(1, 1, '2020-10-28', '2020-10-28 20:06:37'),
(20, 5, '2022-11-27', '2022-11-28 01:25:01'),
(21, 5, '2022-11-28', '2022-11-28 02:02:57'),
(22, 5, '2022-11-29', '2022-11-28 03:12:56');

-- --------------------------------------------------------

--
-- Table structure for table `attendance_record`
--

CREATE TABLE `attendance_record` (
  `id` int NOT NULL,
  `attendance_id` int NOT NULL,
  `student_id` int NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '0=absent,1=present,2=late',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendance_record`
--

INSERT INTO `attendance_record` (`id`, `attendance_id`, `student_id`, `type`, `date_created`) VALUES
(1, 1, 1, 1, '2020-10-28 20:06:37'),
(2, 1, 2, 2, '2020-10-28 20:06:37'),
(131, 21, 15, 1, '2022-11-28 02:18:23'),
(132, 21, 17, 1, '2022-11-28 02:18:31'),
(133, 22, 15, 0, '2022-11-28 03:12:56'),
(135, 22, 17, 1, '2022-11-28 03:12:56'),
(136, 21, 16, 1, '2022-11-28 03:18:39'),
(137, 22, 16, 1, '2022-11-28 03:20:17');

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `id` int NOT NULL,
  `course_id` int NOT NULL,
  `level` varchar(50) NOT NULL,
  `section` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=Active, 0=Inactive',
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `course_id`, `level`, `section`, `status`, `date_created`) VALUES
(1, 2, '1', 'B', 1, '2020-10-28 10:48:45'),
(2, 2, '1', 'A', 1, '2020-10-28 10:52:58'),
(4, 6, '4', '2', 1, '2022-11-26 15:06:49');

-- --------------------------------------------------------

--
-- Table structure for table `class_subject`
--

CREATE TABLE `class_subject` (
  `id` int NOT NULL,
  `class_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `faculty_id` int NOT NULL,
  `student_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `class_subject`
--

INSERT INTO `class_subject` (`id`, `class_id`, `subject_id`, `faculty_id`, `student_ids`, `date_created`) VALUES
(1, 2, 1, 1, '', '0000-00-00 00:00:00'),
(2, 1, 2, 1, '', '0000-00-00 00:00:00'),
(5, 4, 4, 2, NULL, '2022-11-27 10:43:01'),
(6, 4, 5, 2, NULL, '2022-11-27 16:21:44');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int NOT NULL,
  `course` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `course`, `description`, `date_created`) VALUES
(1, 'Sample Course', 'Sample Course', '2020-10-28 10:00:41'),
(2, 'Course 2', ' Course 2', '2020-10-28 10:02:09'),
(3, 'Course 3', ' Course 3', '2020-10-28 10:02:16'),
(4, 'Course 4', ' Course 4', '2020-10-28 10:02:24'),
(6, 'BSc. Computer technology', 'A four year degree offered by many universities. It focuses on developing skills for working with modern computerized systems. Many areas of specialization are offered. Students may focus on areas involving the use and design of hardware or software.', '2022-11-26 15:03:39');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int NOT NULL,
  `id_no` varchar(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(200) NOT NULL,
  `contact` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `id_no`, `name`, `email`, `contact`, `address`, `date_created`) VALUES
(1, '06232014', 'John Smith', 'jsmith@sample.com', '+18456-5455-55', 'Sample Only', '2020-10-28 11:32:18'),
(2, '36808815', 'School of computing and IT', 'eivuto@gmail.com', '', '173', '2022-11-26 15:07:18');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int NOT NULL,
  `id_no` varchar(50) NOT NULL,
  `class_id` int NOT NULL,
  `name` text NOT NULL,
  `student_photo` text,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `id_no`, `class_id`, `name`, `student_photo`, `date_created`) VALUES
(2, 'SCT212-0561/2018', 2, 'EDDIE MWANGI MUIRURI', 'SCT212-0561-2018.JPG', '2020-10-28 15:20:57'),
(15, 'SCT212-0562/2020', 4, 'JAMES MWANGI MACHARIA', 'SCT212-0562-2020.jpg', '2022-11-27 21:41:14'),
(16, 'SCT212-069/2018', 4, 'SHIRLEEN RUTTOH', 'SCT212-069-2018.JPG', '2022-11-27 13:23:09'),
(17, 'SCT212-0562/2018', 4, 'ERICK IVUTO MUTUNGA', 'SCT212-0562-2018.JPG', '2022-11-27 21:47:37');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int NOT NULL,
  `subject` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `subject`, `description`, `date_created`) VALUES
(1, 'Subject 1 ', 'Subject 1 ', '2020-10-28 10:29:53'),
(2, 'Subject 2', 'Subject 2', '2020-10-28 10:30:48'),
(3, 'Subject 3', 'Subject 3', '2020-10-28 10:30:57'),
(4, 'BCT 1123 Computer Architecture', '', '2022-11-26 15:04:33'),
(5, 'BCT 2129 Systems Maintenance', '', '2022-11-27 16:19:38');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int NOT NULL,
  `name` text NOT NULL,
  `email` varchar(200) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `cover_img` text NOT NULL,
  `about_content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `name`, `email`, `contact`, `cover_img`, `about_content`) VALUES
(1, 'Face recongition attendace system', 'info@sample.comm', '+6948 8542 623', '1603344720_1602738120_pngtree-purple-hd-business-banner-image_5493.jpg', '&lt;p style=&quot;text-align: center; background: transparent; position: relative;&quot;&gt;&lt;span style=&quot;color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif; font-weight: 400; text-align: justify;&quot;&gt;&amp;nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;text-align: center; background: transparent; position: relative;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;text-align: center; background: transparent; position: relative;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;/p&gt;');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` text NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` text NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '3' COMMENT '1=Admin,2=Staff',
  `faculty_id` int NOT NULL COMMENT 'for faculty user only'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `type`, `faculty_id`) VALUES
(1, 'person', 'admini', '0192023a7bbd73250516f069df18b500', 2, 0),
(2, 'John Smith', 'jsmith@sample.com', 'af606ddc433ae6471f104872585cf880', 3, 1),
(3, 'School of computing and IT', 'eivuto@gmail.com', 'a16a43bbaa0a3436e034a060e33ec64e', 3, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance_list`
--
ALTER TABLE `attendance_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance_record`
--
ALTER TABLE `attendance_record`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `class_subject`
--
ALTER TABLE `class_subject`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance_list`
--
ALTER TABLE `attendance_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `attendance_record`
--
ALTER TABLE `attendance_record`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `class_subject`
--
ALTER TABLE `class_subject`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=165;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
