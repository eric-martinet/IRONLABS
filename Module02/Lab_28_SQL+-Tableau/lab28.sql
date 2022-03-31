#1. Create a visualization that provides a breakdown between the male and female employees working in the company each year,
# starting from 1990.

SELECT
	starts.calendar_year,
    starts.gender,
    COALESCE(nb_starts,0) AS nb_starts, # The COALESCE() function returns the first non-null value in a list.
    COALESCE(nb_ends,0) AS nb_ends,
    COALESCE(nb_starts - nb_ends, nb_starts, - nb_ends) AS var 
FROM
	# 'starts' temp table: hires and changes to new position
	(
    SELECT
		YEAR(de.from_date) AS calendar_year,
		COALESCE(e.gender, 'Unknown') AS gender,
		COUNT(*) AS nb_starts
	FROM t_dept_emp de
		LEFT JOIN t_employees e ON e.emp_no = de.emp_No # LEFT JOIN as some emp_no of t_dept_emp are not referenced in t_employees
	GROUP BY calendar_year, gender
	#HAVING calendar_year >= '1990'
    ) starts
LEFT JOIN
	# 'ends' temp table: terminations and changes from current position
    (
    SELECT
		YEAR(de.to_date) AS calendar_year,
        COALESCE(e.gender, 'Unknown') AS gender,
        COUNT(*) AS nb_ends
	FROM t_dept_emp de
		LEFT JOIN t_employees e ON e.emp_no = de.emp_No
	GROUP BY calendar_year, gender
	#HAVING calendar_year >= '1990'
    ) ends
ON starts.calendar_year = ends.calendar_year AND starts.gender = ends.gender
ORDER BY starts.calendar_year, starts.gender;

# This query shows the number of employees (former and current) by gender
SELECT COALESCE(e.gender, 'Unknown') AS gender, COUNT(DISTINCT de.emp_no) AS nb_emps
FROM t_dept_emp de
	LEFT JOIN t_employees e
    ON de.emp_no=e.emp_no
GROUP BY e.gender
ORDER BY e.gender;

# 2. Compare the number of male managers to the number of female managers from different departments for each year, starting from 1990.
SELECT
	starts.calendar_year,
    starts.gender,
    starts.dept_name,
    COALESCE(nb_starts,0) AS nb_starts, # The COALESCE() function returns the first non-null value in a list.
    COALESCE(nb_ends,0) AS nb_ends,
    COALESCE(nb_starts - nb_ends, nb_starts, - nb_ends) AS var 
FROM
	# 'starts' temp table: hires and changes to new position
	(
    SELECT
		YEAR(de.from_date) AS calendar_year,
		COALESCE(e.gender, 'Unknown') AS gender,
        d.dept_name,
		COUNT(*) AS nb_starts
	FROM t_dept_emp de
		LEFT JOIN t_employees e ON de.emp_no = e.emp_no # LEFT JOIN as some emp_no of t_dept_emp are not referenced in t_employees
        INNER JOIN t_dept_manager m ON de.emp_no = m.emp_no
        INNER JOIN t_departments d ON de.dept_no = d.dept_no
	GROUP BY calendar_year, e.gender, d.dept_name
	#HAVING calendar_year >= '1990'
    ) starts
LEFT JOIN
	# 'ends' temp table: terminations and changes from current position
    (
    SELECT
		YEAR(de.to_date) AS calendar_year,
        COALESCE(e.gender, 'Unknown') AS gender,
        d.dept_name,
        COUNT(*) AS nb_ends
	FROM t_dept_emp de
		LEFT JOIN t_employees e ON e.emp_no = de.emp_no
        INNER JOIN t_dept_manager m ON de.emp_no = m.emp_no
        INNER JOIN t_departments d ON de.dept_no = d.dept_no
	GROUP BY calendar_year, e.gender, d.dept_name
	#HAVING calendar_year >= '1990'
    ) ends
ON starts.calendar_year = ends.calendar_year AND starts.gender = ends.gender AND starts.dept_name = ends.dept_name
ORDER BY starts.calendar_year, starts.gender, starts.dept_name;

#3. Compare the average salary of female versus male employees in the entire company until year 2002,
# and add a filter allowing you to see that per each department.

SELECT 
		YEAR(s.from_date) AS calendar_year,
        COALESCE(e.gender, 'Unknown') AS gender,
        d.dept_name,
        # We don't take AVG(s.salary) as then we want to be able to aggregate at company level and depts level
        # And the average of the depts' averages is not the average for the entire company
		SUM(s.salary) AS total_salary,
        COUNT(de.emp_no) AS nb_employees
FROM t_dept_emp de
	LEFT JOIN t_employees e ON de.emp_no = e.emp_no
    INNER JOIN t_departments d ON de.dept_no = d.dept_no
    INNER JOIN t_salaries s ON de.emp_no = s.emp_no
GROUP BY calendar_year, gender, dept_name
ORDER BY calendar_year, gender, dept_name;

#4. Create an SQL stored procedure that will allow you to obtain the average male and female salary per department
# within a certain salary range. Let this range be defined by two values the user can insert when calling the procedure.
# Finally, visualize the obtained result-set in Tableau as a double bar chart.


DROP PROCEDURE IF EXISTS avg_salary;
DELIMITER $$
CREATE PROCEDURE avg_salary(
		IN min_range INTEGER,
		IN max_range INTEGER)
	BEGIN
		SELECT 
			COALESCE(e.gender, 'Unknown') AS gender,
			d.dept_name,
			SUM(s.salary) AS total_salary,
			COUNT(de.emp_no) AS nb_employees
		FROM t_dept_emp de
			LEFT JOIN t_employees e ON de.emp_no = e.emp_no
			INNER JOIN t_departments d ON de.dept_no = d.dept_no
			INNER JOIN t_salaries s ON de.emp_no = s.emp_no
		WHERE s.salary >= min_range AND s.salary <= max_range
		GROUP BY gender, dept_name
		ORDER BY gender, dept_name;
	END$$
        
DELIMITER ;

CALL avg_salary(30000, 60000);
    