-- 1��

SELECT
    e.employee_id,
    e.first_name,
    d.department_name,
    m.first_name "�Ŵ��� �̸�"
FROM
    employees e 
    join departments d on e.department_id = d.department_id
    join employees m on e.manager_id = m.employee_id;

-- 2��
    
SELECT
    e.last_name,
    e.salary
FROM
    employees e 
    join employees m on e.manager_id = m.employee_id
    WHERE e.salary > m.salary;
    
-- 3��

SELECT
    e.first_name,
    e.last_name,
    e.salary
FROM
    employees e 
    join jobs j on e.job_id = j.job_id
    and upper(j.job_title) = upper('Sales Representative')
where e.salary between 9000 and 10000;
    
-- 4��

SELECT
    e.employee_id,
    e.last_name,
    e.hire_date
FROM
    employees e 
    join employees m on e.manager_id = m.employee_id
WHERE
    e.hire_date < m.hire_date;
    
-- 5��

SELECT DISTINCT
    job_title,
    department_name
FROM
    employees e
    join departments d on e.department_id = d.department_id
    join jobs j on e.job_id = j.job_id;
    
-- 7��

SELECT
    e.first_name,
    e.hire_date,
    m.employee_id,
    m.first_name
FROM
    employees e 
    LEFT OUTER JOIN employees m ON e.manager_id = m.employee_id
WHERE
    to_char(e.hire_date, 'yy') = '08';
    
-- 8��

SELECT
    e.first_name,
    e.salary,
    d.department_id
FROM  
    employees e
    join departments d on e.department_id = d.department_id
WHERE
    upper(d.department_name) = upper('Sales');
    
-- 9��

SELECT
    e.hire_date,
    e.employee_id,
    e.first_name,
    e.last_name,
    nvl(d.department_name, '<NOT ASSIGNED>')
FROM
    employees e
    LEFT OUTER JOIN departments d
       ON e.department_id = d.department_id
WHERE
    to_char(e.hire_date, 'yyyy') = '2004';

-- 10��

SELECT
    e.first_name,
    e.hire_date,
    m.employee_id,
    m.first_name
FROM
    employees e
    LEFT OUTER JOIN employees m
       ON e.manager_id = m.employee_id
WHERE
    to_char(e.hire_date, 'yyyy') = '2003';
