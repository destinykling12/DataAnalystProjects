-- creating a fake employee table
CREATE TABLE employee (
EmployeeID int,
FirstName text,
LastName text,
Email text,
Phone text,
Address text
);

-- inserting fake employee data into the table
INSERT INTO test.employee (EmployeeID, FirstName, LastName, Email, Phone, Address)
VALUES
	(1, 'Sally', 'Johnson', 'sally123@gmail.com', '680-243-5678', '458 N Virginia St'),
    (2, 'John', 'Smith', 'jsmith@yahoo.com', '480-900-8732', '755 S Sierra St'),
    (3, 'Paul', 'Cox', 'paul36@gmail.com', '680-054-5321', '550 Germann St'),
    (4, 'Jannet', 'Scott', 'jscott@cox.net', '480-856-7734', '640 N Empire St'),
    (5, 'Dwight', 'Schrute', 'dschrute@hotmail.com', '775-889-0708', '985 Paper Way'),
    (6, 'Pam', 'Beasly', 'pam23@gmail.com', '775-843-2900', '966 Scranton St')
    ;
    
SELECT * FROM employee;

SELECT CONCAT(FirstName, ' ', LastName) AS Name
FROM employee;
