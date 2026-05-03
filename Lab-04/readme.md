<div align="center">

<!-- Banner -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=0D1B2A,1B4F8A,148F77&height=200&section=header&text=Database%20Normalization&fontSize=42&fontColor=ffffff&fontAlignY=38&desc=UNF%20→%201NF%20→%202NF%20→%203NF%20%7C%20Hospital%20Patient%20Visits&descAlignY=58&descColor=a8d8ea&animation=fadeIn" width="100%"/>

<!-- Badges -->
<p>
  <img src="https://img.shields.io/badge/Course-Database%20Systems-1B4F8A?style=for-the-badge&logo=databricks&logoColor=white"/>
  <img src="https://img.shields.io/badge/Tool-MySQL%208.x%20%2F%20XAMPP-F39C12?style=for-the-badge&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/Normal%20Forms-1NF%20%7C%202NF%20%7C%203NF-148F77?style=for-the-badge&logo=buffer&logoColor=white"/>
  <img src="https://img.shields.io/badge/Status-Complete%20✓-27AE60?style=for-the-badge&logo=checkmarx&logoColor=white"/>
</p>

<p>
  <img src="https://img.shields.io/badge/Tables-UNF%3A%201%20→%203NF%3A%204-8E44AD?style=flat-square"/>
  <img src="https://img.shields.io/badge/Anomalies%20Fixed-3%20of%203-27AE60?style=flat-square"/>
  <img src="https://img.shields.io/badge/Reports-3%20PDFs-C0392B?style=flat-square"/>
  <img src="https://img.shields.io/badge/SQL%20Scripts-3%20Files-F39C12?style=flat-square"/>
</p>

</div>

---

## 📋 Table of Contents

