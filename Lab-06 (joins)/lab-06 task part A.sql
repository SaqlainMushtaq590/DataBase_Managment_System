-- Part A Solutions

-- A1: List every employee with their department name and location. (INNER JOIN)
SELECT e.EmpID, e.EmpName, d.DeptName, d.Location
FROM Employee e
INNER JOIN Department d ON e.DeptID = d.DeptID;

-- A2: Same as A1, but include employees whose DeptID is NULL — if any. (LEFT JOIN)
SELECT e.EmpID, e.EmpName, d.DeptName, d.Location
FROM Employee e
LEFT JOIN Department d ON e.DeptID = d.DeptID;

-- A3: List every department with the names of its employees. Departments with no employees should still appear once with NULL EmpName.
SELECT d.DeptID, d.DeptName, e.EmpName
FROM Department d
LEFT JOIN Employee e ON d.DeptID = e.DeptID
ORDER BY d.DeptID;

-- A4: List every project with its department name and location. Include projects that have no department.
SELECT p.ProjectID, p.ProjectName, d.DeptName, d.Location
FROM Project p
LEFT JOIN Department d ON p.DeptID = d.DeptID;

-- A5: Find employees who are not assigned to any project. (LEFT JOIN + IS NULL pattern)
SELECT e.EmpID, e.EmpName
FROM Employee e
LEFT JOIN Assignment a ON e.EmpID = a.EmpID
WHERE a.EmpID IS NULL;

-- A6: List every project that currently has no assignments.
SELECT p.ProjectID, p.ProjectName
FROM Project p
LEFT JOIN Assignment a ON p.ProjectID = a.ProjectID
WHERE a.ProjectID IS NULL;

-- A7: Show every employee in the Engineering department along with their salary, sorted by salary descending. (INNER JOIN + WHERE)
SELECT e.EmpID, e.EmpName, e.Salary, d.DeptName
FROM Employee e
INNER JOIN Department d ON e.DeptID = d.DeptID
WHERE d.DeptName = 'Engineering'
ORDER BY e.Salary DESC;

-- A8: List employees in Lahore-based departments. Show EmpName and DeptName.
SELECT e.EmpName, d.DeptName, d.Location
FROM Employee e
INNER JOIN Department d ON e.DeptID = d.DeptID
WHERE d.Location = 'Lahore';

-- A9: List every department and the count of how many employees work there (use LEFT JOIN with COUNT and GROUP BY). Include departments with zero employees.
SELECT d.DeptID, d.DeptName, COUNT(e.EmpID) AS EmployeeCount
FROM Department d
LEFT JOIN Employee e ON d.DeptID = e.DeptID
GROUP BY d.DeptID, d.DeptName
ORDER BY d.DeptID;

-- A10: Produce a FULL OUTER JOIN result of Employee and Department using UNION.
SELECT e.EmpID, e.EmpName, d.DeptID, d.DeptName
FROM Employee e
LEFT JOIN Department d ON e.DeptID = d.DeptID
UNION
SELECT e.EmpID, e.EmpName, d.DeptID, d.DeptName
FROM Employee e
RIGHT JOIN Department d ON e.DeptID = d.DeptID;