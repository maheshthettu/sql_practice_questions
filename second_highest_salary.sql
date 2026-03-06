 -- find the second highest from a employes table 

---limit offset 
select  distinct salary 
from  employes 
order by salary desc 
offset 1 limit 1;


--rank window function  -- normal data 
select salary 
from (select salary,
rank() over ( order by salary desc ) as rank
from employes) t
where rank=2 ;
-- if we use partion in rank to rank the data based on group of data 

--dense_rank window function --duplicate data 
select salary 
from (select salary,
dense_rank() over ( order by salary desc ) as rank
where rank=2) ;
-- if we use partion in rank to rank the data based on group of data 

--using max -- 2nd highest 

select max(salary) 
from employes
where salary < (select max(salary) 
                from employes);

--using max -- 2nd highest 

select max(salary)
from employes
where salary not in (select max(salary)
                    from employes);

