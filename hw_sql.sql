use hr;

#1. Write a SQL query to display all information about all departments.
SELECT
	*
FROM
	departments;


#2. Write a SQL query to find all department names.
SELECT	
	department_name
FROM
	departments;


/*3. Write a SQL query to find the salary of each employee by month, by day
and hour. Consider that one month has 20 workdays and each workday
has 8 work hours. */

SELECT
	salary AS salary_month,
    salary/20 as salary_month,
    salary/20/8 as salary_day
FROM
	employees;
    
/*
4. Write a SQL query to find the email addresses of each employee.
Consider that the mail domain is mail.somecompany.com. Emails should
look like "bernst@mail.somecompany.com". The produced column
should be named "Full Email Address".
*/

SELECT
	email as 'FULL EMAIL ADRESS'
FROM
	employees
WHERE email LIKE '%@%.com';
    
#5. Write a SQL query to find all different salaries that are paid to the employees. Use DISTINCT.
SELECT 
	DISTINCT salary
FROM
	employees;
    
#6. Write a SQL query to find all departments and all region names, country names and city names as a single list. Use UNION.
SELECT department_name FROM departments
UNION
SELECT region_name FROM regions
UNION
SELECT country_name FROM countries;

#7. Write a SQL query to find all information about the employees whose position is "AC_MGR" (Accounting Manager).
SELECT 
	*
FROM
	jobs
WHERE job_title like 'Accounting Manager';

#8. Write a SQL query to find the names of all employees whose first name starts with "Sa". Use LIKE.
SELECT
	first_name as 'starting with SA'
FROM
	employees
WHERE first_name LIKE 'SA%';

#9. Write a SQL query to find the names of all employees whose last name contains the character sequence "ei". Use LIKE.
SELECT
	last_name as 'contains ei'
FROM
	employees
WHERE last_name LIKE '%ei%';

#10. Write a SQL query to find the names of all employees whose salary is in the range [3000...5000]. Use BETWEEN.
SELECT
	salary
FROM
	employees
WHERE salary BETWEEN 3000 and 5000;

/*
11. Write a SQL query to find the names of all employees whose
salary is in the range [2000...15000] but is not in range [5000 … 10000].
Use MINUS.
*/
SELECT
	salary
FROM
	employees
WHERE salary not between 2000 and 10000 and salary between 5000 and 15000;


#12. Write a SQL query to find the names of all employees whose salary is 2500, 4000 or 5000. Use IN.
select
	salary
from employees
where salary in(2500,4000,5000);

#13. Write a SQL query to find all locations that have no state or post code defined. Use IS NULL.
select
	state_province,
    postal_code
from 
	locations
where state_province is not null and postal_code is not null;

/*14. Write a SQL query to find all employees that are paid more
than 10 000. Order them in decreasing order by salary. Use ORDER BY.
*/
select
	salary
from
	employees
where salary > 10000
order by salary desc;

#15. Write a SQL query to find the first 10 employees joined the company (most senior people).
select
	concat_ws(' ', first_name, last_name),
	hire_date
from
	employees
order by hire_date asc
limit 10;

#16. Write a SQL query to find all departments and the town of their location. Use NATURAL JOIN.
select
	*
from 
	departments
join locations;


#17. Write a SQL query to find all departments and the town of their location. Use join with USING clause.
select
	department_name,
    city
from
	departments
join locations using(location_id);


#18. Write a SQL query to find all departments and the town of their location. Use inner join with ON clause.
select
	d.department_name,
    l.city
from departments d
join locations l on(d.location_id = l.location_id);


#19. Modify the last SQL query to include also the name of themanager for each department.
select
	d.department_name,
    l.city,
    concat_ws(' ', e.first_name, e.last_name) as 'manager name'
from departments d
inner join locations l on(d.location_id = l.location_id)
inner join employees e on(d.department_id = e.department_id);


/*20. Write a SQL query to find all the locations and the
departments for each location along with the locations that do not have
department. User right outer join.
*/

select
	l.location_id,
	d.department_name
from locations l
right join departments d on(l.location_id = d.location_id);

#21. Rewrite the last SQL query to use left outer join
select
	l.location_id,
	d.department_name
from locations l
left join departments d on(l.location_id = d.location_id);

#22. Rewrite the last query to use WHERE instead of JOIN.
select
	l.location_id,
    d.department_name
from locations l,departments d
where d.location_id = l.location_id;

#23. Write a SQL query to find the manager name of each department.
select
	concat_ws('', e.first_name, e.last_name) as 'manager name',
    d.department_name
from employees e
left join departments d on(e.department_id = d.department_id);

/*25. Write a SQL query to find the names of all employees from
the departments "Sales" and "Finance" whose hire year is between 1995
and 2000.*/
select 
	e.first_name,
    d.department_name,
    e.hire_date
from employees e
inner join departments d on(e.department_id = d.department_id)
where d.department_name in('sales', 'finance') and e.hire_date between('1995-12-31') and ('2000-12-31');

/*26. Find all employees that have worked in the past in the
department “Sales”. Use complex join condition.
*/
select
	concat_ws(' ', e.first_name, e.last_name),
    d.department_name,
    e.hire_date
from employees e
left join departments d on(e.department_id = d.department_id)
where d.department_name in('sales') and e.hire_date < '2016-03-21'
order by e.hire_date desc;

/*27. Write a SQL query to display all employees (first and last
name) along with their corresponding manager (first and last name). Use
self-join.
*/
select 	
	concat_ws('', e.first_name, e.last_name) as 'employee name',
    concat_ws('', m.first_name, m.last_name) as 'manager name'
from employees e, employees m
where concat_ws('', e.first_name, e.last_name) =  concat_ws('', m.first_name, m.last_name);

/*28. Combine all first names with all last names of the employees
with a CROSS JOIN.*/
select
	e.first_name,
    m.last_name
from employees m
cross join employees e;

#29. Write a SQL query to display all employees, along with their job title, department, location, country and region. Use multiple joins.
select
	concat_ws('', e.first_name, e.last_name) as 'employee name',
    j.job_title,
    d.department_name,
    l.city,
    c.country_name,
    r.region_name
from
	employees e
left join jobs j on(e.job_id = j.job_id)
left join departments d on (e.department_id = d.department_id)
left join locations l on(d.location_id = l.location_id)
left join countries c on(l.country_id = c.country_id)
left join regions r on(c.region_id = r.region_id);

#30. Modify the last SQL query to display also the manager name for each employee or “No manager” in case there is no manager. 

/*31. Write a SQL query to find all employees that have worked in
the past at job position “AC_ACCOUNT” and at some time later at job
position “AC_MGR”. Display the employees’ names and current job title.
Hint: first self-join JOB_HISTORY table, then apply filtering and finally
join the result with EMPLOYEES and JOBS tables. */

select
	concat_ws('', e.first_name, e.last_name),
    j.job_title as 'previous',
    j2.end_date
from employees e
join jobs j on(e.job_id = j.job_id)
join job_history j2 on(e.employee_id = j2.employee_id)
having j2.end_date < '2016-03-21' and j.job_title = 'Accounting Manager';

    

    
    