- [📖 About This Lab](#-about-this-lab)
- [🗂️ Repository Structure](#️-repository-structure)
- [🏥 Dataset — Hospital Patient Visits](#-dataset--hospital-patient-visits)
- [⚠️ The Problem — Anomalies in UNF](#️-the-problem--anomalies-in-unf)
- [🔗 Functional Dependencies](#-functional-dependencies)
- [🔵 1NF — First Normal Form](#-1nf--first-normal-form)
- [🟢 2NF — Second Normal Form](#-2nf--second-normal-form)
- [🟣 3NF — Third Normal Form](#-3nf--third-normal-form)
- [📊 Final Schema Diagram](#-final-schema-diagram)
- [🚀 How to Run](#-how-to-run)
- [📁 File Descriptions](#-file-descriptions)
- [📚 Key Concepts Cheat Sheet](#-key-concepts-cheat-sheet)

---

## 📖 About This Lab

This repository contains the complete solution for **Assessment Problem — Task 8** from the Database Systems Lab Manual on **Database Normalization**.

> **Goal:** Take a single flat unnormalized table of hospital visit records and progressively decompose it through **1NF → 2NF → 3NF**, eliminating all data redundancy, partial dependencies, and transitive dependencies along the way.

| Property | Value |
|----------|-------|
| **Course** | Database Systems |
| **Topic** | Normalization (1NF, 2NF, 3NF) |
| **Dataset** | Hospital Patient Visits (Task 8) |
| **Tool** | MySQL 8.x via XAMPP / phpMyAdmin |
| **Starting Point** | 1 flat table · 12 columns · 4 rows |
| **End Result** | 4 normalized tables · Zero anomalies |

---

## 🗂️ Repository Structure

```
Lab-Normalization/
│
├── 📄 README.md                          ← You are here
│
├── 📂 Reports/
│   ├── 📕 1NF_Report.pdf                 ← UNF → 1NF transformation report
│   ├── 📗 2NF_Report.pdf                 ← 1NF → 2NF transformation report
│   ├── 📘 3NF_Report.pdf                 ← 2NF → 3NF transformation report
│   └── 📓 Normalization_Summary.pdf      ← Complete summary (all 3 NFs)
│
└── 📂 SQL/
    ├── 🔵 1NF_hospital.sql               ← 1NF schema + data
    ├── 🟢 2NF_hospital.sql               ← 2NF schema + data + JOINs
    └── 🟣 hospital_normalization.sql     ← Complete UNF→1NF→2NF→3NF script
```

---

## 🏥 Dataset — Hospital Patient Visits

The hospital stores all consultation data in a **single flat table**. Each row represents one patient visit.

### Raw Unnormalized Data (UNF)

| VisitID | VisitDate | PatientID | PatientName | PatientPhone | DoctorID | DoctorName | Specialty | DeptName | DeptHead | Diagnosis | Fee |
|---------|-----------|-----------|-------------|--------------|----------|------------|-----------|----------|----------|-----------|-----|
| V-9001 | 2026-04-10 | P-201 | Hassan | 0300-1112233 | D-30 | Dr. Imran | Cardiology | Heart Care | Dr. Tariq | Hypertension | 2500 |
| V-9002 | 2026-04-10 | P-202 | Mehreen | 0301-4445566 | D-31 | Dr. Asma | Dermatology | Skin Clinic | Dr. Asma | Eczema | 2000 |
| V-9003 | 2026-04-11 | P-201 | **Hassan** | **0300-1112233** | D-31 | **Dr. Asma** | **Dermatology** | **Skin Clinic** | **Dr. Asma** | Allergy | 2000 |
| V-9004 | 2026-04-12 | P-203 | Junaid | 0302-7778899 | D-30 | **Dr. Imran** | **Cardiology** | **Heart Care** | **Dr. Tariq** | Arrhythmia | 3000 |

> **Bold** = Redundant/repeated data — the core problem this lab solves.

---

## ⚠️ The Problem — Anomalies in UNF

Three types of anomalies exist in the unnormalized table:

### 🔴 Insertion Anomaly
> **Cannot record new information without unrelated data.**

If a new doctor `Dr. Zara (Neurology)` joins the hospital, her information **cannot be stored** until she has at least one patient visit. The doctor's existence is tied to a visit row.

### 🟡 Update Anomaly
> **A single real-world change requires updating multiple rows.**

If `Dr. Imran` moves to a new office, **every row** containing `D-30` must be updated individually. Miss one row → data becomes inconsistent.

### 🔵 Deletion Anomaly
> **Deleting one fact accidentally destroys another.**

If `Mehreen (V-9002)` cancels her visit and we delete that row, we **permanently lose all information** about `Dr. Asma` and the `Skin Clinic` department — if no other visits reference her.

---

## 🔗 Functional Dependencies

Identified before normalization begins:

```
VisitID    →  VisitDate, PatientID, DoctorID, Diagnosis, Fee
PatientID  →  PatientName, PatientPhone
DoctorID   →  DoctorName, Specialty, DeptName, DeptHead
DeptName   →  DeptHead                         ← transitive dependency (3NF issue)
```

---

## 🔵 1NF — First Normal Form

### Rule
> Every cell must hold **one atomic value**. No repeating groups. A **Primary Key** must be declared.

### What Changed from UNF → 1NF

| Aspect | UNF | 1NF |
|--------|-----|-----|
| Primary Key | ❌ Not defined | ✅ `VisitID` declared as PK |
| Atomic Values | ❌ Not guaranteed | ✅ All cells hold single values |
| Repeating Groups | ❌ Possible | ✅ None |
| Tables | 1 | 1 |
| Redundancy | ❌ Present | ❌ Still present |

### 1NF Schema

```sql
CREATE TABLE HospitalVisit_1NF (
    VisitID      VARCHAR(10)  NOT NULL,   -- PRIMARY KEY
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
```

> **Still broken!** Hassan's data repeats for V-9001 and V-9003. Dr. Imran's data repeats for V-9001 and V-9004. These **partial dependencies** are fixed in 2NF.

---

## 🟢 2NF — Second Normal Form

### Rule
> Table is in 1NF **AND** every non-prime attribute depends on the **whole** primary key. No partial dependencies allowed.

### Partial Dependencies Identified

| Attribute | Actually Depends On | Type | Action |
|-----------|--------------------|----|--------|
| PatientName, PatientPhone | `PatientID` (not VisitID) | ❌ Partial | → Extract to `Patient` table |
| DoctorName, Specialty, DeptName, DeptHead | `DoctorID` (not VisitID) | ❌ Partial | → Extract to `Doctor` table |
| VisitDate, Diagnosis, Fee | `VisitID` ✓ | ✅ Full | Stay in `Visit` table |

### What Changed from 1NF → 2NF

| Aspect | 1NF | 2NF |
|--------|-----|-----|
| Tables | 1 | **3** |
| Partial Dependencies | ❌ Present | ✅ Eliminated |
| Foreign Keys | ❌ None | ✅ Visit→Patient, Visit→Doctor |
| Patient Redundancy | ❌ Hassan repeats | ✅ Stored once |
| Doctor Redundancy | ❌ Dr. Imran repeats | ✅ Stored once |
| Transitive Dependency | ❌ DeptName→DeptHead | ❌ Still present (3NF fixes) |

### 2NF Schema — 3 Tables

```sql
-- Table 1: Patient
CREATE TABLE Patient (
    PatientID    VARCHAR(10) NOT NULL,
    PatientName  VARCHAR(50) NOT NULL,
    PatientPhone VARCHAR(20) NOT NULL,
    PRIMARY KEY  (PatientID)
);

-- Table 2: Doctor (DeptHead still has transitive dep → fixed in 3NF)
CREATE TABLE Doctor (
    DoctorID   VARCHAR(10) NOT NULL,
    DoctorName VARCHAR(50) NOT NULL,
    Specialty  VARCHAR(50) NOT NULL,
    DeptName   VARCHAR(50) NOT NULL,
    DeptHead   VARCHAR(50) NOT NULL,  -- ⚠ transitive dep
    PRIMARY KEY (DoctorID)
);

-- Table 3: Visit
CREATE TABLE Visit (
    VisitID    VARCHAR(10)  NOT NULL,
    VisitDate  DATE         NOT NULL,
    PatientID  VARCHAR(10)  NOT NULL,
    DoctorID   VARCHAR(10)  NOT NULL,
    Diagnosis  VARCHAR(100) NOT NULL,
    Fee        INT          NOT NULL,
    PRIMARY KEY (VisitID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID)  REFERENCES Doctor(DoctorID)   ON UPDATE CASCADE
);
```

---

## 🟣 3NF — Third Normal Form

### Rule
> Table is in 2NF **AND** no non-prime attribute is transitively dependent on the primary key.
> *"Every non-key attribute must depend on the key, the whole key, and nothing but the key."*

### Transitive Dependency Identified

```
DoctorID  →  DeptName  →  DeptHead
   (PK)        (non-key)    (non-key)
```

`DeptHead` does **not** directly depend on `DoctorID` — it depends on `DeptName`, which itself depends on `DoctorID`. This indirect chain is a **transitive dependency** and violates 3NF.

### What Changed from 2NF → 3NF

| Aspect | 2NF | 3NF |
|--------|-----|-----|
| Tables | 3 | **4** |
| Transitive Dependencies | ❌ DeptName→DeptHead | ✅ Eliminated |
| New Table | — | ✅ `Department` created |
| Doctor Table | Has DeptHead column | DeptHead removed, DeptName = FK |
| Insertion Anomaly | ❌ Partial fix | ✅ **Fully eliminated** |
| Update Anomaly | ❌ Partial fix | ✅ **Fully eliminated** |
| Deletion Anomaly | ❌ Partial fix | ✅ **Fully eliminated** |

### 3NF Schema — 4 Tables (Final)

```sql
-- Table 1: Patient (unchanged from 2NF)
CREATE TABLE Patient (
    PatientID    VARCHAR(10) NOT NULL,
    PatientName  VARCHAR(50) NOT NULL,
    PatientPhone VARCHAR(20) NOT NULL,
    PRIMARY KEY  (PatientID)
);

-- Table 2: Department (NEW — extracted from Doctor)
CREATE TABLE Department (
    DeptName VARCHAR(50) NOT NULL,
    DeptHead VARCHAR(50) NOT NULL,
    PRIMARY KEY (DeptName)
);

-- Table 3: Doctor (updated — DeptHead removed, DeptName = FK)
CREATE TABLE Doctor (
    DoctorID   VARCHAR(10) NOT NULL,
    DoctorName VARCHAR(50) NOT NULL,
    Specialty  VARCHAR(50) NOT NULL,
    DeptName   VARCHAR(50) NOT NULL,
    PRIMARY KEY (DoctorID),
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName) ON UPDATE CASCADE
);

-- Table 4: Visit (unchanged from 2NF)
CREATE TABLE Visit (
    VisitID    VARCHAR(10)  NOT NULL,
    VisitDate  DATE         NOT NULL,
    PatientID  VARCHAR(10)  NOT NULL,
    DoctorID   VARCHAR(10)  NOT NULL,
    Diagnosis  VARCHAR(100) NOT NULL,
    Fee        INT          NOT NULL,
    PRIMARY KEY (VisitID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)     ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID)  REFERENCES Doctor(DoctorID)       ON UPDATE CASCADE
);
```

### Reconstructing the Original Report (JOIN Query)

```sql
SELECT
    v.VisitID,    v.VisitDate,
    p.PatientID,  p.PatientName,  p.PatientPhone,
    d.DoctorID,   d.DoctorName,   d.Specialty,
    d.DeptName,   dept.DeptHead,
    v.Diagnosis,  v.Fee
FROM        Visit      v
JOIN        Patient    p    ON v.PatientID = p.PatientID
JOIN        Doctor     d    ON v.DoctorID  = d.DoctorID
JOIN        Department dept ON d.DeptName  = dept.DeptName
ORDER BY    v.VisitDate;
```

---

## 📊 Final Schema Diagram

```
┌─────────────────────┐         ┌──────────────────────────────────────┐
│       Patient       │         │                Visit                 │
├─────────────────────┤         ├──────────────────────────────────────┤
│ 🔑 PatientID  (PK)  │◄────────│ 🔑 VisitID     (PK)                 │
│    PatientName      │         │    VisitDate                         │
│    PatientPhone     │         │ 🔗 PatientID   (FK → Patient)       │
└─────────────────────┘         │ 🔗 DoctorID    (FK → Doctor)        │
                                 │    Diagnosis                        │
                                 │    Fee                              │
                                 └──────────────────┬───────────────────┘
                                                    │
                                                    ▼
                                 ┌──────────────────────────────────────┐
                                 │               Doctor                 │
                                 ├──────────────────────────────────────┤
                                 │ 🔑 DoctorID    (PK)                  │
                                 │    DoctorName                         │
                                 │    Specialty                          │
                                 │ 🔗 DeptName    (FK → Department)     │
                                 └──────────────────┬───────────────────┘
                                                    │
                                                    ▼
                                 ┌──────────────────────────────────────┐
                                 │             Department                │
                                 ├──────────────────────────────────────┤
                                 │ 🔑 DeptName    (PK)                  │
                                 │    DeptHead                           │
                                 └──────────────────────────────────────┘

Relationship Chain:  Patient ←── Visit ──→ Doctor ──→ Department
```

---

## 🚀 How to Run

### Prerequisites
- [XAMPP](https://www.apachefriends.org/) installed (Apache + MySQL)
- A web browser for phpMyAdmin

### Step-by-Step

**1. Start XAMPP**
```
Open XAMPP Control Panel → Start Apache + MySQL
```

**2. Open phpMyAdmin**
```
http://localhost/phpmyadmin
```

**3. Run the SQL**

> Option A — Run the complete all-in-one script:
```
phpMyAdmin → SQL tab → paste hospital_normalization.sql → Go
```

> Option B — Run individual NF scripts in order:
```
1. 1NF_hospital.sql
2. 2NF_hospital.sql
3. hospital_normalization.sql   ← or run this alone for full 1NF→2NF→3NF
```

**4. Verify the output**
```sql
USE hospital_normalization;
SHOW TABLES;

-- Should return:
-- Patient
-- Department
-- Doctor
-- Visit
```

**5. Test the JOIN query**
```sql
SELECT v.VisitID, p.PatientName, d.DoctorName, dept.DeptHead, v.Diagnosis, v.Fee
FROM   Visit v
JOIN   Patient    p    ON v.PatientID = p.PatientID
JOIN   Doctor     d    ON v.DoctorID  = d.DoctorID
JOIN   Department dept ON d.DeptName  = dept.DeptName;
```

---

## 📁 File Descriptions

| File | Type | Description |
|------|------|-------------|
| `1NF_Report.pdf` | 📕 Report | Covers UNF → 1NF: anomalies identified, transformation steps, before/after tables, MySQL implementation, compliance checklist. **Blue theme.** |
| `2NF_Report.pdf` | 📗 Report | Covers 1NF → 2NF: partial dependency analysis, decomposition into 3 tables (Patient, Doctor, Visit), side-by-side comparison, verification queries. **Green theme.** |
| `3NF_Report.pdf` | 📘 Report | Covers 2NF → 3NF: transitive dependency chain explained, Department table extracted, 4-table final schema, JOIN query, full anomaly checklist. **Purple theme.** |
| `Normalization_Summary.pdf` | 📓 Summary | Master overview of all three normal forms: UNF data, all FDs, step-by-step transformations, master comparison table, entity relationship diagram, SQL quick reference. |
| `1NF_hospital.sql` | 🔵 SQL | Creates `hospital_normalization` database, `HospitalVisit_1NF` table, inserts all 4 rows, verification SELECT. |
| `2NF_hospital.sql` | 🟢 SQL | Creates 2NF tables (Patient, Doctor, Visit) with foreign keys, inserts data, JOIN query to rebuild original report. |
| `hospital_normalization.sql` | 🟣 SQL | **Complete script** — UNF → 1NF → 2NF → 3NF all in one file with section comments, all INSERTs, anomaly fix demos, and final SHOW/DESCRIBE commands. |

---

## 📚 Key Concepts Cheat Sheet

| Term | Definition |
|------|------------|
| **Normalization** | Process of organizing a database to reduce redundancy and improve integrity |
| **Functional Dependency (X→Y)** | Knowing X uniquely determines Y |
| **Partial Dependency** | Non-key attribute depends on *part* of a composite key |
| **Transitive Dependency** | A→B→C: non-key depends on another non-key attribute |
| **Primary Key (PK)** | Column(s) that uniquely identify each row |
| **Foreign Key (FK)** | Column that references the PK of another table |
| **1NF** | Atomic values + no repeating groups + PK defined |
| **2NF** | 1NF + no partial dependencies |
| **3NF** | 2NF + no transitive dependencies |
| **Insertion Anomaly** | Cannot add data without unrelated data being present |
| **Update Anomaly** | One fact change requires updating many rows |
| **Deletion Anomaly** | Deleting one row accidentally removes unrelated facts |

---

### Quick Normal Form Progression

```
UNF  →  1NF  →  2NF  →  3NF
 1        1       3       4    ← number of tables
 ✗        ✓       ✓       ✓    ← primary key
 ✗        ✓       ✓       ✓    ← atomic values
 ✗        ✗       ✓       ✓    ← partial deps removed
 ✗        ✗       ✗       ✓    ← transitive deps removed
 ✗        ✗       ✗       ✓    ← all anomalies eliminated
```

---

<div align="center">

**Database Systems Lab — Normalization Series**

*From a single flat table to a clean, anomaly-free 3NF schema.*

`Patient` ← `Visit` → `Doctor` → `Department`

</div>
