--Create new table
SELECT e.emp_no, e.first_name, e.last_name, ti.title, ti.from_date, ti.to_date
into retirement_titles
from employees as e
INNER JOIN titles as ti
ON e.emp_no=ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date='9999-01-01'
ORDER BY emp_no, to_date DESC;

--retrieve the number of employees by their most recent job title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

--Create Mentorship eligibility table
SELECT DISTINCT ON (e.emp_no)e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO membership_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
	ON (e.emp_no=de.emp_no)
INNER JOIN titles AS t
	ON (e.emp_no=t.emp_no)
Where (de.to_date='9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

--Get a count of titles who are eligible for mentorship program
SELECT COUNT(title), title
FROM membership_eligibility
GROUP BY title
ORDER BY COUNT(title) DESC;

--Expanding the mentorship eligible beyond 1965
SELECT DISTINCT ON (e.emp_no)e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO membership_eligibility_expanded
FROM employees AS e
INNER JOIN dept_emp AS de
	ON (e.emp_no=de.emp_no)
INNER JOIN titles AS t
	ON (e.emp_no=t.emp_no)
Where (de.to_date='9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1980-12-31')
ORDER BY e.emp_no;
--Count by title on membership_eligibility_expanded
SELECT COUNT(title), title
FROM membership_eligibility_expanded
GROUP BY title
ORDER BY COUNT(title) DESC;

