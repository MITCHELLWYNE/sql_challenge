DROP TABLE "dept_name";
DROP TABLE "dept_mngr";
DROP TABLE "dept_emp";
DROP TABLE "employees";
DROP TABLE "titles";
DROP TABLE "salaries";

CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_mngr" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_dept_mngr" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" VARCHAR(10)   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" VARCHAR(10)   NOT NULL,
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "birth_date" DATE   NOT NULL,
	"first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
	"hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "emp_title_id"
     )
);

CREATE TABLE "salaries" (
    "emp_no" VARCHAR(10)   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * FROM dept_emp
SELECT * FROM dept_mngr
SELECT * FROM departments
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles

--DATA ANALYSIS
--#1 List employee number, last, first, sex, and salary
--merge employees with salaries on emp_no inner join

SELECT employees.emp_no, 
	last_name,
	first_name, 
	sex,
	salary
FROM employees
INNER JOIN salaries 
	ON employees.emp_no = salaries.emp_no;

--#2 List first, last, and hire_date for employees hired in 1986
--Query information from employees table 

SELECT first_name,
	last_name,
	hire_date
FROM employees	
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--#3 List the department managers, dept number, dept name, emp no, last, first
--merge dept_mngr, employees, and departments inner joins
SELECT departments.dept_no,
	dept_name,
	dept_mngr.emp_no
	emp_title_id,
	last_name,
	first_name 
FROM departments
INNER JOIN dept_mngr  
	ON departments.dept_no = dept_mngr.dept_no
INNER JOIN 	employees
	on dept_mngr.emp_no = employees.emp_no;
	
--#4 List department number, employee number, last, first, deptartment name
--merge departments department employees and employees inner join
Select departments.dept_no,
	dept_emp.emp_no,
	last_name, 
	first_name, 
	dept_name
FROM departments
INNER JOIN dept_emp
	ON departments.dept_no = dept_emp.dept_no
INNER JOIN employees
	ON dept_emp.emp_no = employees.emp_no;
	
--#5 List first, last, sex (Hercules)(B)
--Quesry information on employees who have the first name of Hercules and last name
--that starts with B
SELECT first_name,
	last_name, 
	sex
FROM employees
WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';
	
--#6 List each employee in the sales department, employee number, last and first
--merge departments, dept_emp, and employees inner join
SELECT departments.dept_no,
	dept_name,
	dept_emp.emp_no,
	last_name,
	first_name 
FROM departments
INNER JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE dept_name = 'Sales';

--#7 List each employee in the Sales and Dev departments, employee number,
--last, first and department name
--merge departments, dept_emp, and employees inner join
SELECT departments.dept_no,
	dept_name,
	dept_emp.emp_no,
	last_name,
	first_name 
FROM departments
INNER JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE dept_name = 'Sales'
	OR dept_name = 'Development'; 
	
--#8 Frequency counts in decending order for last names
SELECT last_name,  
COUNT (last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT DESC;