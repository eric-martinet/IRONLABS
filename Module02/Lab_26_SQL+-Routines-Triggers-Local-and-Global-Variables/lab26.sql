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



