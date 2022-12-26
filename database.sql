-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3305
-- Generation Time: Dec 26, 2022 at 03:26 PM
-- Server version: 10.4.22-MariaDB
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
  `id` int(11) NOT NULL,
  `class_unit_id` int(11) NOT NULL,
  `doc` date NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendance_list`
--

INSERT INTO `attendance_list` (`id`, `class_unit_id`, `doc`, `date_created`) VALUES
(1, 1, '2020-10-28', '2020-10-28 20:06:37'),
(20, 5, '2022-11-27', '2022-11-28 01:25:01'),
(21, 5, '2022-11-28', '2022-11-28 02:02:57'),
(22, 5, '2022-11-29', '2022-11-28 03:12:56'),
(23, 5, '2022-12-18', '2022-12-18 14:44:36'),
(24, 7, '2022-12-18', '2022-12-18 15:20:09'),
(25, 7, '2022-12-19', '2022-12-18 15:29:10'),
(26, 8, '2022-12-18', '2022-12-18 15:46:21'),
(27, 5, '2022-12-20', '2022-12-18 22:08:06'),
(28, 5, '2022-12-28', '2022-12-18 22:13:55'),
(29, 5, '2022-12-30', '2022-12-18 23:01:40'),
(30, 5, '2022-12-27', '2022-12-18 23:21:13'),
(31, 5, '2022-12-29', '2022-12-18 23:23:24'),
(32, 5, '2023-01-03', '2022-12-19 00:01:21'),
(33, 5, '2022-12-24', '2022-12-19 00:27:17'),
(34, 5, '2023-01-26', '2022-12-19 01:39:20'),
(35, 5, '2022-12-19', '2022-12-19 01:44:08'),
(36, 5, '2022-12-26', '2022-12-19 02:27:14');

-- --------------------------------------------------------

--
-- Table structure for table `attendance_record`
--

CREATE TABLE `attendance_record` (
  `id` int(11) NOT NULL,
  `attendance_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '0=absent,1=present,2=late',
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
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
(137, 22, 16, 1, '2022-11-28 03:20:17'),
(138, 23, 15, 0, '2022-12-18 14:44:36'),
(139, 23, 16, 0, '2022-12-18 14:44:36'),
(140, 23, 17, 1, '2022-12-18 14:44:36'),
(142, 24, 166, 1, '2022-12-18 15:22:00'),
(143, 24, 16, 0, '2022-12-18 15:28:02'),
(144, 25, 16, 0, '2022-12-18 15:29:10'),
(145, 25, 166, 1, '2022-12-18 15:29:10'),
(148, 26, 167, 1, '2022-12-18 15:51:47'),
(149, 27, 15, 0, '2022-12-18 22:08:06'),
(150, 27, 17, 1, '2022-12-18 22:08:06'),
(151, 28, 15, 0, '2022-12-18 22:13:55'),
(152, 28, 17, 1, '2022-12-18 22:13:55'),
(153, 29, 15, 0, '2022-12-18 23:01:40'),
(154, 29, 17, 1, '2022-12-18 23:01:40'),
(881, 35, 15, 0, '2022-12-19 11:25:05'),
(882, 35, 17, 1, '2022-12-19 11:25:05');

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `level` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=Active, 0=Inactive',
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `course_id`, `level`, `section`, `status`, `date_created`) VALUES
(1, 2, '1', '2', 1, '2020-10-28 10:48:45'),
(2, 2, '4', '2', 1, '2020-10-28 10:52:58'),
(4, 6, '4', '2', 1, '2022-11-26 15:06:49'),
(5, 7, '3', '2', 1, '2022-12-18 14:57:54'),
(6, 8, '1', '2', 1, '2022-12-18 15:41:19'),
(7, 9, '2', '2', 1, '2022-12-19 03:04:55'),
(8, 10, '3', '1', 1, '2022-12-19 03:05:07'),
(9, 11, '2', '3', 1, '2022-12-19 03:05:18'),
(10, 3, '3', '2', 1, '2022-12-19 03:05:28'),
(11, 4, '3', '2', 1, '2022-12-19 03:05:38');

-- --------------------------------------------------------

--
-- Table structure for table `class_unit`
--

CREATE TABLE `class_unit` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `faculty_id` int(11) NOT NULL,
  `student_ids` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `class_unit`
--

