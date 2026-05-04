-- ============================================================
--  DATABASE NORMALIZATION — Complete SQL File
--  Hospital Patient Visits (Assessment Problem — Task 8)
--  Course: Database Systems | Lab Manual
--  Normalization: UNF → 1NF → 2NF → 3NF
--  Server: XAMPP / MySQL 8.x
-- ============================================================

CREATE DATABASE IF NOT EXISTS hospital_normalization;
USE hospital_normalization;

-- ============================================================
-- SECTION 0: CLEANUP (run this if re-executing the file)
-- ============================================================

DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS HospitalVisit_1NF;


-- ============================================================
-- SECTION 1: 1NF — First Normal Form
-- Rule: Atomic values, no repeating groups, PK defined
-- Primary Key: VisitID (single column)
-- Tables: 1 (HospitalVisit_1NF)
-- ============================================================

CREATE TABLE HospitalVisit_1NF (
    VisitID      VARCHAR(10)  NOT NULL,
    VisitDate    DATE         NOT NULL,
    PatientID    VARCHAR(10)  NOT NULL,
    PatientName  VARCHAR(50)  NOT NULL,
    PatientPhone VARCHAR(20)  NOT NULL,
    DoctorID     VARCHAR(10)  NOT NULL,
    DoctorName   VARCHAR(50)  NOT NULL,
    Specialty    VARCHAR(50)  NOT NULL,
    DeptName     VARCHAR(50)  NOT NULL,
    DeptHead     VARCHAR(50)  NOT NULL,
    Diagnosis    VARCHAR(100) NOT NULL,
    Fee          INT          NOT NULL,
    PRIMARY KEY (VisitID)
);

INSERT INTO HospitalVisit_1NF VALUES
('V-9001', '2026-04-10', 'P-201', 'Hassan',  '0300-1112233', 'D-30', 'Dr. Imran', 'Cardiology',  'Heart Care',  'Dr. Tariq', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'Mehreen', '0301-4445566', 'D-31', 'Dr. Asma',  'Dermatology', 'Skin Clinic', 'Dr. Asma',  'Eczema',        2000),
('V-9003', '2026-04-11', 'P-201', 'Hassan',  '0300-1112233', 'D-31', 'Dr. Asma',  'Dermatology', 'Skin Clinic', 'Dr. Asma',  'Allergy',       2000),
('V-9004', '2026-04-12', 'P-203', 'Junaid',  '0302-7778899', 'D-30', 'Dr. Imran', 'Cardiology',  'Heart Care',  'Dr. Tariq', 'Arrhythmia',    3000);

-- Verify 1NF
SELECT * FROM HospitalVisit_1NF;

-- Issues remaining in 1NF:
-- Hassan's name/phone repeats in rows 1 & 3 (PatientID = P-201)
-- Dr. Imran's info repeats in rows 1 & 4 (DoctorID = D-30)
-- Dr. Asma's info repeats in rows 2 & 3 (DoctorID = D-31)
-- These partial dependencies will be fixed in 2NF


-- ============================================================
-- SECTION 2: 2NF — Second Normal Form
-- Rule: 1NF + no partial dependencies
-- Each attribute must depend on the WHOLE primary key
-- Tables: 3 (Patient, Doctor, Visit)
-- ============================================================

-- Drop 1NF table before creating 2NF tables
DROP TABLE IF EXISTS HospitalVisit_1NF;

-- ── TABLE 1: Patient ─────────────────────────────────────────
-- PatientID → PatientName, PatientPhone
CREATE TABLE Patient (
    PatientID    VARCHAR(10) NOT NULL,
    PatientName  VARCHAR(50) NOT NULL,
    PatientPhone VARCHAR(20) NOT NULL,
    PRIMARY KEY  (PatientID)
);

