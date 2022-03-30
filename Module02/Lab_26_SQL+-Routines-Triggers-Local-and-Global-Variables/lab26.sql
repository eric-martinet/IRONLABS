USE employees_mod;

# 2. Create a procedure that will provide the average salary of all employees.

DROP PROCEDURE IF EXISTS emps_avg_salary;
DELIMITER $$
CREATE PROCEDURE emps_avg_salary()
BEGIN
	SELECT AVG(salary)
	FROM t_salaries sal
	JOIN t_employees emp
	ON sal.emp_no = emp.emp_no
	;
END $$
DELIMITER ;

# 3. Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual
# and returns their employee number.


DROP PROCEDURE IF EXISTS emp_info;
DELIMITER $$
CREATE PROCEDURE emp_info(
	IN first_name VARCHAR(14), 
    IN last_name VARCHAR(16)
)
BEGIN
	SELECT emp.emp_no
	FROM t_employees emp
	WHERE emp.first_name = first_name AND emp.last_name = last_name
	;
END $$
DELIMITER ;

# 4. Call the procedures

CALL emps_avg_salary(); # Returns 59,363.13

CALL emp_info('Elvis', 'Demeyer'); # Returns 10030

# 5. Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee
# and returns the salary from the newest contract of that employee.
# Hint: In the BEGIN-END block of this program, you need to declare and use two variables
# v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.


DROP FUNCTION IF EXISTS emp_info;

DELIMITER $$
CREATE FUNCTION emp_info(
	first_name VARCHAR(14), 
    ast_name VARCHAR(16)
)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
	# Variables declaration
	DECLARE v_max_from_date DATE;
	DECLARE v_salary DECIMAL(10,2);
    # First we get and store the date of the newest contract into v_max_from_date.
	SELECT MAX(sal.from_date) INTO v_max_from_date FROM t_salaries sal
		JOIN t_employees emp ON sal.emp_no = emp.emp_no
    WHERE emp.first_name = first_name AND emp.last_name = last_name;
    # Then we can use v_max_from_date as a filter.
    SELECT sal.salary INTO v_salary FROM t_salaries sal
		JOIN t_employees emp ON sal.emp_no = emp.emp_no
	WHERE emp.first_name = first_name AND emp.last_name = last_name AND sal.from_date = v_max_from_date;
    # We can return the value.
    RETURN v_salary;
END $$
DELIMITER ;

#6. Create a trigger that checks if the hire date of an employee is higher than the current date.
# If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)

DROP TRIGGER IF EXISTS trig_correct_hire_date;

DELIMITER $$
CREATE TRIGGER trig_correct_hire_date
BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN 
	DECLARE today DATE;
    SET today = SYSDATE();
	IF NEW.hire_date > today THEN 
		SET NEW.hire_date = today; 
	END IF;
END $$
DELIMITER ;

select * from t_employees
WHERE emp_no < 10000;

INSERT INTO t_employees
VALUES (999, '1986-06-05','Eric','Martinet','M','2022-04-01');

DELETE FROM t_employees WHERE emp_no < 10000;

# 7. Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.
CREATE INDEX i_hire_date ON t_employees(hire_date);
ALTER TABLE t_employees DROP INDEX i_hire_date;

# 8. Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
# Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.

SELECT * FROM t_salaries
WHERE salary > 89000;
# BEFORE INDEXING: 0.051 sec / 0.00095 sec

CREATE INDEX i_salary ON t_salaries(salary);

SELECT * FROM t_salaries
WHERE salary > 89000;
# AFTER INDEXING: 0.0074 sec / 0.00091 sec
# Almost 8 times faster.

# 9. Use Case statement and obtain a result set containing the employee number, first name, and last name
# of all employees with a number higher than 109990.
# Create a fourth column in the query, indicating whether this employee is also a manager,
# according to the data provided in the dept_manager table, or a regular employee.

SELECT emp.emp_no, emp.first_name, emp.last_name,
CASE
	WHEN mgr.emp_no IS NOT NULL THEN 'Manager'
	ELSE 'Employee' 
END AS level
FROM t_employees emp
LEFT JOIN t_dept_manager mgr ON emp.emp_no = mgr.emp_no
WHERE emp.emp_no > 109990;

# 10. Extract a dataset containing the following information about the managers:
# employee number, first name, and last name.
# Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee
# and another one saying whether this salary raise was higher than $30,000 or NOT.

SELECT 	emp.emp_no,
		emp.first_name,
		emp.last_name,
        MAX(sal.salary) - MIN(sal.salary) AS salary_maxmin_diff,
        CASE
			WHEN MAX(sal.salary) - MIN(sal.salary) > 30000 THEN "Yes"
            ELSE 'No'
		END AS raised_above_30k
FROM t_employees emp
	JOIN t_dept_manager mgr ON emp.emp_no = mgr.emp_no
	JOIN t_salaries sal ON emp.emp_no = sal.emp_no
GROUP BY emp.emp_no;

# 11. Extract the employee number, first name, and last name of the first 100 employees,
# and add a fourth column, called “current_employee” saying “Is still employed” if the employee is still working in the company,
# or “Not an employee anymore” if they aren’t.
# Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise.

SELECT emp.emp_no, emp.first_name, emp.last_name,
	IF(MAX(dpt_emp.to_date) > SYSDATE(), 'Is still employed', 'Not an employee anymore') AS employee_status
FROM t_employees emp
	JOIN t_dept_emp dpt_emp ON emp.emp_no = dpt_emp.emp_no
GROUP BY dpt_emp.emp_no
LIMIT 100;
