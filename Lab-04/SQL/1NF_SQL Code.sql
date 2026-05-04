-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2026 at 05:14 PM
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
-- Table structure for table `hospitalvisit_1nf`
--

CREATE TABLE `hospitalvisit_1nf` (
  `VisitID` varchar(10) NOT NULL,
  `VisitDate` date NOT NULL,
  `PatientID` varchar(10) NOT NULL,
  `PatientName` varchar(50) NOT NULL,
  `PtientPhone` varchar(20) NOT NULL,
  `DoctorID` varchar(10) NOT NULL,
  `DoctorName` varchar(50) NOT NULL,
  `Specialty` varchar(50) NOT NULL,
  `DeptName` varchar(50) NOT NULL,
  `DeptHead` varchar(50) NOT NULL,
  `Diagnosis` varchar(100) NOT NULL,
  `Fee` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hospitalvisit_1nf`
--

INSERT INTO `hospitalvisit_1nf` (`VisitID`, `VisitDate`, `PatientID`, `PatientName`, `PtientPhone`, `DoctorID`, `DoctorName`, `Specialty`, `DeptName`, `DeptHead`, `Diagnosis`, `Fee`) VALUES
('V-9001', '2026-04-10', 'P-201', 'Hassan', '0300-1112233', 'D-30', 'Dr.Imran', 'Cardiology', 'Heart Care', 'Dr.Tariq', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'Mehreen', '0301-4445566', 'D-31', 'Dr.Asma', 'Dermatology', 'skin Clinic', 'Dr.Asma', 'Eczema', 2000),
('V-9003', '2026-04-11', 'P-201', 'Hassan', '0300-1112233', 'D-31', 'Dr.Asma', 'Dermatology', 'Skin Clinic', 'Dr.Asma', 'Allergy', 2000),
('V-9004', '2026-04-12', 'P-203', 'Junaid', '0302-7778899', 'D-30', 'Dr.Imran', 'Cardiology', 'Heart Care', 'Dr.Tariq', 'Arrhythmia', 3000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hospitalvisit_1nf`
--
ALTER TABLE `hospitalvisit_1nf`
  ADD PRIMARY KEY (`VisitID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
