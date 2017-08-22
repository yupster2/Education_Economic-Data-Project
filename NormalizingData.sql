use groupproject;

alter table earning_by_education_flat_columns
add state_id varchar(2);

update earning_by_education_flat_columns
set state_id = substring(Geo_ID,8,2);

CREATE TABLE `groupproject`.`states` (
  `StateID` VARCHAR(2) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `Salary` integer null,
  PRIMARY KEY (`StateID`),
  
  INDEX `StateID` (`StateID` ASC)
  );
  
insert into states
  (stateID, state)
  select substring(Geo_ID,8,2), right(Geography,2), sum(Total_Estimate)
        from earning_by_education_flat_columns
        group by substring(Geo_ID,8,2), right(Geography,2); 

Update states
set StateID = '00',
State = 'US'
where State = 'es';

 
CREATE TABLE `groupproject`.`SchoolDistricts` (
  `DistrictID` VARCHAR(10) NOT NULL,
  `SchoolDistrict` VARCHAR(500) NOT NULL,
  `Salary` integer null,
  PRIMARY KEY (`DistrictID`),
  INDEX `DistrictID` (`DistrictID` ASC)
  );

insert into SchoolDistricts
  (DistrictID, Schooldistrict,Salary)
  select substring(Geo_ID,8,length(Geo_ID)),
		 substring(Geography,1,length(Geography)-4),
		 sum(Total_Estimate)
        from earning_by_education_flat_columns
        group by substring(Geo_ID,8,length(Geo_ID)),
        substring(Geography,1,length(Geography)-4); 


state
district
gender
education level

 ('01', 'Estimate_LT_High_School'),
 ('02','HighSchool_Estimate'), 
 ('03','Estimate_Some_College'), 
 ('04','Estimate_Bachelor'), 
 ('05','Estimate_Graduate_Degree'), 
 ('06','Estimate_Male'), 
 ('07','Estimate_Male_LT_High_School'), 
 ('08','Estimate_Male_HighSchool'), 
 ('09','Estimate_Male_Some_College'), 
 ('10','Estimate_Male_Bachelor'), 
 ('11','Estimate_Male_Graduate_Degree'), 
 ('12','Estimate_Female'), 
 ('13','Estimate_Female_LT_High_School'), 
 ('14','Estimate_Female_High_School'), 
 ('15','Estimate_Female_Some_College'), 
 ('16','Estimate_Female_Bachelor'), 
 ('17','Estimate_Female_Graduate_Degree')



select substring(Geo_ID,7,length(Geo_ID))
        from earning_by_education_flat_columns
        group by substring(Geo_ID,7,length(Geo_ID))
        having count(substring(Geo_ID,7,length(Geo_ID)))>1; 

select * from schooldistricts
where schooldistrict like 'Remain%';

select 






where substring(Geo_ID,7,length(Geo_ID)) = 'S0499999'



delete from states where stateid ='  ';
select * from states

  
select distinct state_id from earning_by_education_flat_columns order by state_id;
select * from earning_by_education_flat_columns where state_id > '50'

