-- Problem 3 : Get number vehicles made between 1950 and 2000
select count(*) as NumberOfVehicles from VehicleDetails
where   Year between 1950 and 2000 

-- Problem 4 : Get number vehicles made between 1950 and 2000 per make and order 
-- them by Number Of Vehicles Descending

select * from Makes;
select * from VehicleDetails;

select Makes.Make, COUNT(*) as NumberVehicles

from VehicleDetails inner join Makes

      on VehicleDetails.MakeID = Makes.MakeID
where (VehicleDetails.Year between 1950 and 2000)
group by Makes.Make
order by NumberVehicles desc;

-- Problem 5 : Get All Makes that have manufactured more than 12000 Vehicles in years 1950 to 2000

select Makes.Make, COUNT(*) as NumberVehicles

from VehicleDetails inner join Makes

      on VehicleDetails.MakeID = Makes.MakeID
where (VehicleDetails.Year between 1950 and 2000)
group by Makes.Make
having count(*) > 12000
order by NumberVehicles desc;

-- without using having 
select * from (
select Makes.Make, COUNT(*) as NumberVehicles

from VehicleDetails inner join Makes

      on VehicleDetails.MakeID = Makes.MakeID
where (VehicleDetails.Year between 1950 and 2000)
group by Makes.Make
) R1
where NumberVehicles>12000
ORDER BY NumberVehicles desc

-- Problem 6: Get number of vehicles made between 1950 and 2000 per make and add total vehicles
-- column beside

select Makes.Make, COUNT(*) as NumberVehicles, (select count(*) from VehicleDetails) as TotalVehicles

from VehicleDetails inner join Makes

      on VehicleDetails.MakeID = Makes.MakeID
where (VehicleDetails.Year between 1950 and 2000)
group by Makes.Make
order by NumberVehicles desc;

--Problem 7: Get number of vehicles made between 1950 and 2000 per make and add total vehicles column beside it,
-- then calculate it's percentage

select *, (cast(NumberVehicles as float) / cast (TotalVehicles as float)) as Perc from 
(
select Makes.Make, COUNT(*) as NumberVehicles, (select count(*) from VehicleDetails) as TotalVehicles

from VehicleDetails inner join Makes

      on VehicleDetails.MakeID = Makes.MakeID
where (VehicleDetails.Year between 1950 and 2000)
group by Makes.Make
) R1
order by NumberVehicles desc;

-- Problem 8: Get Make, FuelTypeName and Number of Vehicles per FuelType per Make 

select * from FuelTypes;
select * from Makes;
select * from VehicleDetails;

select Makes.Make ,FuelTypes.FuelTypeName ,count(*) as NumberOfVehicles

from VehicleDetails  inner join Makes
       on VehicleDetails.MakeID = Makes.MakeID 
       inner join FuelTypes 
       on VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
where (VehicleDetails.Year between 1950 and 2000)
group by Makes.Make , FuelTypes.FuelTypeName

order by Makes.Make

-- Problem 9: Get all vehicles that runs with GAS

select * from VehicleDetails;

select  VehicleDetails.* , FuelTypes.FuelTypeName 

from 
VehicleDetails inner join FuelTypes
               on VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID 
where (FuelTypes.FuelTypeName = N'GAS')

-- Problem 10: Get all Makes that runs with GAS

SELECT DISTINCT Makes.Make, FuelTypes.FuelTypeName
FROM VehicleDetails
      INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
      INNER JOIN FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
WHERE FuelTypes.FuelTypeName = 'GAS'
order by Makes.Make

--  Problem 11: Get Total Makes that runs with GAS

select count (distinct Makes.MakeID) as TotalMakesRunOnGas
from VehicleDetails 
         inner join Makes on VehicleDetails.MakeID = Makes.MakeID
         inner join FuelTypes on VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID

WHERE FuelTypes.FuelTypeName = 'GAS'

-- best and fast solution

select count(*) as TotalMakesRunOnGas 
from (
      SELECT DISTINCT Makes.Make, FuelTypes.FuelTypeName
      FROM VehicleDetails
            INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
            INNER JOIN FuelTypes ON VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
      WHERE FuelTypes.FuelTypeName = 'GAS'
) R1

-- Problem 12: Count Vehicles by make and order them by NumberOfVehicles from high to low.

select Makes.Make , count(*) as NumberOfVehicles

from VehicleDetails
      inner join Makes on VehicleDetails.MakeID = Makes.MakeID
group by Makes.Make 
order by NumberOfVehicles desc

-- Problem 13: Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles

select *
from (
      select Makes.Make , count(*) as NumberOfVehicles

      from VehicleDetails
           inner join Makes on VehicleDetails.MakeID = Makes.MakeID
      group by Makes.Make 

) R1
where NumberOfVehicles >= 20000
order by NumberOfVehicles desc

-- Other solution 
select Makes.Make , count(*) as NumberOfVehicles

