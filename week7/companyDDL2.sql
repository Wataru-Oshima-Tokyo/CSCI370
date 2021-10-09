/*	COMPANY DDL Database creation 
	script for  CSCI 370 Lab
	rrenner 10-11-17
*/
use woshima;
/* Must DROP these (cross-ref) Foreign Keys to avoid 'delete parent' conflict during table creations */
ALTER TABLE EMPLOYEE 
	DROP FOREIGN KEY FK_Emp2Emp;
ALTER TABLE EMPLOYEE 
	DROP FOREIGN KEY FK_Emp2Dept;
ALTER TABLE DEPARTMENT 
	DROP FOREIGN KEY FK_Dept2Emp;

/* Must DROP tables in reverse order of create, to avoid 'delete parent' conflicts from FK constraints */
DROP TABLE IF EXISTS DEPENDENT;
DROP TABLE IF EXISTS WORKS_ON;
DROP TABLE IF EXISTS PROJECT;
DROP TABLE IF EXISTS DEPT_LOCATIONS;
DROP TABLE IF EXISTS DEPARTMENT;
DROP TABLE IF EXISTS EMPLOYEE;


/* Must CREATE tables in hierarchical order, parent tables before child tables (FK constraints) */

CREATE TABLE EMPLOYEE (
Fname 		VARCHAR(15) 	NOT NULL	,
Minit 		CHAR				,
Lname 		VARCHAR(15) 	NOT NULL	,
Ssn 		CHAR(9) 	NOT NULL	,
Bdate		DATE				,
Address		VARCHAR(30)			,
Sex		CHAR				,
Salary		DECIMAL(10,2)			,
Super_ssn	CHAR(9)				,
Dno		INT				,
PRIMARY KEY(Ssn)				);

CREATE TABLE DEPARTMENT (
Dname 		VARCHAR(15) 	NOT NULL	,
Dnumber 	INT 		NOT NULL	,
Mgr_ssn		CHAR(9)				,
Mgr_start_date	DATE				,
UNIQUE(Dname)					,
PRIMARY KEY(Dnumber)				,
CONSTRAINT FK_Dept2Emp FOREIGN KEY(Mgr_ssn) REFERENCES EMPLOYEE(Ssn) ON DELETE SET NULL);

CREATE TABLE DEPT_LOCATIONS (
Dnumber 	INT		NOT NULL 	,
Dlocation 	VARCHAR(15)	NOT NULL	,
PRIMARY KEY(Dnumber,Dlocation)			,
CONSTRAINT FK_DeptLocations2Dept FOREIGN KEY(Dnumber) REFERENCES DEPARTMENT(Dnumber) ON DELETE CASCADE);


CREATE TABLE PROJECT (
Pname		VARCHAR(15)	NOT NULL	,
Pnumber 	INT		NOT NULL	,
Plocation	VARCHAR(15)			,
Dnum 		INT		NOT NULL	,
PRIMARY KEY(Pnumber)				,
UNIQUE(Pname)					,
CONSTRAINT FK_Projects2Dept FOREIGN KEY(Dnum) REFERENCES DEPARTMENT(Dnumber) ON DELETE RESTRICT);

CREATE TABLE WORKS_ON (
Essn 		CHAR(9)		NOT NULL	,
Pno 		INT		NOT NULL	,
Hours		DECIMAL(3,1)	NOT NULL	,
PRIMARY KEY(Essn, Pno)				,
CONSTRAINT FK_WorksOn2Emp FOREIGN KEY(Essn) REFERENCES EMPLOYEE(Ssn) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK_WorksOn2Project FOREIGN KEY(Pno) REFERENCES PROJECT(Pnumber) ON DELETE CASCADE);

CREATE TABLE DEPENDENT (
Essn 		CHAR(9)		NOT NULL	,
Dependent_name 	VARCHAR(15)	NOT NULL	,
Sex		CHAR				,
Bdate		DATE				,
Relationship	VARCHAR(8)			,
PRIMARY KEY(Essn, Dependent_name)		,
CONSTRAINT FK_Dependent2Emp FOREIGN KEY(Essn) REFERENCES EMPLOYEE(Ssn) ON DELETE CASCADE ON UPDATE CASCADE);

/* Must ADD FK Constraints last, for root parent table & self-referencing table FK */
ALTER TABLE EMPLOYEE
	ADD CONSTRAINT FK_Emp2Emp FOREIGN KEY(Super_ssn) REFERENCES EMPLOYEE(Ssn);

ALTER TABLE EMPLOYEE
	ADD CONSTRAINT FK_Emp2Dept FOREIGN KEY(Dno) REFERENCES DEPARTMENT(Dnumber);   

