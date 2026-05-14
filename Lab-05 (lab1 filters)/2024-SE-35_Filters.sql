-- Assessment Problem Solutions

-- Q1: List all books with a price greater than 1500. Show Title and Price.
SELECT Title, Price
FROM Book
WHERE Price > 1500;

-- Q2: Find all books published between 1900 and 2000. Show Title and PublishedYear, sorted by year.
SELECT Title, PublishedYear
FROM Book
WHERE PublishedYear BETWEEN 1900 AND 2000
ORDER BY PublishedYear ASC;

-- Q3: List books in Fiction or Mystery genre with stock greater than 5.
SELECT Title, Genre, StockQty
FROM Book
WHERE Genre IN ('Fiction', 'Mystery') AND StockQty > 5;

-- Q4: Find books whose title contains the word 'the' anywhere (case-insensitive). Show Title and Author.
SELECT Title, Author
FROM Book
WHERE Title LIKE '%the%';

-- Q5: List books whose title starts with the letter 'A' or ends with 't'.
SELECT Title
FROM Book
WHERE Title LIKE 'A%' OR Title LIKE '%t';

-- Q6: Find books with no recorded author. Show Title.
SELECT Title
FROM Book
WHERE Author IS NULL;

-- Q7: List books that are out of stock (StockQty = 0) or have unknown publisher.
SELECT Title, StockQty, Publisher
FROM Book
WHERE StockQty = 0 OR Publisher IS NULL;

-- Q8: Show the 3 most expensive books in stock (StockQty > 0).
SELECT Title, Price, StockQty
FROM Book
WHERE StockQty > 0
ORDER BY Price DESC
LIMIT 3;

-- Q9: Display all books written in Urdu, sorted by published year ascending.
SELECT Title, Author, PublishedYear, Language
FROM Book
WHERE Language = 'Urdu'
ORDER BY PublishedYear ASC;

-- Q10: List books published before the year 2000 with a price under 1200, sorted by genre and then by title.
SELECT Title, Genre, Price, PublishedYear
FROM Book
WHERE PublishedYear < 2000 AND Price < 1200
ORDER BY Genre ASC, Title ASC;