INSERT INTO `class_unit` (`id`, `class_id`, `unit_id`, `faculty_id`, `student_ids`, `date_created`) VALUES
(1, 2, 1, 1, '', '0000-00-00 00:00:00'),
(2, 1, 2, 1, '', '0000-00-00 00:00:00'),
(5, 4, 4, 2, NULL, '2022-11-27 10:43:01'),
(6, 4, 5, 2, NULL, '2022-11-27 16:21:44'),
(7, 5, 6, 3, NULL, '2022-12-18 15:19:22'),
(8, 6, 7, 4, NULL, '2022-12-18 15:45:34');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `course` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `course`, `description`, `date_created`) VALUES
(1, 'BSc. Mathematics and Computer Science', 'Students aspiring to study  the degree of B.Sc. in Mathematics and Computer Science must satisfy the Minimum University requirements and Faculty of Science entry requirements. ', '2020-10-28 10:00:41'),
(2, 'BSc in Mathematics', 'Students taking Mathematics as a major subject can either choose to major in Mathematics alone or in Mathematics and Computer Science courses, depending on their performances in the second year. The duration of this course is four years. Under this programme Mathematics can be studied as major, regular or minor subject in each of the third and fourth years. Students taking Mathematics and Computer Science can either major in Pure Mathematics and Computer Science, Applied Mathematics and Computer Science or Statistics and Computer Science in their third year of study.Under this programme a student may pursue an area leading to the following degree awards\r\na.    Bachelor of science in Mathematics\r\nb.    Bachelor of science in Mathematics and computer science\r\nc.    Bachelor of science (General)', '2020-10-28 10:02:09'),
(3, 'BSc. Biochemistry & Molecular Biology', 'Like other developing countries Kenya need to develop its scientific base in order to find effective and logically relevant solutions to problems of health, food security, industrial development and environmental protection. Biochemistry therefore remains an essential discipline and continues to play a catalytic role. This programme covers areas of Molecular Biology and Biotechnology, Medical Biochemistry, Industrial and Nutritional Biochemistry, Biochemical Pharmacology and Immunochemistry. Courses addressing the said areas are contained in this programme making it unique among other similar programmes in the country. Consequently students graduating from this programme have been absorbed in local and international research institutions involved in multi-disciplinary life sciences research. Others are developing careers in production, quality assurance and technical sales in food, beverages and pharmaceutical sectors, cosmetics industries, hospital diagnostics and environmental health protection.', '2020-10-28 10:02:16'),
(4, 'BSc. Actuarial Science', 'Mean grade C+, Mathematics B-, English C+', '2020-10-28 10:02:24'),
(6, 'BSc. Computer technology', 'A four year degree offered by many universities. It focuses on developing skills for working with modern computerized systems. Many areas of specialization are offered. Students may focus on areas involving the use and design of hardware or software.', '2022-11-26 15:03:39'),
(7, 'Bsc. Architecture', 'All about buildings', '2022-12-18 14:53:10'),
(8, 'Bachelor of Commerce', 'KCSE Mean grade C+ with C in Maths and English or two principal passes in KACE or Credit in relevant Diploma.', '2022-12-18 15:40:44'),
(9, 'BSc. Mechanical Engineering', 'This is an engineering discipline that involves the application of science for the analysis, design, manufacturing, and maintenance of mechanical systems.', '2022-12-19 02:53:18'),
(10, 'BSc. Computer Science', 'The course emphasizes the architecture of both the hardware and software, converting a typical Computer from a box of electronics into a sophisticated information processing tool. It focuses on the ways in which computer hardware and software are constructed, and provide an insight into the purpose of each of the major computing systems.', '2022-12-19 02:54:38'),
(11, 'BSc. Information Technology', '', '2022-12-19 02:55:14');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int(11) NOT NULL,
  `id_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `id_no`, `name`, `email`, `contact`, `address`, `date_created`) VALUES
(1, '06232014', 'John Smith', 'jsmith@sample.com', '+18456-5455-55', 'Sample Only', '2020-10-28 11:32:18'),
(2, '36808815', 'School of computing and IT', 'eivuto@gmail.com', '', '173', '2022-11-26 15:07:18'),
(3, 'ARC111', 'School of Architecture and Building Sciences', 'eivuto@gmail.com', '0710293886', '173', '2022-12-18 14:58:39'),
(4, 'BUS123', 'School of Business and Entrepreneurship', 'eivut1@gmail.com', '0710293888', '174', '2022-12-18 15:39:07');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `id_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `class_id` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_photo` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `id_no`, `class_id`, `name`, `student_photo`, `date_created`) VALUES
(2, 'SCT212-0561/2018', 2, 'EDDIE MWANGI MUIRURI', 'SCT212-0561-2018.JPG', '2020-10-28 15:20:57'),
(15, 'SCT212-0562/2020', 4, 'JAMES MWANGI MACHARIA', 'SCT212-0562-2020.jpg', '2022-11-27 21:41:14'),
(16, 'SCT212-069/2018', 5, 'MARK TED', 'SCT212-069-2018.jpg', '2022-11-27 13:23:09'),
(17, 'SCT212-0562/2018', 4, 'ERICK IVUTO MUTUNGA', 'SCT212-0562-2018.JPG', '2022-11-27 21:47:37'),
(166, 'ABS221-063/2019', 5, 'STEPHANIE OMONDI', 'ABS221-063-2019.png', '2022-12-18 15:15:36'),
(167, 'HDR123-374/2018', 6, 'TOBIAS MAKOHA', 'HDR123-374-2018.jpg', '2022-12-18 15:43:05'),
(168, 'HBR123-456/2018', 6, 'DENNIS MUITA', 'HBR123-456-2018.jpg', '2022-12-19 07:56:44'),
(169, 'HBR123-789/2018', 6, 'MAURICE OTIENO', 'HBR123-789-2018.jpg', '2022-12-19 07:58:18'),
(171, 'HBR123-102/2018', 6, 'JANET JACKSON', 'HBR123-102-2018.jpg', '2022-12-19 08:02:58'),
(172, 'HBR123-483/2018', 6, 'STACY WASHINGTON', 'HBR123-483-2018.jpg', '2022-12-19 08:04:37'),
(173, 'HBR123-045/2018', 6, 'DENNIS WASIKE', 'HBR123-045-2018.jpg', '2022-12-19 08:07:30'),
(174, 'SCT234-875/2019', 4, 'STUDENT ONE', 'SCT234-875-2019.jpg', '2022-12-19 11:23:31');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover_img` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `about_content` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `name`, `email`, `contact`, `cover_img`, `about_content`) VALUES
(1, 'Face recognition attendance system', 'info@sample.comm', '0710293886', '1603344720_1602738120_pngtree-purple-hd-business-banner-image_5493.jpg', '&lt;p style=&quot;text-align: center; background: transparent; position: relative;&quot;&gt;&lt;span style=&quot;color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif; font-weight: 400; text-align: justify;&quot;&gt;&amp;nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;text-align: center; background: transparent; position: relative;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p style=&quot;text-align: center; background: transparent; position: relative;&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;/p&gt;');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `unit` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit`, `description`, `date_created`) VALUES
(1, 'SBH 2203 Basic Metabolism I', '', '2020-10-28 10:29:53'),
(2, 'ICS 2104 Object Oriented Programming I', '', '2020-10-28 10:30:48'),
(3, 'ICS 2204 Programming Languages', '', '2020-10-28 10:30:57'),
(4, 'BCT 1123 Computer Architecture', '', '2022-11-26 15:04:33'),
(5, 'BCT 2129 Systems Maintenance', '', '2022-11-27 16:19:38'),
(6, 'ABA 2301 Landscape Design', '', '2022-12-18 14:56:59'),
(7, 'HBC 2105 Business studies', '', '2022-12-18 15:41:04'),
(8, 'SMA 2100 Discrete Mathematics', '', '2022-12-19 03:01:30'),
(9, 'STA 2100 Probability and Statistics I', '', '2022-12-19 03:01:46'),
(10, 'SMA 2304 Ordinary Differential Equations I', '', '2022-12-19 03:02:09'),
(11, 'ICS 2205 Digital Logic', '', '2022-12-19 03:02:29'),
(12, 'STA 2105 Calculus for Statistics II', '', '2022-12-19 03:02:39'),
(13, 'EME 2103 Introduction to Material Science', '', '2022-12-19 03:02:51'),
(14, 'EME 2202 Machine Elements I', '', '2022-12-19 03:03:02');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 3 COMMENT '1=Admin,2=Staff',
  `faculty_id` int(11) NOT NULL COMMENT 'for faculty user only'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `type`, `faculty_id`) VALUES
(1, 'Admin', 'admin', '1a1dc91c907325c69271ddf0c944bc72', 1, 0),
(2, 'College of Engineering & Technology', 'jsmith@sample.com', 'a786eef74a1e571bb1cc82a42d86e571', 2, 1),
(3, 'School of computing and IT', 'eivuto@gmail.com', 'f29e7dd5b0137c7ca4e110739b67de40', 2, 2),
(4, 'School of Architecture and Building Sciences', 'eivuto@gmail.com', 'f04de15090b598f0f8f225c797032921', 2, 3),
(5, 'School of Business and Entrepreneurship', 'eivut1@gmail.com', '49dc5ca6d5c57faa691686a110715134', 2, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance_list`
--
ALTER TABLE `attendance_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_unit_id` (`class_unit_id`);

--
-- Indexes for table `attendance_record`
--
ALTER TABLE `attendance_record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendance_id` (`attendance_id`,`student_id`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `class_unit`
--
ALTER TABLE `class_unit`
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
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance_list`
--
ALTER TABLE `attendance_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `attendance_record`
--
ALTER TABLE `attendance_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=883;

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `class_unit`
--
ALTER TABLE `class_unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=175;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
