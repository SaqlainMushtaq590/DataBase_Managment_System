-- A1
SELECT  EmpID, EmpName, Salary
FROM empolyee
WHERE Salary > 90000;


-- A2
SELECT EmpName, Salary FROM employee 
WHERE Salary <= 75000;

-- A3
SELECT EmpID, EmpName, Salary, City FROM employee
WHERE salary > 90000 AND City = 'Lahore';

-- A4
SELECT EmpName , City FROM employee
WHERE City = 'Karachi' OR City = 'Islamabad' ;

-- A5
SELECT EmpID, EmpName, DeptName FROM employee
WHERE Gender = 'F' AND DeptName != 'Engineering';

--A6
SELECT EmpID, EmpName, DeptName , Salary FROM employee
WHERE (Gender = 'm' AND Salary >= 70000 ) OR Salary <= 90000;

--A7
SELECT EmpName, JobTitle, Salary FROM employee
WHERE (JobTitle = 'Software Engineer') OR Salary > 100000;

-- A8
SELECT EmpName, JobTitle FROM employee
WHERE JobTitle != 'Markiting' AND JobTitle != 'Sales' ;
