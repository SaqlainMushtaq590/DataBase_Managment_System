-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2026 at 09:21 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital_visits`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `DoctorID` varchar(10) NOT NULL,
  `DoctorName` varchar(50) NOT NULL,
  `Specialty` varchar(50) NOT NULL,
  `DeptName` varchar(50) NOT NULL,
  `DeptHead` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`DoctorID`, `DoctorName`, `Specialty`, `DeptName`, `DeptHead`) VALUES
('D-30', 'Dr. Imran', 'Cardiology', 'Heart Care', 'Dr. Tariq'),
('D-31', 'Dr. Asma', 'Dermatology', 'Skin Clinic', 'Dr. Asma');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PatientID` varchar(10) NOT NULL,
  `PatientName` varchar(50) NOT NULL,
  `PatientPhone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PatientID`, `PatientName`, `PatientPhone`) VALUES
('P-201', 'Hassan', '0300-1112233'),
('P-202', 'Mehreen', '0301-4445566'),
('P-203', 'Junaid', '0302-7778899');

-- --------------------------------------------------------

--
-- Table structure for table `visit`
--

CREATE TABLE `visit` (
  `VisitID` varchar(10) NOT NULL,
  `VisitDate` date NOT NULL,
  `PatientID` varchar(10) NOT NULL,
  `DoctorID` varchar(10) NOT NULL,
  `Diagnosis` varchar(100) NOT NULL,
  `Fee` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visit`
--

INSERT INTO `visit` (`VisitID`, `VisitDate`, `PatientID`, `DoctorID`, `Diagnosis`, `Fee`) VALUES
('V-9001', '2026-04-10', 'P-201', 'D-30', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'D-31', 'Eczema', 2000),
('V-9003', '2026-04-11', 'P-201', 'D-31', 'Allergy', 2000),
('V-9004', '2026-04-12', 'P-203', 'D-30', 'Arrhythmia', 3000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`DoctorID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PatientID`);

--
-- Indexes for table `visit`
--
ALTER TABLE `visit`
  ADD PRIMARY KEY (`VisitID`),
  ADD KEY `PatientID` (`PatientID`),
  ADD KEY `DoctorID` (`DoctorID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `visit`
--
ALTER TABLE `visit`
  ADD CONSTRAINT `visit_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `visit_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `doctor` (`DoctorID`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
