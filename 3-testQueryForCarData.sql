
-- Buy and Import Data
SELECT TOP (1000) [ymm_id]
      ,[Make]
      ,[Model]
      ,[Year]
      ,[Trim]
      ,[Submodel]
      ,[Body]
      ,[Cylinder_Type_Name]
      ,[Vehicle_Display_Name]
      ,[Drive_Type]
      ,[Engine]
      ,[Engine_Block_Type]
      ,[Engine_CC]
      ,[Engine_CID]
      ,[Engine_Cylinders]
      ,[Engine_Liter_Display]
      ,[Fuel_Type_Name]
      ,[Aspiration]
      ,[KBB_MODEL]
      ,[NumDoors]
      ,[Parts_Model]
      ,[Region]
  FROM [CarData].[dbo].[CarDetails]

select count(*) from CarDetails; 
  
select * from CarDetails;

select * from CarDetails
where Make ='BMW';

select count(*) from CarDetails
where Make ='BMW';

-- Extract Data to a Separate Table

create table Makes 
(
 MakeID int IDENTITY(1,1) primary key,
 MakeName nvarchar(50) not null
)
-----------------------------------
select  distinct Make from CarDetails;
-------------------------------------
select count(*) Make from CarDetails;
---------------------------------------
select  distinct Make from CarDetails
  order by Make asc;
--------------------------------------
insert into Makes 
select  distinct Make from CarDetails
order by Make asc;
---------------------------------------
select * from Makes;
SELECT        Makes.MakeName, CarDetails.*
FROM            CarDetails INNER JOIN
                         Makes ON CarDetails.MakeID = Makes.MakeID
---------------------------------------
update CarDetails
set MakeID = (select MakeID FROM Makes where CarDetails.Make = Makes.MakeName);
------------------------------------------
ALTER TABLE CarDetails
DROP COLUMN Make;

--###########################################
create table Model (
ModelID int identity(1,1) primary key,
ModelName nvarchar(30) not null
)
---------------------------------
select * from Model;
---------------------------------------
insert into Model
select distinct Model from CarDetails 
order by Model asc;
-----------------------------------------
drop table carDetails;
----------------------------------------
select * from CarDetails
where ModelID = 3335;
---------------------------------------------
update CarDetails
set ModelID = (select ModelID from Model where CarDetails.Model = Model.ModelName)
------------------------------------------------
alter table Cardetails
drop column Model;
-------------------------------------
Backup database CarData
to disk = 'B:\BackUP\CarData_Diff.bak'
WITH DIFFERENTIAL;
------------------------------------------
restore headeronly from disk = 'B:\BackUP\CarData_backup.bak'
---------------------------------------------------------
use master;
alter database CarData set SINGLE_USER
With RollBack Immediate;
drop database CarData;
--------------------------------------------