#-- HR Analysis---

Create database HR;
use hr;

#-- Add Employee Age Column --

#--added column---
alter table hr_data
add column age int;

#-- Update age column ---

update hr_data
set age = year(curdate())-right(birthdate,4);

#-- add Emp Tenure column --
alter table hr_Data
add column Tenure int;

update hr_Data
set Tenure = year(current_date())-right(hire_date,4);

#---Average Employee Age by Gender---

select gender,avg(age) from hr_data
group by gender;

#--- Average Employee Tenure by Gender ---

select gender,round(avg(Tenure))
from hr_Data
group by gender;

#--- Employee count by department and jobtitle---
select department,jobtitle, count(﻿id) as Total_Employee
from hr_data
group by jobtitle,department
order by total_employee desc;

select department,jobtitle
,count(﻿id) as Total_Employee
,row_number() over (partition by department order by count(﻿id) desc) as rnk
from hr_Data
group by department,jobtitle
having count(﻿id) > 150;

with cte as 
(select t1.first_name,t1.last_name,t1.birthdate 
from 
(select * from hr_data) as t1
join 
(select * from hr_data) as t2
on t1.birthdate = t2.birthdate )

select distinct(birthdate), count(birthdate) as count
from cte
group by birthdate
having birthdate =  '7/29/1989';

update hr_data
set termdate = 
case when termdate = "0000-00-00 00:00:00" then current_date()
else 
replace(termdate,"UTC","") end ;

#--- Tenure wise employee count
select tenure,count(﻿id)as Employee_Count
from hr_data
group by tenure
order by Employee_count desc;

#--- Departmnt wise employee count ---
select department,count(﻿id) as Total_Employee,Round(count(﻿id)/(select count(*) from hr_data)*100,2) as percentage
from hr_data
group by department
order by Total_Employee desc;   #--- 30% employees are working with Engineering department---

#--- On which year most of the employees are hired? ---
 #--- Replaced hire_date "/" to "-" ---
update hr_data
set hire_date = replace(hire_date,"/","-");

select distinct(right(hire_date,4)) as Hire_Year,count(*) as Total_Emp 
from hr_data
group by Hire_Year
order by Total_Emp desc; #--- In 2004 employee 574 employees are hired

#--- Term employee count ---
select count(first_name) as Term_employee_count
from hr_data
where termdate< '2024-03-16';   #--- 1212 employee are tremed


#--- Department wise office location counts ---
select department,count(location_city) as offices
from hr_data
group by department;   #--- There is 3278 locations where we have Engineering dept ---

#--- Show employee head count as per the location/office
select location, count(*) as Employee_count 
from hr_data
group by location;  #--- There is 8156 employee working from Headquartes and 2688 from remote ---

SELECT department,
    COUNT(CASE WHEN location = 'remote' THEN 1 END) AS Remote_Emp_Count,
    COUNT(CASE WHEN location = 'headquarters' THEN 1 END) AS Headquators_Emp_Count
FROM hr_Data
GROUP BY department
order by remote_emp_count desc;  #--- Most of the Engineering dept employee are working as Remote---

select department, count(*) as Emp_Count
from hr_Data
group by department
having count(*)<200
order by Emp_Count desc;  # Legal and Auditing depat have employee count respectivly 140 and 29.

#--- Average age of employee --- 

select round(avg(age)) from hr_Data;  #--- Average age of employees is 40 years ---

#--- Count of employees having age greater than avg age ---

select count(age)
from hr_data
where age > ( select avg(age) from hr_Data );  #--- There is 5293 Employee having age greter than Avg age of all employees

# --- Location and race wise top 3 employee count
with cte as
(select location, race, count(*) employee_count,
dense_rank() over (partition by location order by count(*) desc) as E_Rank 
from hr_Data
group by race, location)

select * from cte where e_Rank in (1,2);  # --- after race white asian and Two or more races are working from headquarters and remote


#--- Department & gender wise employee count ---

select department,gender, count(*) as Emp_Count
,dense_rank() over (partition by department order by count(*) desc) as rnk
from hr_Data
group by department,gender;

#--- Write a query to extract department where female employee count is > male employee count ---

with cte1 as
(select department,
sum(case when gender = 'Female' then 1 end) as Female_emp,
sum(case when gender = 'male' then 1 end ) as Male_Emp
from hr_data
group by department)

select * from cte1 where female_emp >= Male_emp;  #--- there is no department having female employee count > male count --- 




select * from hr_Data limit 5;



