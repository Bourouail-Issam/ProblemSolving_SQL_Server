restore database VehicleMakesDB
from disk = 'B:\BackUP\VehicleMakesDB.bak'

-- Explain Schema

select * from Bodies;
select * from DriveTypes;
select * from FuelTypes;
select * from MakeModels;
select * from Makes;
select * from SubModels;
select * from VehicleDetails;


-- Resolve problem Digram 
EXEC sp_changedbowner 'sa';