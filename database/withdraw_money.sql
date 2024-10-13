-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 02, 2024 at 10:53 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `withdraw_money`
--

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `class_id` varchar(10) NOT NULL,
  `class_level` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`class_id`, `class_level`) VALUES
('2301', 'ป.1/1'),
('2302', 'ป.1/2'),
('2303', 'ป.1/3'),
('2304', 'ป.1/4'),
('2305', 'ป.1/5'),
('2306', 'ป.1/6');

-- --------------------------------------------------------

--
-- Table structure for table `guardianship`
--

CREATE TABLE `guardianship` (
  `num` varchar(10) NOT NULL,
  `parent_id` varchar(10) NOT NULL,
  `student_id` varchar(10) NOT NULL,
  `relationship` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guardianship`
--

INSERT INTO `guardianship` (`num`, `parent_id`, `student_id`, `relationship`) VALUES
('1', '601', '19001', 'พ่อ'),
('2', '602', '19002', 'แม่'),
('3', '603', '19003', 'พ่อ'),
('4', '604', '19004', 'พ่อ'),
('5', '605', '19005', 'แม่'),
('6', '606', '19006', 'พ่อ'),
('7', '606', '19007', 'พ่อ');

-- --------------------------------------------------------

--
-- Table structure for table `parents`
--

CREATE TABLE `parents` (
  `parent_id` varchar(10) NOT NULL,
  `id_card` varchar(13) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parents`
--

INSERT INTO `parents` (`parent_id`, `id_card`, `name`, `surname`, `phone`, `username`, `password`) VALUES
('601', '2147483647567', 'สมชาย', 'บัวหัน', '0992345667', 'somchai', '19001'),
('602', '1009248364745', 'อรทัย', 'จันทร์ทอง', '0837963987', 'orathai', '19002'),
('603', '3147900483627', 'วิทยา', 'โพธิ์รัตน์', '0812904528', 'wittaya', '19003'),
('604', '2100474782686', 'สุนทร', 'หนูแก้ว', '0627893004', 'sunthorn', '19004'),
('605', '1147483699807', 'รัตนา', 'แสงงาม', '0981569805', 'rattana', '19005'),
('606', '1234765483645', 'พิเชษฐ์', 'ยิ้มแย้ม', '0872780544', 'pichet', '19006');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` varchar(10) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `class_id` varchar(10) DEFAULT NULL,
  `account` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `name`, `surname`, `class_id`, `account`) VALUES
('19001', 'คณากร', 'บัวหัน', '2306', '9230467668'),
('19002', 'ภานุวัฒน์', 'จันทร์ทอง', '2306', '9230467669'),
('19003', 'ชัชพล', 'โพธิ์รัตน์', '2306', '9230467670'),
('19004', 'ณัฐวุฒิ', 'หนูแก้ว', '2306', '9230467671'),
('19005', 'แพรวา', 'ใจดี', '2306', '9230467672'),
('19006', 'ศศิธร', 'ยิ้มแย้ม', '2306', '9230467673'),
('19007', 'สุดา', 'สวยงาม', '2306', '9230467674');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `teacher_id` varchar(10) NOT NULL,
  `id_card` varchar(13) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `class_id` varchar(10) DEFAULT NULL,
  `school_name` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`teacher_id`, `id_card`, `name`, `surname`, `phone`, `class_id`, `school_name`, `username`, `password`) VALUES
('11011', '1103700012345', 'สมชาย', 'ยิ้มหวาน', '0812345678', '2301', 'โรงเรียนวิทยาการอิสลาม', 'somchai', '1234'),
('11012', '1103700012346', 'สมหญิง', 'งามดี', '0812345679', '2302', 'โรงเรียนวิทยาการอิสลาม', 'somying', '1234'),
('11013', '1103700012347', 'สมศักดิ์', 'ศรีสุข', '0812345680', '2303', 'โรงเรียนวิทยาการอิสลาม', 'somsak', '1234'),
('11014', '1103700012348', 'สมศรี', 'รื่นเริง', '0812345681', '2304', 'โรงเรียนวิทยาการอิสลาม', 'somsri', '1234'),
('11015', '1103700012349', 'สมทรง', 'เยี่ยมยอด', '0812345682', '2305', 'โรงเรียนวิทยาการอิสลาม', 'somtrong', '1234'),
('11016', '2103709012348', 'สุดา', 'ใจดี', '0982864456', '2306', 'โรงเรียนวิทยาการอิสลาม', 'suda', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `tran_id` int(10) NOT NULL,
  `account` varchar(10) DEFAULT NULL,
  `transaction_type` varchar(45) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  `approver` varchar(10) DEFAULT NULL,
  `money` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `imagepath` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`tran_id`, `account`, `transaction_type`, `status`, `approver`, `money`, `date`, `time`, `imagepath`) VALUES
(33, '9230467668', 'deposit', NULL, NULL, 50, '2024-08-01', '10:52:26', '1722440463819.png'),
(34, '9230467668', 'withdraw', NULL, NULL, 45, '2024-08-01', '10:55:26', ''),
(35, '9230467668', 'withdraw', NULL, NULL, 50, '2024-08-01', '16:37:28', ''),
(36, '9230467668', 'borrow', NULL, NULL, 50, '2024-08-01', '16:38:30', ''),
(37, '9230467668', 'withdraw', NULL, NULL, 50, '2024-08-01', '16:39:37', ''),
(38, '9230467668', 'withdraw', NULL, NULL, 100, '2024-08-01', '16:45:41', ''),
(39, '9230467669', 'borrow', NULL, NULL, 50, '2024-08-01', '16:50:18', ''),
(40, '9230467669', 'withdraw', NULL, NULL, 12, '2024-08-01', '16:50:37', ''),
(41, '9230467674', 'withdraw', NULL, NULL, 0.5, '2024-08-01', '16:52:12', ''),
(42, '9230467668', 'deposit', NULL, NULL, 50, '2024-08-01', '19:01:26', '1722496750594.png'),
(43, '9230467668', 'deposit', NULL, NULL, 50, '2024-08-01', '19:08:06', '1722496750594.png'),
(44, '9230467668', 'deposit', 'approve', '11016', 50, '2024-08-01', '19:15:20', '1722496750594.png'),
(45, '9230467668', 'deposit', NULL, NULL, 50, '2024-08-01', '19:21:10', '1722496750594.png'),
(46, '9230467668', 'deposit', NULL, NULL, 50, '2024-08-01', '19:25:36', '1722496750594.png'),
(47, '9230467668', 'deposit', NULL, NULL, 50, '2024-08-01', '19:35:26', '1722496750594.png'),
(48, '9230467668', 'deposit', NULL, NULL, 50, '2024-08-01', '19:42:38', '1722496750594.png'),
(49, '9230467668', 'deposit', NULL, NULL, 500, '2024-08-01', '19:52:07', '1722496750594.png'),
(50, '9230467668', 'withdraw', NULL, NULL, 50, '2024-08-01', '21:16:41', ''),
(51, '9230467668', 'deposit', NULL, NULL, 500, '2024-08-01', '21:54:03', '1722496750594.png'),
(52, '9230467668', 'deposit', NULL, NULL, 580, '2024-08-01', '21:58:40', '1722496750594.png'),
(53, '9230467668', 'deposit', NULL, NULL, 500, '2024-08-01', '22:04:19', '1722496750594.png'),
(54, '9230467668', 'deposit', 'approved', '11016', 50, '2024-08-01', '22:16:05', '1722496750594.png'),
(55, '9230467668', 'deposit', NULL, NULL, 50, '2024-08-01', '22:28:34', '1722496750594.png'),
(56, '9230467668', 'deposit', 'approve', '11016', 50, '2024-08-01', '22:36:31', '1722496750594.png'),
(57, '9230467668', 'deposit', 'approve', '11016', 5000, '2024-08-01', '22:40:40', '1722496750594.png'),
(58, '9230467668', 'deposit', 'approve', '11016', 430, '2024-08-01', '22:50:58', '1722496750594.png'),
(59, '9230467668', 'withdraw', NULL, NULL, 5000, '2024-08-01', '22:58:13', ''),
(60, '9230467668', 'withdraw', NULL, NULL, 50, '2024-08-01', '22:58:44', ''),
(61, '9230467672', 'borrow', NULL, NULL, 566, '2024-08-01', '23:47:21', ''),
(62, '9230467672', 'borrow', NULL, NULL, -50, '2024-08-02', '08:03:00', ''),
(63, '9230467672', 'borrow', NULL, NULL, -50, '2024-08-02', '08:11:24', ''),
(64, '9230467672', 'borrow', NULL, NULL, -50, '2024-08-02', '08:11:45', ''),
(65, '9230467672', 'borrow', NULL, NULL, -50, '2024-08-02', '08:11:48', ''),
(66, '9230467672', 'borrow', NULL, NULL, 50, '2024-08-02', '08:17:17', ''),
(67, '9230467668', 'deposit', 'approve', '11016', 500, '2024-08-02', '08:28:45', '1722496750594.png'),
(68, '9230467668', 'deposit', NULL, NULL, 50, '2024-08-02', '08:34:38', '1722496750594.png'),
(69, '9230467668', 'deposit', NULL, NULL, 100, '2024-08-02', '09:17:42', NULL),
(70, '9230467668', 'deposit', NULL, NULL, 100, '2024-07-29', '16:23:50', NULL),
(71, '9230467668', 'deposit', 'approve', '11016', 50, '2024-08-02', '09:25:06', '1722496750594.png'),
(72, '9230467672', 'borrow', NULL, NULL, 50, '2024-08-02', '09:30:39', ''),
(73, '9230467672', 'borrow', NULL, NULL, 58, '2024-08-02', '09:30:53', ''),
(74, '9230467668', 'deposit', 'approve', '11016', 50, '2024-08-02', '11:33:16', '1722496750594.png'),
(75, '9230467668', 'withdraw', NULL, NULL, 50, '2024-08-02', '11:37:49', ''),
(76, '9230467672', 'borrow', NULL, NULL, 100, '2024-08-02', '11:39:20', ''),
(77, '9230467668', 'deposit', 'approve', '11016', 50, '2024-08-02', '13:17:46', '1722496750594.png');

-- --------------------------------------------------------

--
-- Table structure for table `wallet`
--

CREATE TABLE `wallet` (
  `account` varchar(10) NOT NULL,
  `amount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wallet`
--

INSERT INTO `wallet` (`account`, `amount`) VALUES
('9230467668', 250),
('9230467669', 100),
('9230467670', 9.03),
('9230467671', 3),
('9230467672', 0),
('9230467673', 50),
('9230467674', 30);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `guardianship`
--
ALTER TABLE `guardianship`
  ADD PRIMARY KEY (`num`),
  ADD KEY `fk_guardianship_parent1` (`parent_id`),
  ADD KEY `fk_guardianship_student1` (`student_id`);

--
-- Indexes for table `parents`
--
ALTER TABLE `parents`
  ADD PRIMARY KEY (`parent_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `fk_student_account` (`account`),
  ADD KEY `fk_student_class` (`class_id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacher_id`),
  ADD KEY `fk_teacher_class1` (`class_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`tran_id`),
  ADD KEY `fk_transaction_teacher1` (`approver`),
  ADD KEY `fk_transaction_account1` (`account`);

--
-- Indexes for table `wallet`
--
ALTER TABLE `wallet`
  ADD PRIMARY KEY (`account`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `tran_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `guardianship`
--
ALTER TABLE `guardianship`
  ADD CONSTRAINT `fk_guardianship_parent1` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`parent_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_guardianship_student1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `fk_student_account` FOREIGN KEY (`account`) REFERENCES `wallet` (`account`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student_class` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `fk_teacher_class1` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `fk_transaction_account1` FOREIGN KEY (`account`) REFERENCES `wallet` (`account`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_teacher1` FOREIGN KEY (`approver`) REFERENCES `teacher` (`teacher_id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
