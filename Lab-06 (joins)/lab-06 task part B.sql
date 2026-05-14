-- Part B Solutions

-- B1: For each employee, show their name and their manager's name. Top-level managers should still appear with NULL Manager. (SELF JOIN)
SELECT e.EmpName AS Employee, m.EmpName AS Manager
FROM Employee e
LEFT JOIN Employee m ON e.ManagerID = m.EmpID;

-- B2: List employees who earn more than their direct manager. Show employee name, employee salary, manager name, manager salary.
SELECT e.EmpName AS Employee, e.Salary AS EmpSalary,
       m.EmpName AS Manager, m.Salary AS ManagerSalary
FROM Employee e
INNER JOIN Employee m ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;

-- B3: List employees whose manager works in a different department. Show EmpName, ManagerName, and both department names.
SELECT e.EmpName AS Employee, 
       m.EmpName AS Manager,
       ed.DeptName AS EmpDepartment,
       md.DeptName AS ManagerDepartment
FROM Employee e
INNER JOIN Employee m ON e.ManagerID = m.EmpID
INNER JOIN Department ed ON e.DeptID = ed.DeptID
INNER JOIN Department md ON m.DeptID = md.DeptID
WHERE e.DeptID != m.DeptID;

-- B4: Show every employee with the project name they work on and weekly hours. (3-table join: Employee → Assignment → Project)
SELECT e.EmpName, p.ProjectName, a.HoursPerWeek
FROM Employee e
INNER JOIN Assignment a ON e.EmpID = a.EmpID
INNER JOIN Project p ON a.ProjectID = p.ProjectID
ORDER BY e.EmpName;

-- B5: List every assignment with employee name, project name, and the project's department name. (4-table join)
SELECT e.EmpName, p.ProjectName, d.DeptName, a.HoursPerWeek
FROM Assignment a
INNER JOIN Employee e ON a.EmpID = e.EmpID
INNER JOIN Project p ON a.ProjectID = p.ProjectID
INNER JOIN Department d ON p.DeptID = d.DeptID
ORDER BY e.EmpName;

-- B6: List the names and weekly hours of employees working on the Mobile App project.
SELECT e.EmpName, a.HoursPerWeek, p.ProjectName
FROM Employee e
INNER JOIN Assignment a ON e.EmpID = a.EmpID
INNER JOIN Project p ON a.ProjectID = p.ProjectID
WHERE p.ProjectName = 'Mobile App';

-- B7: List every employee in Lahore together with the projects they are assigned to (project name and hours). Include Lahore employees with no assignments.
SELECT e.EmpName, e.City, p.ProjectName, a.HoursPerWeek
FROM Employee e
LEFT JOIN Assignment a ON e.EmpID = a.EmpID
LEFT JOIN Project p ON a.ProjectID = p.ProjectID
WHERE e.City = 'Lahore'
ORDER BY e.EmpName;

-- B8: List the names of employees who work on a project run by a department different from their own. (Compare e.DeptID and p.DeptID.)
SELECT DISTINCT e.EmpName, 
       ed.DeptName AS EmpDepartment,
       pd.DeptName AS ProjectDepartment,
       p.ProjectName
FROM Employee e
INNER JOIN Assignment a ON e.EmpID = a.EmpID
INNER JOIN Project p ON a.ProjectID = p.ProjectID
INNER JOIN Department ed ON e.DeptID = ed.DeptID
INNER JOIN Department pd ON p.DeptID = pd.DeptID
WHERE e.DeptID != p.DeptID;

-- B9: For each department, list the names of projects that started in 2024. Include departments that have no such projects. (LEFT JOIN + WHERE on date)
SELECT d.DeptName, p.ProjectName, p.StartDate
FROM Department d
LEFT JOIN Project p ON d.DeptID = p.DeptID AND YEAR(p.StartDate) = 2024
ORDER BY d.DeptName;

-- B10: List every employee with the total hours they work per week across all their projects. Include employees with zero hours. (LEFT JOIN + SUM + GROUP BY)
SELECT e.EmpID, e.EmpName, COALESCE(SUM(a.HoursPerWeek), 0) AS TotalHoursPerWeek
FROM Employee e
LEFT JOIN Assignment a ON e.EmpID = a.EmpID
GROUP BY e.EmpID, e.EmpName
ORDER BY TotalHoursPerWeek DESC;