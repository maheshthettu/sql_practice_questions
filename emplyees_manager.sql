-- selecting emplyee and its manager 

select e.employee_id as employee,
m.employee_id as manager
from employee e 
inner join employee m 
on e.manager_id=m.employee_id
;
 
-- employees with no manager 
select e.employee_id as employee,
m.employee_id as manager
from employee e 
left join employee m 
on e.manager_id=m.employee_id
where m.employee_id is null
;

-- employee salary is greater than manger 

select employee 
from 
(select e.employee_id as employee,
m.employee_id as manager
from employee e 
inner join employee m 
on e.manager_id=m.employee_id
where e.salary >m.salary ) t
;

-- manager  with aleast one employee

select distinct m.employee_id
from employee e
join employee m
on e.manager_id = m.employee_id;

-- count of employees reporting to one manager 

select 
m.employee_id as manager
,count(e.employee_id) as count_reporters
from employee e 
inner join employee m 
on e.manager_id=m.employee_id
group by m.employee_id 

;

--Find employees who earn more than the average salary of their department
select *
from employee e
where salary >
(
    select avg(salary)
    from employee
    where   = e.department_id
);


---employees with same manager 
select e1.employee_id as employee1,
e2.employee_id as employee2
from employee e1 
inner join employee e2 
on e1.manager_id=e2.manager_id
and e1.employee_id <>e2.employee_id
;