-- ── TABLE 2: Doctor ──────────────────────────────────────────
-- DoctorID → DoctorName, Specialty, DeptName, DeptHead
-- Note: DeptName → DeptHead is still a transitive dep (fixed in 3NF)
CREATE TABLE Doctor (
    DoctorID   VARCHAR(10) NOT NULL,
    DoctorName VARCHAR(50) NOT NULL,
    Specialty  VARCHAR(50) NOT NULL,
    DeptName   VARCHAR(50) NOT NULL,
    DeptHead   VARCHAR(50) NOT NULL,
    PRIMARY KEY (DoctorID)
);

-- ── TABLE 3: Visit ────────────────────────────────────────────
-- VisitID → VisitDate, PatientID(FK), DoctorID(FK), Diagnosis, Fee
CREATE TABLE Visit (
    VisitID    VARCHAR(10)  NOT NULL,
    VisitDate  DATE         NOT NULL,
    PatientID  VARCHAR(10)  NOT NULL,
    DoctorID   VARCHAR(10)  NOT NULL,
    Diagnosis  VARCHAR(100) NOT NULL,
    Fee        INT          NOT NULL,
    PRIMARY KEY (VisitID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (DoctorID)  REFERENCES Doctor(DoctorID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ── INSERT Data (2NF) ─────────────────────────────────────────
INSERT INTO Patient VALUES
('P-201', 'Hassan',  '0300-1112233'),
('P-202', 'Mehreen', '0301-4445566'),
('P-203', 'Junaid',  '0302-7778899');

INSERT INTO Doctor VALUES
('D-30', 'Dr. Imran', 'Cardiology',  'Heart Care',  'Dr. Tariq'),
('D-31', 'Dr. Asma',  'Dermatology', 'Skin Clinic', 'Dr. Asma');

INSERT INTO Visit VALUES
('V-9001', '2026-04-10', 'P-201', 'D-30', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'D-31', 'Eczema',       2000),
('V-9003', '2026-04-11', 'P-201', 'D-31', 'Allergy',      2000),
('V-9004', '2026-04-12', 'P-203', 'D-30', 'Arrhythmia',   3000);

-- Verify 2NF tables
SELECT * FROM Patient;
SELECT * FROM Doctor;
SELECT * FROM Visit;

-- Rebuild original report using JOINs (2NF)
SELECT
    v.VisitID, v.VisitDate,
    p.PatientID, p.PatientName, p.PatientPhone,
    d.DoctorID, d.DoctorName, d.Specialty,
    d.DeptName, d.DeptHead,
    v.Diagnosis, v.Fee
FROM  Visit v
JOIN  Patient p ON v.PatientID = p.PatientID
JOIN  Doctor  d ON v.DoctorID  = d.DoctorID
ORDER BY v.VisitDate;

-- Issues remaining in 2NF:
-- Doctor table: DoctorID → DeptName → DeptHead (transitive dependency)
-- DeptHead depends on DeptName, NOT directly on DoctorID
-- This will be fixed in 3NF by extracting Department into its own table


-- ============================================================
-- SECTION 3: 3NF — Third Normal Form
-- Rule: 2NF + no transitive dependencies
-- Every non-key attribute depends ONLY on the primary key
-- Tables: 4 (Patient, Department, Doctor, Visit)
-- ============================================================

-- Must drop Visit first (FK to Doctor), then Doctor
DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Doctor;

-- ── TABLE: Department (NEW — extracted from Doctor) ───────────
-- DeptName → DeptHead  (DeptHead now directly depends on PK)
CREATE TABLE Department (
    DeptName VARCHAR(50) NOT NULL,
    DeptHead VARCHAR(50) NOT NULL,
    PRIMARY KEY (DeptName)
);

-- ── TABLE: Doctor (updated — DeptHead removed, DeptName = FK) ─
-- DoctorID → DoctorName, Specialty, DeptName(FK)
CREATE TABLE Doctor (
    DoctorID   VARCHAR(10) NOT NULL,
    DoctorName VARCHAR(50) NOT NULL,
    Specialty  VARCHAR(50) NOT NULL,
    DeptName   VARCHAR(50) NOT NULL,
    PRIMARY KEY (DoctorID),
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ── TABLE: Visit (re-created — same structure as 2NF) ─────────
CREATE TABLE Visit (
    VisitID    VARCHAR(10)  NOT NULL,
    VisitDate  DATE         NOT NULL,
    PatientID  VARCHAR(10)  NOT NULL,
    DoctorID   VARCHAR(10)  NOT NULL,
    Diagnosis  VARCHAR(100) NOT NULL,
    Fee        INT          NOT NULL,
    PRIMARY KEY (VisitID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (DoctorID)  REFERENCES Doctor(DoctorID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ── INSERT Data (3NF) — order: parent tables first ────────────
INSERT INTO Patient VALUES
('P-201', 'Hassan',  '0300-1112233'),
('P-202', 'Mehreen', '0301-4445566'),
('P-203', 'Junaid',  '0302-7778899');

INSERT INTO Department VALUES
('Heart Care',  'Dr. Tariq'),
('Skin Clinic', 'Dr. Asma');

INSERT INTO Doctor VALUES
('D-30', 'Dr. Imran', 'Cardiology',  'Heart Care'),
('D-31', 'Dr. Asma',  'Dermatology', 'Skin Clinic');

INSERT INTO Visit VALUES
('V-9001', '2026-04-10', 'P-201', 'D-30', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'D-31', 'Eczema',       2000),
('V-9003', '2026-04-11', 'P-201', 'D-31', 'Allergy',      2000),
('V-9004', '2026-04-12', 'P-203', 'D-30', 'Arrhythmia',   3000);

-- ── Verify all 4 tables ───────────────────────────────────────
SELECT * FROM Patient;
SELECT * FROM Department;
SELECT * FROM Doctor;
SELECT * FROM Visit;

-- ── Reconstruct original Table 8.1 from 4 joined 3NF tables ──
SELECT
    v.VisitID,
    v.VisitDate,
    p.PatientID,
    p.PatientName,
    p.PatientPhone,
    d.DoctorID,
    d.DoctorName,
    d.Specialty,
    d.DeptName,
    dept.DeptHead,
    v.Diagnosis,
    v.Fee
FROM        Visit      v
JOIN        Patient    p    ON v.PatientID = p.PatientID
JOIN        Doctor     d    ON v.DoctorID  = d.DoctorID
JOIN        Department dept ON d.DeptName  = dept.DeptName
ORDER BY    v.VisitDate;

-- ── Anomaly fix demonstrations ────────────────────────────────

-- 1. INSERTION: Add new department without any doctor (impossible before 3NF)
INSERT INTO Department VALUES ('Neurology', 'Dr. Khalid');

-- 2. UPDATE: Change department head in ONE place only
UPDATE Department SET DeptHead = 'Dr. Saeed' WHERE DeptName = 'Heart Care';
-- In 1NF/2NF this would require updating every row containing Heart Care

-- 3. DELETION: Delete a visit without losing doctor/patient info
DELETE FROM Visit WHERE VisitID = 'V-9002';
-- Dr. Asma and Skin Clinic info still intact in Doctor and Department tables

-- ── Final schema check ────────────────────────────────────────
SHOW TABLES;
DESCRIBE Patient;
DESCRIBE Department;
DESCRIBE Doctor;
DESCRIBE Visit;

-- ============================================================
-- END OF FILE
-- Functional Dependencies Summary:
--   PatientID  → PatientName, PatientPhone
--   DeptName   → DeptHead
--   DoctorID   → DoctorName, Specialty, DeptName(FK)
--   VisitID    → VisitDate, PatientID(FK), DoctorID(FK), Diagnosis, Fee
--
-- Final Schema (3NF):
--   Patient(PatientID, PatientName, PatientPhone)
--   Department(DeptName, DeptHead)
--   Doctor(DoctorID, DoctorName, Specialty, DeptName→Dept)
--   Visit(VisitID, VisitDate, PatientID→Pat, DoctorID→Doc, Diagnosis, Fee)
--
-- Relationships:
--   Patient  ←  Visit  →  Doctor  →  Department
-- ============================================================
