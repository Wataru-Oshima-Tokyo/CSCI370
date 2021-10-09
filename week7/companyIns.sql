/*	COMPANY Inserts 
	script for  CSCI 370 Lab
	rrenner 10-11-17
        IMPLEMENTS Figure 5.6 
        -used for Ch.7 exercises (Lab#7, Sp20)
*/

/* Turn Foreign key constraint checking off temporarily, to avoid referential circularity lockout */
SET FOREIGN_KEY_CHECKS=0;

DELETE FROM EMPLOYEE;
DELETE FROM DEPARTMENT;
DELETE FROM PROJECT; 
DELETE FROM DEPT_LOCATIONS;
DELETE FROM WORKS_ON;
DELETE FROM DEPENDENT;

INSERT INTO EMPLOYEE VALUES
('John','B','Smith','123456789','1965-01-09','731 Fondren, Houston, TX','M',30000,'333445555',5),
('Franklin','T','Wong','333445555','1955-12-08','638 Voss, Houston, TX','M',40000,'888665555',5),
('Alicia','J','Zelaya','999887777','1968-01-19','3321 Castle, Spring, TX','F',25000,'987654321',4),
('Jennifer','S','Wallace','987654321','1941-06-20','291 Berry, Bellaire, TX','F',43000,'888665555',4),
('Ramesh','K','Narayan','666884444','1962-09-15','975 Fire Oak, Humble, TX','M',38000,'333445555',5),
('Joyce','A','Eglish','453453453','1972-07-31','5631 Rice, Houston, TX','F',25000,'333445555',5),
('Ahmad','V','Jabbar','987987987','1969-03-29','980 Dallas, Houston, TX','M',25000,'987654321',4),
('James','E','Borg','888665555','1937-11-10','450 Stone, Houston, TX','M',55000,NULL,1);

INSERT INTO  DEPARTMENT VALUES
('Research',5,'333445555','1988-05-22'),
('Administration',4,'987654321','1995-01-01'),
('Headquarters',1,'888665555','1981-06-19');

INSERT INTO PROJECT VALUES
('ProductX',1,'Bellaire',5),
('ProductY',2,'Sugarland',5),
('ProductZ',3,'Houston',5),
('Computerization',10,'Stafford',4),
('Reorganization',20,'Houston',1),
('Newbenefits',30,'Stafford',4);

/* Turn Foreign key constraint checking back on */
SET FOREIGN_KEY_CHECKS=1;

/* COMPLETE INSERTS FOR TABLES:  DEPT_LOCATIONS, WORKS_ON, and DEPENDENT */

INSERT INTO DEPT_LOCATIONS VALUES
(1,'Houston'),
(4,'Stafford'),
(5,'Bellaire'),
(5,'Sugarland'),
(5,'Houston');

INSERT INTO WORKS_ON VALUES
('123456789',1,32.5),
('123456789',2,7.5),
('666884444',3,40.0),
('453453453',1,20.0),
('453453453',2,20),
('333445555',2,10),
('333445555',3,10),
('333445555',10,10),
('333445555',20,10),
('999887777',30,30),
('999887777',10,10),
('987987987',10,35),
('987987987',30,5),
('987654321',30,20),
('987654321',20,15),
('888665555',20,NULL);

INSERT INTO DEPENDENT VALUES
('333445555','Alice','F','1986-04-05','Daughter'),
('333445555','Theodore','M','1983-10-25','Son'),
('333445555','Joy','F','1958-05-03','Spouse'),
('987654321','Abner','M','1942-02-28','Spouse'),
('123456789','Michael','M','1988-01-04','Son'),
('123456789','Alice','F','1988-12-30','Daughter'),
('123456789','Elizabeth','F','1967-05-05','Spouse');


