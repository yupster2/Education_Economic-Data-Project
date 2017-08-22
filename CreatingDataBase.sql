-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema groupproject
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema groupproject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS groupproject DEFAULT CHARACTER SET latin1 ;
USE groupproject;
SELECT 
    *
FROM
    earning_by_education_flat_columns;

-- -----------------------------------------------------
-- Table groupproject.earning_by_education_flat_columns
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS groupproject.earning_by_education_flat_columns (
    Geo_ID VARCHAR(25) NULL DEFAULT NULL,
    Geography VARCHAR(255) NULL DEFAULT NULL,
    Total_Estimate INT(11) NULL DEFAULT NULL,
    Estimate_LT_High_School INT(11) NULL DEFAULT NULL,
    HighSchool_Estimate INT(11) NULL DEFAULT NULL,
    Estimate_Some_College INT(11) NULL DEFAULT NULL,
    Estimate_Bachelor INT(11) NULL DEFAULT NULL,
    Estimate_Graduate_Degree INT(11) NULL DEFAULT NULL,
    Estimate_Male INT(11) NULL DEFAULT NULL,
    Estimate_Male_LT_High_School INT(11) NULL DEFAULT NULL,
    Estimate_Male_HighSchool INT(11) NULL DEFAULT NULL,
    Estimate_Male_Some_College INT(11) NULL DEFAULT NULL,
    Estimate_Male_Bachelor INT(11) NULL DEFAULT NULL,
    Estimate_Male_Graduate_Degree INT(11) NULL DEFAULT NULL,
    Estimate_Female INT(11) NULL DEFAULT NULL,
    Estimate_Female_LT_High_School INT(11) NULL DEFAULT NULL,
    Estimate_Female_High_School INT(11) NULL DEFAULT NULL,
    Estimate_Female_Some_College INT(11) NULL DEFAULT NULL,
    Estimate_Female_Bachelor INT(11) NULL DEFAULT NULL,
    Estimate_Female_Graduate_Degree INT(11) NULL DEFAULT NULL,
    state_id VARCHAR(2) NULL DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


UPDATE earning_by_education_flat_columns 
SET 
    state_id = SUBSTRING(Geo_ID, 8, 2);



-- -----------------------------------------------------
-- Table groupproject.states
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS groupproject.states (
    StateID VARCHAR(2) NOT NULL,
    State VARCHAR(45) NOT NULL,
    PRIMARY KEY (StateID),
    INDEX StateID (StateID ASC)
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;



insert into states
  (stateID, state)
  select substring(Geo_ID,8,2), right(Geography,2)
        from earning_by_education_flat_columns
        group by substring(Geo_ID,8,2), right(Geography,2);

UPDATE states 
SET 
    StateID = '00',
    State = 'US'
WHERE
    State = 'es';

-- -----------------------------------------------------
-- Table groupproject.schooldistricts
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS groupproject.schooldistricts (
    DistrictID VARCHAR(10) NOT NULL,
    SchoolDistrict VARCHAR(500) NOT NULL,
    StateID VARCHAR(2) NULL,
    PRIMARY KEY (DistrictID),
    INDEX DistrictID (DistrictID ASC),
    INDEX StateID_idx (StateID ASC),
    CONSTRAINT StateID FOREIGN KEY (StateID)
        REFERENCES groupproject.states (StateID)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=LATIN1;


INSERT INTO groupproject.schooldistricts
(DistrictID,
SchoolDistrict,
StateID)


  select substring(Geo_ID,8,length(Geo_ID)),
		 substring(Geography,1,length(Geography)-4),
		 substring(Geo_ID,8,2)
 from earning_by_education_flat_columns
      group by substring(Geo_ID,8,length(Geo_ID)),
         substring(Geography,1,length(Geography)-4),
         substring(Geo_ID,8,2);

UPDATE schooldistricts
set DistrictID = '00',
SchoolDistrict = 'United States', StateID = '00'
where SchoolDistrict= 'United St';

-- -----------------------------------------------------
-- Table groupproject.Gender
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS groupproject.Gender (
    GenderID VARCHAR(2) NOT NULL,
    Gender VARCHAR(6) NULL,
    PRIMARY KEY (GenderID),
    INDEX GenderID (GenderID ASC)
)  ENGINE=INNODB;

INSERT INTO groupproject.gender
(GenderID,
Gender)
VALUES
('00', 'MandF'),
('01', 'Male'),
('02', 'Female');

-- -----------------------------------------------------
-- Table groupproject.Education
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS groupproject.Education (
    EducationID VARCHAR(2) NOT NULL,
    EducationDefined VARCHAR(45) NULL,
    PRIMARY KEY (EducationID)
)  ENGINE=INNODB;

INSERT INTO groupproject.education
(EducationID,
EducationDefined)
values
 ('00', 'All Education Levels'),
 ('01', 'Estimate_LT_High_School'),
 ('02','HighSchool_Estimate'), 
 ('03','Estimate_Some_College'), 
 ('04','Estimate_Bachelor'), 
 ('05','Estimate_Graduate_Degree');

-- -----------------------------------------------------
-- Table groupproject.Salaries
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS groupproject.Salaries (
    salaryID MEDIUMINT NOT NULL AUTO_INCREMENT,
    GenderID varchar(5) NULL,
    EducationID varchar(2) NULL,
    DistrictID VARCHAR(10) NULL,
    salary FLOAT NULL,
    PRIMARY KEY (salaryID),
    INDEX DistrictID_idx (DistrictID ASC),
    INDEX GenderEducationID_idx (EducationID ASC),
 CONSTRAINT GenderID FOREIGN KEY (GenderID)
        REFERENCES groupproject.gender (GenderID)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT DistrictID FOREIGN KEY (DistrictID)
        REFERENCES groupproject.schooldistricts (DistrictID)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT EducationID FOREIGN KEY (EducationID)
        REFERENCES groupproject.Education (EducationID)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;




INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select	
'00','00',substring(Geo_ID,8,length(Geo_ID)),Total_Estimate
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select '00','01',substring(Geo_ID,8,length(Geo_ID)),Estimate_LT_High_School
from earning_by_education_flat_columns;


INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select '00','02',substring(Geo_ID,8,length(Geo_ID)),HighSchool_Estimate
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'00','03',substring(Geo_ID,8,length(Geo_ID)),Estimate_Some_College
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'00','04',substring(Geo_ID,8,length(Geo_ID)),Estimate_Bachelor
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select '00','05',substring(Geo_ID,8,length(Geo_ID)),Estimate_Graduate_Degree
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select '01','00',substring(Geo_ID,8,length(Geo_ID)),Estimate_Male
from earning_by_education_flat_columns;


INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select '01','01',substring(Geo_ID,8,length(Geo_ID)),Estimate_Male_LT_High_School
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select '01','02',substring(Geo_ID,8,length(Geo_ID)),Estimate_Male_HighSchool
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'01','03',substring(Geo_ID,8,length(Geo_ID)),Estimate_Male_Some_College
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'01','04',substring(Geo_ID,8,length(Geo_ID)),Estimate_Male_Bachelor
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'01','05',substring(Geo_ID,8,length(Geo_ID)),Estimate_Male_Graduate_Degree
from earning_by_education_flat_columns;


INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'02','00',substring(Geo_ID,8,length(Geo_ID)),Estimate_Female
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select '02','01',substring(Geo_ID,8,length(Geo_ID)),Estimate_Female_LT_High_School
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'02','02',substring(Geo_ID,8,length(Geo_ID)),Estimate_Female_High_School
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'02','03',substring(Geo_ID,8,length(Geo_ID)),Estimate_Female_Some_College
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'02','04',substring(Geo_ID,8,length(Geo_ID)),Estimate_Female_Bachelor
from earning_by_education_flat_columns;

INSERT INTO groupproject.salaries
(GenderID,
EducationID,
DistrictID,
salary)
select'02','05',substring(Geo_ID,8,length(Geo_ID)),Estimate_Female_Graduate_Degree
from earning_by_education_flat_columns;



/*
Select 
 substring(Geo_ID,8,length(Geo_ID)) -- DISTRICT ID


('01', 'Male'), -- GENDER ID
('02', 'Female');

select * from earning_by_education_flat_columns

 ('00', 'All Education Levels'),
 ('01', 'Estimate_LT_High_School'), -- EDUCATION ID
 ('02','HighSchool_Estimate'), 
 ('03','Estimate_Some_College'), 
 ('04','Estimate_Bachelor'), 
 ('05','Estimate_Graduate_Degree')
*/
,
Estimate_LT_High_School,
HighSchool_Estimate,
Estimate_Some_College,
Estimate_Bachelor,
Estimate_Graduate_Degree,
Estimate_Male,
Estimate_Male_LT_High_School,
Estimate_Male_HighSchool,
Estimate_Male_Some_College,
Estimate_Male_Bachelor,
Estimate_Male_Graduate_Degree,
Estimate_Female,
Estimate_Female_LT_High_School,
Estimate_Female_High_School,
Estimate_Female_Some_College,
Estimate_Female_Bachelor,
Estimate_Female_Graduate_Degree,
state_id
FROM earning_by_education_flat_columns;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
