CREATE DATABASE library;
USE library;

CREATE TABLE Branch (
Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(100),
Contact_no VARCHAR(15)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(100),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10,2),
    Status VARCHAR(3),
    Author VARCHAR(50),
    Publisher VARCHAR(50)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Customer_address VARCHAR(100),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO Branch VALUES
(1,101,'Kochi','9876543210'),
(2,102,'Calicut','9876543211'),
(3,103,'Trivandrum','9876543212');

INSERT INTO Employee VALUES
(101,'Rahul','Manager',60000,1),
(102,'Anu','Manager',55000,2),
(103,'Vishnu','Manager',70000,3),
(104,'Akhil','Clerk',30000,1),
(105,'Nisha','Assistant',45000,2),
(106,'Arun','Assistant',52000,3);

INSERT INTO Books VALUES
('B101','History of India','History',30,'yes','R Sharma','ABC'),
('B102','SQL Basics','Education',20,'yes','John','XYZ'),
('B103','Physics Fundamentals','Science',25,'no','David','PQR'),
('B104','World History','History',35,'yes','Alex','ABC'),
('B105','Python Programming','Education',40,'yes','Mark','XYZ');

INSERT INTO Customer VALUES
(1,'Aisha','Malappuram','2021-05-10'),
(2,'Fathima','Kozhikode','2023-01-15'),
(3,'Rashid','Kochi','2020-11-20'),
(4,'Nafla','Thrissur','2022-08-12');

INSERT INTO IssueStatus VALUES
(1,1,'History of India','2023-06-10','B101'),
(2,2,'SQL Basics','2023-06-15','B102'),
(3,3,'World History','2023-07-01','B104');

INSERT INTO ReturnStatus VALUES
(1,1,'History of India','2023-06-20','B101'),
(2,2,'SQL Basics','2023-06-25','B102');

SHOW TABLES;

SELECT*FROM Branch;

SELECT*FROM Employee;

SELECT*FROM Books;

SELECT*FROM Customer;

SELECT*FROM IssueStatus;

SELECT* FROM ReturnStatus;

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name , Salary
FROM Employee
ORDER BY Salary DESC;

SELECT i.Issued_book_name, c.Customer_name
FROM IssueStatus i 
JOIN Customer c
ON i.Issued_cust = c.Customer_Id;

SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

SELECT Emp_name , Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date <'2022-01-01'
AND Customer_Id NOT IN
(
  SELECT Issued_cust
  FROM IssueStatus
);

SELECT Branch_no,COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no;

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i
ON c.Customer_Id = i.Issued_cust
WHERE MONTH (i.Issue_date)=6
AND YEAR (i.Issue_date)=2023;

SELECT Book_title 
FROM Books
WHERE Book_title LIKE '%History%';

SELECT Branch_no, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

SELECT e.Emp_name, b.Branch_address
FROM Employee e
JOIN Branch b
ON e.Emp_Id = b.Manager_Id;

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i
ON c.Customer_Id = i.Issued_cust
JOIN Books b
ON i.Isbn_book = b.ISBN
WHERE b.Rental_Price > 25;