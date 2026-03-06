--cout of employees in each department 

select department_id
,count(*) as employee_count
from employee
where department_id is not null
group by department_id
;

--cout of employees in each department 5 and Avg 50000
select department_id,
       count(*) as emp_count,
       avg(salary) as avg_salary
from employees
group by department_id
having count(*) > 5
and avg(salary) > 50000;


--- employee ,department names

select 
e.employee_name,
d.department_name 
from employee e
left join department d
on e.department_id=d.id 
where d.department_name is not null ;

--- highest salary in each department 
select e.department_id, max(e.salary) 
from employee e
group by e.department_id

-- find the employee name whoes salary is max in each department name 

with cte_employee as (
    select employee_id,
           department_id,
           salary,
           row_number() over (
               partition by department_id
               order by salary desc
           ) as rn
    from employee
)

select e.employee_id,
       d.department_name,
       e.salary
from cte_employee e
join department d
on e.department_id = d.id
where e.rn = 1;


