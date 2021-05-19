--1.First, find all departments located at the location whose id is 1700:
select * from departments_2611_ where location_id=1700;

--2.	Find all employees who do not locate at the location 1700
 select * from departments_2611_ where not location_id=1700;

--3.find the employees who have the highest salary 
select * from employees_2611_ where salary=(select max(salary) from employees_2611_);

--4.find all employees who salaries are greater than the average salary of all employees
select avg(salary) from employees_2611_;
select * from employees_2611_ where salary>(select avg(salary) from employees_2611_);
--extra:  find all employees who salaries are greater than the average salary of their department
SELECT employee_id, department_id, salary, avg(salary)
    FROM employees_2611_
    GROUP BY employee_id, department_id, salary
    HAVING salary > (select avg(salary) from employees_2611_ group by department_id);

--5.find all departments which have at least one employee with the salary is greater than 10,000:
select distinct department_name from departments_2611_  A,employees_2611_ B where A.department_id=B.department_id and salary>10000;

--6.find all employees whose salaries are greater than the lowest salary of every department:
select * from employees_2611_ where salary>
(select min(salary) from employees_2611_ group by department_id);

--7.find the salaries of all employees, their average salary, 
--and the difference between the salary of each employee and the average salary.
select avg(salary) from employees_2611_;
select salary,salary-(SELECT AVG(salary) FROM employees_2611_) AS SalDiff FROM employees_2611_;
     
--8.List the Employees whose name starts with “ar”
select * from employees_2611_ where first_name like 'ar%';

--9.List the Employees whose name starts with P,B,R characters.
select * from employees_2611_ where first_name like 'p%' OR first_name like 'b%' OR first_name like 'r%' ;

--10.What is query to display odd rows from the Employees table?
 select * from employees_2611_ where mod(employee_id,2)=1 ;
 --select rownum  from employees_2611_ where mod(rownum,2)=1;
 SELECT *
  FROM   ( SELECT rownum rn, employee_id
           FROM employees_2611_
         ) temp
  WHERE  MOD(temp.rn,2) <> 0;
select * from employees_2611_ where (rowid,1) in (select rowid, mod(rownum,2) from employees_2611_);
select * from employees_2611_ where (employee_id,1) in (select employee_id, mod(rownum,2) from employees_2611_);

--11.	Find Query to get information of Employee where Employee is not assigned to the department
select * from employees_2611_ where department_id is NULL;
select * from employees_2611_ where department_id  not in(select department_id from departments_2611_);

--12.	How to fetch all the records from Employee whose joining year is  2018?
select * from employees_2611_ where to_char(hire_date,'yyyy')='2018';

--13.	How Do you find all Employees with its managers?(Consider there is manager id also in Employee table)
select employee_id,manager_id from employees_2611_;

--14	Display 3 to 7 records from Employee table.
--select * from employees_2611_ where rownum>3 and rownum<7  ;
select * from (Select rownum as No_of_Row, E.* from employees_2611_ E)
Where No_of_Row between 3 and 7;