from VehicleDetails
       inner join Makes on VehicleDetails.MakeID = Makes.MakeID
group by Makes.Make 
having count(*) >= 20000
order by NumberOfVehicles desc

-- Problem 14: Get all Makes with make starts with 'B'
-- Write a query to get all Makes with make starts with 'B'.

select Makes.Make
from makes
where Makes.Make Like '[M,m]%';

-- Problem 15: Get all Makes with make ends with 'W'
-- Write a query to get all Makes with make ends with 'W'.

select Makes.Make
from makes
where Makes.Make Like '%[W,w]';

-- Problem 16: Get all Makes that manufactures DriveTypeName = FWD
-- Get all Makes that manufactures DriveTypeName = FWD

select distinct Makes.Make , DriveTypes.DriveTypeName 
from VehicleDetails
      inner join Makes on  VehicleDetails.MakeID = Makes.MakeID
      inner join DriveTypes on  VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
where DriveTypes.DriveTypeName = 'FWD'

-- Problem 17: Get total Makes that Mantufactures DriveTypeName=FWD
-- Get total Makes that Mantufactures DriveTypeName=FWD

select count(*) as MakeWithFWD
from (
      select distinct Makes.Make , DriveTypes.DriveTypeName 
      from VehicleDetails
            inner join Makes on  VehicleDetails.MakeID = Makes.MakeID
            inner join DriveTypes on  VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
      where DriveTypes.DriveTypeName = 'FWD'
)R3

-- Problem 18: Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc

select * from VehicleDetails;
select * from DriveTypes;

select Makes.Make, DriveTypes.DriveTypeName , count(*) as totalVehicles

from VehicleDetails
     inner join Makes on VehicleDetails.MakeID = Makes.MakeID
	 inner join DriveTypes on VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID

group by Makes.Make , DriveTypes.DriveTypeName
order by Makes.Make asc , totalVehicles desc

 -- Problem 19: Get total vehicles per DriveTypeName Per Make then filter only results with total > 10,000

 select Makes.Make , DriveTypes.DriveTypeName, count(*) as TotalVehicles

 from DriveTypes
        inner join VehicleDetails on DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID
		inner join Makes on Makes.MakeID= VehicleDetails.MakeID

group by Makes.Make, DriveTypes.DriveTypeName
having count(*) >10000
Order By Make ASC, TotalVehicles Desc

-- Problem 20: Get all Vehicles that number of doors is not specified

select * from VehicleDetails
where NumDoors is Null;

-- Problem 22: Get percentage of vehicles that has no doors specified

select 
(
     CAST((select  count(*) as TotalWithNoSpecifiedDoors from VehicleDetails 
	 where NumDoors is Null) as float) 
     /
	 CAST((select count(*) from VehicleDetails) as float)
) as PercOfNoSpecifiedDoors

-- Problem 23: Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'

select distinct VehicleDetails.MakeID , Makes.Make, SubModels.SubModelName

from  VehicleDetails
        inner join Makes on VehicleDetails.MakeID = makes.MakeID
		inner join SubModels on VehicleDetails.SubModelID = SubModels.SubModelID
where SubModels.SubModelName = 'Elite'

-- Problem 24: Get all vehicles that have Engines > 3 Liters and have only 2 doors

select * from VehicleDetails
where VehicleDetails.Engine_Liter_Display > 3 ANd VehicleDetails.NumDoors = 2;

-- Problem 25: Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4

select Makes.Make , VehicleDetails.*
from VehicleDetails
         inner join Makes on VehicleDetails.MakeID = Makes.MakeID
where VehicleDetails.Engine Like '%OHV%' ANd VehicleDetails.Engine_Cylinders = 4;

-- Problem 26: Get all vehicles that their body is 'Sport Utility' and Year > 2020

select  Bodies.BodyName, VehicleDetails.*
from VehicleDetails
        inner join Bodies on VehicleDetails.BodyID = Bodies.BodyID

where BodyName = 'Sport Utility' and VehicleDetails.Year > 2020

-- Problem 27: Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'

select  BodyName, VehicleDetails.*
from VehicleDetails
        inner join Bodies on VehicleDetails.BodyID = Bodies.BodyID

where BodyName in ('Coupe','Hatchback','Sedan')

-- Problem 28: Get all vehicles that their body is 'Coupe' or 'Hatchback' or 'Sedan' and manufactured in year 2008 or 2020 or 2021

select  BodyName, VehicleDetails.*
from VehicleDetails
        inner join Bodies on VehicleDetails.BodyID = Bodies.BodyID

where BodyName in ('Coupe','Hatchback','Sedan') and Year in (2008,2020,2021)

-- Problem 29: Return found=1 if there is any vehicle made in year 1950

select found = 1
where 
exists (
	select top 1 * from VehicleDetails where Year = 1950
)
-- other solution

SELECT CASE 
         WHEN EXISTS (SELECT 1 FROM VehicleDetails WHERE Year = 13950) 
         THEN 1 
         ELSE 0 
       END AS found;

