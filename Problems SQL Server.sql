-- Problem 3 : Get number vehicles made between 1950 and 2000
select count(*) as NumberOfVehicles from VehicleDetails
where   Year between 1950 and 2000 

-- Problem 4 : Get number vehicles made between 1950 and 2000 per make and order them by Number Of Vehicles Descending

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