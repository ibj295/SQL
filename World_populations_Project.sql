use world;

# --- Population Distribution:---

 # 1. --- Select Top five world population countries ---
SELECT co.country_name,
       Sum(c.population) AS Population
FROM   city AS c
       JOIN country AS co
         ON c.countrycode = co.code
GROUP  BY country_name
ORDER  BY population DESC
LIMIT  5; 

# 2. --- Select lowest five world population countries ---
 SELECT co.country_name,
       Sum(c.population) AS Population
FROM   city AS c
       JOIN country AS co
         ON c.countrycode = co.code
GROUP  BY country_name
ORDER  BY population asc
LIMIT  5; 

# 3. --- Select top 5 countries and their most populated cities ---
SELECT co.country_name,
       c.name       AS City,
       c.population AS population
FROM   city AS c
       JOIN country AS co
         ON c.countrycode = co.code
ORDER  BY population DESC
LIMIT  5; 

#4. --- Top 2 countries with distribution of population across different regions?---
WITH cte
     AS (SELECT co.continent,
                co.country_name,
                Sum(c.population) AS population,
                Dense_rank()
                  OVER (
                    partition BY co.continent
                    ORDER BY Sum(c.population) DESC) AS rnk
         FROM   city AS c
                JOIN country AS co
                  ON c.countrycode = co.code
         GROUP  BY co.continent,
                   co.country_name
         ORDER  BY population DESC)
SELECT continent,
       country_name,
       population
FROM   cte
WHERE  rnk IN ( 1, 2 )
ORDER  BY continent ASC; 

# --- Which countries have the highest and lowest populations? ---

select Max_country, Max_population, Min_country, Min_population from 
(select co.country_name as Max_country, sum(c.population) as Max_population
,dense_rank() over (order by sum(c.population) desc) as rnk
from city as c
join country as co
on c.countrycode = co.code
group by country_name) T1
join
(select co.country_name as Min_country, sum(c.population) as Min_population
,dense_rank() over (order by sum(c.population) asc) as rnk
from city as c
join country as co
on c.countrycode = co.code
group by country_name) T2
on t1.rnk = t2.rnk
limit 1;   # --- China has highest population and pitcairn has lowest population ---

#--- Top five countries with Highest population ---

select country_name, SurfaceArea
from country
order by SurfaceArea desc
limit 5 ;  

# --- Top Five languages by population ---

select cl.language, sum(c.population) as population
from countrylanguage as cl
join city as c
on cl.countryCode = c.Countrycode
join country as co
on c.countryCode = co.code
group by  language
order by population desc
limit 5;

#--- Which continents has highest area and population ---

select continent,sum(SurfaceArea) as SurfaceArea, sum(population) as Population
from country
group by continent
order by population , surfacearea desc;

#--- Top 5 continent by surfacearea ---
select continent,sum(SurfaceArea) as SurfaceArea
from country
group by continent
order by surfacearea desc;

#--- Highest Life expectancy by countries ---

select country_name, LifeExpectancy 
from country
order by lifeExpectancy desc
limit 5;
  
#--- Lowest Life expectancy by countries ---
select country_name, lifeExpectancy 
from country
where lifeExpectancy is not null
order by lifeExpectancy asc
limit 5;

# --- Which langunage is the offical languange of most of countries. ---

select language, count(isofficial) as Countries 
from countrylanguage
where isofficial = 'T'
group by language
order by Countries desc
limit 1 ;  # English is the official language of 44 countries ---

# --- Continent wise language speaking countries.---
with cte3 as
(select Co.Continent, cl.language,count(isofficial) as Countries
,dense_rank() over (partition by co.continent order by count(isofficial) desc) as rn
from country as co
join countrylanguage as cl
on co.code = cl.countryCode
where isofficial = 'T'
group by continent, language
order by Countries desc)

select * from cte3
where rn in (1)
order by countries desc , Continent asc;


 


