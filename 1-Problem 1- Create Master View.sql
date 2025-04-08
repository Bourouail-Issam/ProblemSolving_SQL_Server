-- create view about sql server
SELECT dbo.VehicleDetails.ID,
       dbo.VehicleDetails.MakeID, 
	   dbo.Makes.Make, 
	   dbo.VehicleDetails.ModelID, 
	   dbo.MakeModels.ModelName, 
	   dbo.VehicleDetails.SubModelID, 
	   dbo.SubModels.SubModelName, 
	   dbo.VehicleDetails.BodyID, 
       dbo.Bodies.BodyName, 
	   dbo.VehicleDetails.Vehicle_Display_Name, 
	   dbo.VehicleDetails.Year,
	   dbo.VehicleDetails.DriveTypeID, 
	   dbo.DriveTypes.DriveTypeName, 
	   dbo.VehicleDetails.Engine, 
	   dbo.VehicleDetails.Engine_CC, 
       dbo.VehicleDetails.Engine_Cylinders, 
	   dbo.VehicleDetails.Engine_Liter_Display, 
	   dbo.VehicleDetails.FuelTypeID, 
	   dbo.FuelTypes.FuelTypeName, 
	   dbo.VehicleDetails.NumDoors

FROM     dbo.FuelTypes 
INNER JOIN dbo.Bodies 
INNER JOIN dbo.Makes
INNER JOIN dbo.MakeModels ON dbo.Makes.MakeID = dbo.MakeModels.MakeID 
INNER JOIN dbo.SubModels ON dbo.MakeModels.ModelID = dbo.SubModels.ModelID 
INNER JOIN dbo.VehicleDetails 
ON dbo.Makes.MakeID = dbo.VehicleDetails.MakeID AND dbo.MakeModels.ModelID = dbo.VehicleDetails.ModelID AND dbo.SubModels.SubModelID = dbo.VehicleDetails.SubModelID 
ON dbo.Bodies.BodyID = dbo.VehicleDetails.BodyID 
INNER JOIN dbo.DriveTypes ON dbo.VehicleDetails.DriveTypeID = dbo.DriveTypes.DriveTypeID ON dbo.FuelTypes.FuelTypeID = dbo.VehicleDetails.FuelTypeID

select * from VehicleMasterDetails;


-- Create view about CHatGPT
CREATE VIEW VehicleMasterDetails AS
SELECT 
    v.ID,
    v.MakeID,
    m.Make,
    v.ModelID,
    mm.ModelName,
    v.SubModelID,
    sm.SubModelName,
    v.BodyID,
    b.BodyName,
    v.Vehicle_Display_Name,
    v.Year,
    v.DriveTypeID,
    dt.DriveTypeName,
    v.Engine,
    v.Engine_CC,
    v.Engine_Cylinders,
    v.Engine_Liter_Display,
    v.FuelTypeID,
    ft.FuelTypeName,
    v.NumDoors

FROM VehicleDetails v

-- ربط MakeModels بشكل دقيق مع VehicleDetails وMakes
INNER JOIN Makes m ON v.MakeID = m.MakeID

INNER JOIN MakeModels mm 
    ON v.ModelID = mm.ModelID AND mm.MakeID = m.MakeID

-- ربط SubModels بشكل دقيق مع Model
INNER JOIN SubModels sm 
    ON v.SubModelID = sm.SubModelID AND sm.ModelID = mm.ModelID

-- باقي الجداول
INNER JOIN Bodies b ON v.BodyID = b.BodyID

INNER JOIN DriveTypes dt ON v.DriveTypeID = dt.DriveTypeID

INNER JOIN FuelTypes ft ON v.FuelTypeID = ft.FuelTypeID;