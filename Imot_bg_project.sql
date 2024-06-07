

--This query selects properties with bedrooms listed as 'Attic' and located on the third floor.
--The output includes all columns from the Imot_bg table for such properties.

SELECT *
FROM Imot_bg
WHERE bedrooms = 'Attic'
  AND floor = 3;



-- This query selects properties in the 'Boyana' area with 3 bedrooms,
-- and assigns a rank to each property based on its price within the 'Boyana' location.
-- The rank is determined using the DENSE_RANK() function,
-- ensuring that properties with the same price receive the same rank.
-- The output includes the location, price, number of bedrooms, and the calculated rank.

SELECT  
Location,
Price,
bedrooms,
Dense_rank() OVER(PARTITION BY Location  ORDER BY Price DESC) AS  Rank
FROM 
	Imot_bg 
WHERE 
	bedrooms = 3 
	AND Location ='Boyana';


-- This query selects all properties with prices higher than the average price,
-- sorted in ascending order by price.

SELECT * 
FROM Imot_bg
WHERE Price>(SELECT AVG(Price) FROM Imot_bg)
ORDER BY Price ASC;


--This query selects properties with square meters greater than 100, bedrooms listed as 'Attic',
--and prices higher than the average price of all properties

SELECT * 
FROM Imot_bg 
WHERE  
	square_metres > 100 
	AND  bedrooms IN ('Attic')
	AND Price >(SELECT avg(Price) FROM Imot_bg);


-- This query calculates the average price of properties in each location,
-- rounds the average price to the nearest whole number, and assigns a rank to each location
-- based on the descending order of average prices.

SELECT 
Location,
round(AVG(Price),0) as average_price,
RANK() OVER(ORDER BY round(AVG(Price),0) DESC ) AS Ranking
FROM Imot_bg 
GROUP BY Location ;


-- This query selects the top 3 highest priced properties for each location,
-- along with their respective locations and prices.

SELECT 
Location,
Price,
ranking
FROM 
	(SELECT 
		Location,
		Price,
    	DENSE_RANK() OVER (PARTITION BY Location ORDER BY Price DESC) AS ranking
      FROM Imot_bg) AS ranked
WHERE 
	ranking in (1,2,3);









