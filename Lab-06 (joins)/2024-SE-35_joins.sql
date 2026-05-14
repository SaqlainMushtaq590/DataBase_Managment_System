-- Assessment Problem Solutions

-- Q1: Show every book with its author's name and country. (INNER JOIN)
SELECT b.BookID, b.Title, a.AuthorName, a.Country
FROM Book b
INNER JOIN Author a ON b.AuthorID = a.AuthorID;

-- Q2: Show every author with their books. Authors with no books must still appear once with NULL Title. (LEFT JOIN)
SELECT a.AuthorID, a.AuthorName, a.Country, b.Title
FROM Author a
LEFT JOIN Book b ON a.AuthorID = b.AuthorID
ORDER BY a.AuthorID;

-- Q3: List members who have never borrowed any book. (LEFT JOIN + IS NULL)
SELECT m.MemberID, m.MemberName, m.City
FROM Member m
LEFT JOIN Loan l ON m.MemberID = l.MemberID
WHERE l.MemberID IS NULL;

-- Q4: List every loan with the member's name, book title, and author's name. (3-table join)
SELECT l.LoanID, m.MemberName, b.Title, a.AuthorName, l.LoanDate, l.ReturnDate
FROM Loan l
INNER JOIN Member m ON l.MemberID = m.MemberID
INNER JOIN Book b ON l.BookID = b.BookID
INNER JOIN Author a ON b.AuthorID = a.AuthorID
ORDER BY l.LoanID;

-- Q5: List currently borrowed books (ReturnDate IS NULL) along with the borrower's name and city.
SELECT b.Title, m.MemberName, m.City, l.LoanDate
FROM Loan l
INNER JOIN Member m ON l.MemberID = m.MemberID
INNER JOIN Book b ON l.BookID = b.BookID
WHERE l.ReturnDate IS NULL;

-- Q6: List Pakistani authors and the titles of their books. Include Pakistani authors with no books. (LEFT JOIN + WHERE on author country)
SELECT a.AuthorID, a.AuthorName, a.Country, b.Title
FROM Author a
LEFT JOIN Book b ON a.AuthorID = b.AuthorID
WHERE a.Country = 'Pakistan'
ORDER BY a.AuthorID;

-- Q7: List every book together with the names of all members who have borrowed it. Include books that have never been borrowed. (LEFT JOIN chain)
SELECT b.BookID, b.Title, m.MemberName, l.LoanDate, l.ReturnDate
FROM Book b
LEFT JOIN Loan l ON b.BookID = l.BookID
LEFT JOIN Member m ON l.MemberID = m.MemberID
ORDER BY b.BookID;

-- Q8: Find authors whose books have never been borrowed. (Multi-step: Author → Book → Loan)
SELECT DISTINCT a.AuthorID, a.AuthorName, a.Country
FROM Author a
INNER JOIN Book b ON a.AuthorID = b.AuthorID
LEFT JOIN Loan l ON b.BookID = l.BookID
WHERE l.LoanID IS NULL;

-- Q9: Produce a FULL OUTER JOIN of Author and Book using UNION — every author and every book, matched where possible.
SELECT a.AuthorID, a.AuthorName, b.BookID, b.Title
FROM Author a
LEFT JOIN Book b ON a.AuthorID = b.AuthorID
UNION
SELECT a.AuthorID, a.AuthorName, b.BookID, b.Title
FROM Author a
RIGHT JOIN Book b ON a.AuthorID = b.AuthorID;

-- Q10: List members who have borrowed books written by Pakistani authors. Show member name, book title, and author name. (4-way join with filter)
SELECT DISTINCT m.MemberName, b.Title, a.AuthorName, a.Country
FROM Loan l
INNER JOIN Member m ON l.MemberID = m.MemberID
INNER JOIN Book b ON l.BookID = b.BookID
INNER JOIN Author a ON b.AuthorID = a.AuthorID
WHERE a.Country = 'Pakistan'
ORDER BY m.MemberName;