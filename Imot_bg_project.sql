

--This query selects properties with bedrooms listed as 'Attic' and located on the third floor.
--The output includes all columns from the Imot_bg table for such properties.

SELECT * from Imot_bg
where bedrooms is 'Attic' and floor =3


-- This query selects properties in the 'Boyana' area with 3 bedrooms,
-- and assigns a rank to each property based on its price within the 'Boyana' location.
-- The rank is determined using the DENSE_RANK() function,
-- ensuring that properties with the same price receive the same rank.
-- The output includes the location, price, number of bedrooms, and the calculated rank.

select Location ,Price,bedrooms ,
dense_rank() over(PARTITION by Location  order by Price desc) as  Rank
from Imot_bg ib 
where bedrooms = 3 and Location ='Boyana'


-- This query selects all properties with prices higher than the average price,
-- sorted in ascending order by price.

SELECT * FROM Imot_bg
where Price>(SELECT AVG(Price) from Imot_bg)
order by Price asc


--This query selects properties with square meters greater than 100, bedrooms listed as 'Attic',
--and prices higher than the average price of all properties

SELECT * FROM Imot_bg 
where square_metres > 100 
and bedrooms in ('Attic')
and Price >(SELECT avg(Price) from Imot_bg)


-- This query calculates the average price of properties in each location,
-- rounds the average price to the nearest whole number, and assigns a rank to each location
-- based on the descending order of average prices.

SELECT Location , round(AVG(Price),0) as average_price,
rank() over(ORDER by round(AVG(Price),0) desc ) as Ranking
from Imot_bg 
group by Location 


-- This query selects the top 3 highest priced properties for each location,
-- along with their respective locations and prices.

SELECT Location,Price, ranking
from (select Location,Price,
       DENSE_RANK() OVER (PARTITION BY Location ORDER BY Price DESC) as ranking
       from Imot_bg) as ranked
where ranking in (1,2,3)









