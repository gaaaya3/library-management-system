CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(6, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO Branch VALUES
(1, 101, '123 Main St, City A', '555-0101'),
(2, 102, '456 Oak Ave, City B', '555-0202'),
(3, 103, '789 Pine Rd, City C', '555-0303');

INSERT INTO Employee VALUES
(101, 'John Smith', 'Manager', 75000.00, 1),
(102, 'Jane Doe', 'Manager', 72000.00, 2),
(103, 'Bob Johnson', 'Manager', 70000.00, 3),
(201, 'Alice Brown', 'Librarian', 55000.00, 1),
(202, 'Charlie Davis', 'Librarian', 52000.00, 2),
(203, 'Eva Martinez', 'Assistant', 45000.00, 3),
(204, 'David Wilson', 'Assistant', 42000.00, 1);

INSERT INTO Books VALUES
('ISBN001', 'To Kill a Mockingbird', 'Fiction', 15.00, 'yes', 'Harper Lee', 'HarperCollins'),
('ISBN002', '1984', 'Fiction', 12.50, 'yes', 'George Orwell', 'Penguin Books'),
('ISBN003', 'A Brief History of Time', 'Science', 20.00, 'yes', 'Stephen Hawking', 'Bantam Books'),
('ISBN004', 'Pride and Prejudice', 'Fiction', 10.00, 'no', 'Jane Austen', 'Penguin Classics'),
('ISBN005', 'The History of Ancient Egypt', 'History', 25.00, 'yes', 'Toby Wilkinson', 'Thames & Hudson');

INSERT INTO Customer VALUES
(1, 'Mike Johnson', '10 Elm St, City A', '2021-05-15'),
(2, 'Sarah Lee', '20 Maple Ave, City B', '2022-02-10'),
(3, 'Tom Brown', '30 Oak Rd, City C', '2023-01-20'),
(4, 'Emily Clark', '40 Pine St, City A', '2021-11-30');

INSERT INTO IssueStatus VALUES
(1, 1, 'To Kill a Mockingbird', '2023-06-01', 'ISBN001'),
(2, 2, '1984', '2023-06-15', 'ISBN002'),
(3, 3, 'A Brief History of Time', '2023-07-01', 'ISBN003');

INSERT INTO ReturnStatus VALUES
(1, 1, 'To Kill a Mockingbird', '2023-06-15', 'ISBN001'),
(2, 2, '1984', '2023-06-30', 'ISBN002');

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT b.Book_title, c.Customer_name
FROM Books b
JOIN IssueStatus i ON b.ISBN = i.Isbn_book
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

SELECT Category, COUNT(*) as BookCount
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT DISTINCT Issued_cust FROM IssueStatus);

SELECT Branch_no, COUNT(*) as EmployeeCount
FROM Employee
GROUP BY Branch_no;

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE YEAR(i.Issue_date) = 2023 AND MONTH(i.Issue_date) = 6;

SELECT Book_title
FROM Books
WHERE Category = 'History' OR Book_title LIKE '%History%';

SELECT Branch_no, COUNT(*) as EmployeeCount
FROM Employee
GROUP BY Branch_no
HAVING EmployeeCount > 5;

SELECT e.Emp_name, b.Branch_address
FROM Employee e
JOIN Branch b ON e.Emp_Id = b.Manager_Id;

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
JOIN Books b ON i.Isbn_book = b.ISBN
WHERE b.Rental_Price > 25;