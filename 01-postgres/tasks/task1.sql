--1.
select first_name,last_name,department,salary from public.employees;

--2.
select * from public.employees WHERE department LIKE 'Engineering';

--3.
select id,first_name,last_name,is_remote,salary from public.employees where is_remote is TRUE AND salary>80000;

--4.
SELECT * from public.employees 
where hire_date 
    BETWEEN '2021-01-01' 
    and '2022-12-31'
ORDER BY hire_date;

--5.
select * from public.employees
where job_title LIKE '%Manager%';

--6.
select first_name,last_name,job_title,salary from public.employees
ORDER BY salary desc
LIMIT 3;

--7.
select count(id),round(avg(salary),2) as "avg" from public.employees;

--8.
select department,count(id),round(avg(salary),2) from public.employees
GROUP BY department;

--9.
select department,count(id),round(avg(salary),2) from public.employees
GROUP BY department
HAVING avg(salary)>80000;

