/* set database to correct username */
use woshima;


/***********************************
   CREATE TABLES 
/***********************************/   

/* Must DROP tables in reverse order of create, to avoid 'delete parent' conflicts from FK constraints */
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS CONGRESS_PERSON;
DROP TABLE IF EXISTS STATE;
DROP TABLE IF EXISTS BILL;
DROP TABLE IF EXISTS VOTES_ON;

CREATE TABLE CONGRESS_PERSON (
Name 		VARCHAR(15) 	NOT NULL	,
Age 		INT	            		,
Party 		VARCHAR(15) 		   ,
District 		VARCHAR(15) 		,
Start_date		DATE				   ,
Phone		CHAR(10)                     , /*it is multivalue*/
Fax		    CHAR(10)             		,
Email		VARCHAR(30)     NOT NULL,
PRIMARY KEY(Name, Email)				);

CREATE TABLE STATE (
Name      VARCHAR(10)   NOT NULL,
Num_districts   INT             ,
Abbrev    CHAR(2)               ,
Population  INT                ,
CP_name     VARCHAR(15) NOT NULL,
Region    VARCHAR(15)           , 
PRIMARY KEY(Name),
CONSTRAINT FK_State2cp FOREIGN KEY(CP_name) REFERENCES CONGRESS_PERSON(Name) ON DELETE RESTRICT
);

CREATE TABLE BILL (
Bill_name    VARCHAR(15)  NOT NULL,
Date_of_vote   DATE               ,
Passed_or_failed VARCHAR(6)          ,
Sponsor     VARCHAR(15)   NOT NULL,
PRIMARY KEY(Bill_name),
CONSTRAINT FK_Bill2cp FOREIGN KEY(Sponsor) REFERENCES CONGRESS_PERSON(Name) ON DELETE RESTRICT
);

CREATE TABLE VOTES_ON(
CP_name VARCHAR(15)  NOT NULL,
Bill_ID VARCHAR(15)  NOT NULL,
Vote    VARCHAR(6)           ,
CONSTRAINT FK_Vote2cp FOREIGN KEY(CP_name) REFERENCES CONGRESS_PERSON(Name) ON DELETE RESTRICT,
CONSTRAINT FK_Vote2Bill FOREIGN KEY(Bill_ID) REFERENCES BILL(Bill_name) ON DELETE RESTRICT
);


SET FOREIGN_KEY_CHECKS=0;
DELETE FROM CONGRESS_PERSON;
DELETE FROM STATE;
DELETE FROM BILL;

INSERT INTO CONGRESS_PERSON VALUES
('abcd', 50, 'Republican', '1', '1999-01-20', '5129120984', '1231459801', 'abcd@abc.com'),
('bcde', 53, 'Democrat', '3', '1997-02-10', '1123120489', '2314598012', 'bcde@abc.com'),
('cdef', 80, 'Republican', '5', '1980-06-28', '3127910683', '1031469904', 'cdef@abc.com'),
('defg', 72, 'Democrat', '17', '1986-02-28', '1127130672', '1351974202', 'defg@abc.com'),
('efgh', 57, 'Republican', '4', '1995-01-20', '4175130786', '2241569703', 'efgh@abc.com');

INSERT INTO STATE VALUES
('California', 40, 'CA', 1800000, 'abcd', 'West'),
('Oregon', 30, 'OR', 1000000, 'bcde', 'West'),
('Texas', 31, 'TX', 2000000, 'cdef', 'Southwest'),
('Nebraska', 49, 'NE', 1750000, 'defg', 'Midwest'),
('Florida', 40, 'FL', 500000, 'efgh', 'Southwest');

INSERT INTO VOTES_ON VALUES
('abcd', 000001, 'Yes'),
('cdef', 000002, 'No'),
('abcd', 000002, 'Yes'),
('efgh', 000010, 'Yes'),
('defg', 999999, 'No');

INSERT INTO BILL VALUES
('1st Bill', '2019-02-25', 'PASSED', 'abcd'),
('2nd Bill', '2020-01-01', 'PASSED', 'bcde'),
('3rd Bill', '2020-09-20', 'FAILED', 'cdef'),
('4th Bill', '2020-12-25', 'FAILED', 'defg');
