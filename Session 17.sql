select * from books;
select * from loans;
select * from patrons;

#Find the number of available copies of Dracula
select count(*) AS available_copies
from Books
where Title ='Dracula';

#Check total copies of the books
SELECT COUNT(*) AS total_copies
FROM Books
group by title;

#Current total loans of the books
select title,count(*) as total_loans
from loans
join Books on loans.BookID=Books.BookID
group by title;

#Total available books
select count(*) as Total_available_books
 from books;
 
 #Add new books to the library
INSERT INTO Books (BookID, Title, Author, Published, Barcode)
VALUES
  (1000, 'abcde', 'abcde', '2023-01-01 00:00:00', 123456789),
  (1001, 'brugunr', 'dsaf', '1929-05-02 00:00:00', 5565553);
  
#Check books for Due back
SELECT *FROM loans
WHERE DueDate <= ReturnedDate;

#Generate a report of books due back on July 13, 2020, with patron contact information
SELECT books.Title, patrons.Email
FROM loans
JOIN books ON loans.bookid = books.bookid
JOIN patrons ON loans.patronid = patrons.patronid
WHERE duedate = '2020-07-13';

#Return books to the library WHERE Barcode = 6435968624
UPDATE loans
SET ReturnedDate = CURRENT_DATE
WHERE bookid = (SELECT bookid FROM books WHERE barcode = 6435968624);

#Generate a report showing 10 patrons who have checked out the fewest books
SELECT patrons.FirstName, COUNT(loans.bookid) AS books_checked_out
FROM loans
JOIN patrons ON loans.patronid = patrons.patronid
GROUP BY patrons.patronid
ORDER BY books_checked_out ASC
LIMIT 10;

#Find books to feature for an event, create a list of books from the 1890s that are currently available
SELECT title, author
FROM books
WHERE Year(Published) >= 1890 AND Year(Published) < 1900 ;

#Book Statistics - Create a report to show how many books were published each year
SELECT Year(Published) as publish_year, COUNT(*) AS books_published
FROM books
GROUP BY publish_year;

#Book Statistics - Create a report to show the 5 most popular books to check out
SELECT books.title, COUNT(loans.bookid) AS popularity
FROM loans
JOIN books ON loans.bookid = books.bookid
GROUP BY books.bookid
ORDER BY popularity DESC
LIMIT 5;