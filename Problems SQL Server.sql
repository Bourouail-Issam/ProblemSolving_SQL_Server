--   Problem 3 : Get number vehicles made between 1950 and 2000
select count(*) as NumberOfVehicles from VehicleDetails
where   Year between 1950 and 2000 