-- Problem 30: Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words, 
-- and if door is null display 'Not Set'

select VehicleDetails.Vehicle_Display_Name , NumDoors ,
CASE
    When NumDoors =	0 then 'Zero Doors'
    When NumDoors =	2 then 'Tow Doors'
    When NumDoors =	3 then 'Three Doors'
    When NumDoors =	4 then 'Four Doors'
    When NumDoors =	5 then 'Five Doors'
    When NumDoors =	6 then 'Six Doors'
    When NumDoors =	8 then 'Eight Doors'
    When NumDoors is NULL then 'Not Set'
	Else 'Unknown'
End as DootDescription
from VehicleDetails

-- Problem 31: Get all Vehicle_Display_Name, year and add extra column to calculate the age of the car then sort the results by age desc.

select Vehicle_Display_Name, Year , Age = YEAR(getdate()) - VehicleDetails.Year
from VehicleDetails
order by age desc

-- Problem 32: Get all Vehicle_Display_Name, year, Age for vehicles that their age between 15 and 25 years old

select Vehicle_Display_Name, Year , Age = YEAR(getdate()) - VehicleDetails.Year
from VehicleDetails
where YEAR(getdate()) - VehicleDetails.Year between 15 and 25

-- Other solution

select * from(
select Vehicle_Display_Name, Year , Age = YEAR(getdate()) - VehicleDetails.Year
from VehicleDetails) R1
where Age between 15 and 25

-- Problem 33: Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles

select Min(Engine_CC) as MinimimEngineCC , max(Engine_CC) as MaximumEngineCC, avg(Engine_CC) as AverageEngineCC
from VehicleDetails;

-- Problem 34: Get all vehicles that have the minimum Engine_CC

select * from VehicleDetails
where Engine_CC = (select Min(Engine_CC) from VehicleDetails)

-- Problem 35: Get all vehicles that have the Maximum Engine_CC

select * from VehicleDetails
where Engine_CC = (select MAX(Engine_CC) from VehicleDetails)

-- Problem 36: Get all vehicles that have Engin_CC below average

select * from VehicleDetails
where Engine_CC < (select AVG(Engine_CC) from VehicleDetails)

-- Problem 37: Get total vehicles that have Engin_CC above average

select count(*) as NumberOfVehiclesAboveAverageEngineCC   from (
select * from VehicleDetails
where Engine_CC > (select AVG(Engine_CC) from VehicleDetails)
) R1 

-- Problem 38: Get all unique Engin_CC and sort them Desc

select distinct Engine_CC from VehicleDetails
order by Engine_CC desc

-- Problem 39: Get the maximum 3 Engine CC

select distinct top 3  Engine_CC from VehicleDetails
order by Engine_CC desc

-- Problem 40: Get all vehicles that has one of the Max 3 Engine CC

select Vehicle_Display_Name from VehicleDetails 
where Engine_CC in 
(
       select distinct top 3  Engine_CC from VehicleDetails
       order by Engine_CC desc
)

-- Problem 41: Get all Makes that manufactures one of the Max 3 Engine CC

select distinct  Makes.Make 

from VehicleDetails
         inner join Makes on VehicleDetails.MakeID = Makes.MakeID

where Engine_CC in 
(
       select distinct top 3  Engine_CC from VehicleDetails
       order by Engine_CC desc
)
order by Make

-- Problem 42: Get a table of unique Engine_CC and calculate tax per Engine CC as follows:
	-- 0 to 1000    Tax = 100
	-- 1001 to 2000 Tax = 200
	-- 2001 to 4000 Tax = 300
	-- 4001 to 6000 Tax = 400
	-- 6001 to 8000 Tax = 500
	-- Above 8000   Tax = 600
	-- Otherwise    Tax = 0

select Engine_CC ,  
  Case
      when Engine_CC between 0 and 1000 then 100
      when Engine_CC between 1001  and 2000 then 200
      when Engine_CC between 2001 and 4000 then 300
      when Engine_CC between 4001 and 6000 then 400
      when Engine_CC between 6001 and 8000 then 500
	  else 0
	END as Tax
from (
     select distinct Engine_CC from VehicleDetails
) R1
order by Engine_CC

-- Problem 43: Get Make and Total Number Of Doors Manufactured Per Make

select Makes.Make,  Sum(VehicleDetails.NumDoors) AS TotalNumberOfDoors
from VehicleDetails 
        inner join Makes on Makes.MakeID = VehicleDetails.MakeID

group by Makes.Make
Order By TotalNumberOfDoors desc

-- Problem 44: Get Total Number Of Doors Manufactured by 'Ford'

select Makes.Make,  Sum(VehicleDetails.NumDoors) AS TotalNumberOfDoors
from VehicleDetails 
        inner join Makes on Makes.MakeID = VehicleDetails.MakeID

group by Makes.Make
having Make = 'Ford'