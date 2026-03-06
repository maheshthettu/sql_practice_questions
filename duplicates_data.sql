--finding duplicate data from the table based on employee_id,employee_name 

---normal method if we know the table columns where we need to find the duplicates
select employee_id 
from (
    select employee_name,
           employee_id,
           count(*) as c
    from employes
    group by employee_name, employee_id
    having count(*) > 1
);

-- for all columns 
select *
from employes
group by all
having count(*) > 1;

select hash(*) as hash_columns ,count(*)
from employes 
group by hash_columns
having count(*) >1;


--row_number 
select distinct employee_id 
from (
    select employee_name,
           employee_id,
           row_number() over (
               partition by employee_name, employee_id 
               order by employee_name, employee_id desc
           ) as r
    from employes
) t
where r > 1;

--hash(*) to group the data for all columns 

select *
from (
    select *,
           row_number() over (partition by hash(*)) as rn
    from employes
)
where rn > 1;




---delete the data from table duplicate all rows 
delete from employes where employee_id in (select distinct employee_id 
from (
    select 
           employee_id,
           row_number() over (
               partition by  employee_id 
               order by  employee_id desc
           ) as r
    from employes
) t
where r > 1
);



-- will not work on snowflake 
with cte as (

    select 
           employee_id,
           row_number() over (
               partition by  employee_id 
               order by  employee_id desc
           ) as r
    from employes
) 
delete from cte
where r>1;
;

