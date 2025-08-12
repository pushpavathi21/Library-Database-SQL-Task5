-- Disable foreign key checks temporarily
SET FOREIGN_KEY_CHECKS = 0;

-- Clear dependent tables first (order matters)
DELETE FROM librarydb.BorrowedBooks;
DELETE FROM librarydb.Books;
DELETE FROM librarydb.Members;

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

-- Insert Members data
INSERT INTO librarydb.Members (member_id, name, email, join_date, city) VALUES  
(1, 'Pushpa Rao', 'pushpa@example.com', '2024-08-12', 'Bangalore'),  
(2, 'Anil Kumar', 'anil@example.com', '2022-04-22', 'Mumbai'),  
(3, 'Raj Kumar', 'raj@example.com', '2021-01-02', 'Chennai'),  
(4, 'Priya Sharma', 'priya@example.com', '2025-08-12', 'Bangalore');

-- Insert Books data
INSERT INTO librarydb.Books (book_id, title, author, year_published, price) VALUES  
(1, 'Book One', 'Author A', 2018, 250),  
(2, 'Book Two', 'Author B', 2020, 400),  
(3, 'Book Three', 'Author C', 2016, 150);

-- Create BorrowedBooks table if it doesn't exist
CREATE TABLE IF NOT EXISTS librarydb.BorrowedBooks (
    borrow_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES librarydb.Members(member_id),
    FOREIGN KEY (book_id) REFERENCES librarydb.Books(book_id)
);

-- Insert BorrowedBooks data
INSERT INTO librarydb.BorrowedBooks (borrow_id, member_id, book_id, borrow_date, return_date) VALUES
(1, 1, 2, '2025-01-10', '2025-01-20'),
(2, 2, 1, '2025-02-01', '2025-02-10'),
(3, 3, 3, '2025-02-15', NULL),
(4, 4, 2, '2025-03-05', NULL);

-- ========================================
-- JOIN Queries
-- ========================================

-- 1. INNER JOIN: Members who borrowed books
SELECT m.name, b.title, bb.borrow_date
FROM librarydb.Members m
INNER JOIN librarydb.BorrowedBooks bb ON m.member_id = bb.member_id
INNER JOIN librarydb.Books b ON bb.book_id = b.book_id;

-- 2. LEFT JOIN: All members and their borrowed books (if any)
SELECT m.name, b.title, bb.borrow_date
FROM librarydb.Members m
LEFT JOIN librarydb.BorrowedBooks bb ON m.member_id = bb.member_id
LEFT JOIN librarydb.Books b ON bb.book_id = b.book_id;

-- 3. RIGHT JOIN: All borrowed books with member info
SELECT m.name, b.title, bb.borrow_date
FROM librarydb.Members m
RIGHT JOIN librarydb.BorrowedBooks bb ON m.member_id = bb.member_id
RIGHT JOIN librarydb.Books b ON bb.book_id = b.book_id;

-- 4. FULL OUTER JOIN (MySQL workaround using UNION)
SELECT m.name, b.title, bb.borrow_date
FROM librarydb.Members m
LEFT JOIN librarydb.BorrowedBooks bb ON m.member_id = bb.member_id
LEFT JOIN librarydb.Books b ON bb.book_id = b.book_id
UNION
SELECT m.name, b.title, bb.borrow_date
FROM librarydb.Members m
RIGHT JOIN librarydb.BorrowedBooks bb ON m.member_id = bb.member_id
RIGHT JOIN librarydb.Books b ON bb.book_id = b.book_id;
