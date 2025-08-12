# Library-Database-SQL-Task5
A collection of SQL tasks demonstrating database creation, data manipulation, filtering, grouping, and joins using a Library Management System schema.

# Task 5 - SQL Joins

## Objective
Demonstrate different types of SQL joins using the Library Database created in Task 1 and populated in Task 2–4.

## Tools Used
- MySQL Workbench

## Tables Involved
- **Members** — Stores member details.
- **Books** — Stores book details.
- **BorrowedBooks** — Stores borrowing records with references to Members and Books.

## Queries Performed
1. **INNER JOIN** — Retrieve members who have borrowed books, along with book titles and borrow dates.
2. **LEFT JOIN** — Retrieve all members, including those who have not borrowed any books.
3. **RIGHT JOIN** — Retrieve all borrowed books with member details (if available).
4. **FULL OUTER JOIN** (MySQL workaround using `UNION`) — Retrieve all members and all borrowed books, even if there is no match between them.

---

