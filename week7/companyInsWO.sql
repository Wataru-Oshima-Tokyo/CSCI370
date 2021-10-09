/*	COMPANY Inserts for WORKS_ON only 
	script for  CSCI 370 Labs
	rrenner 10-06-20 
        -used for Week#7,8 labs, testing Ex.6.10 and CHECK_CONSTRAINT_CHECK feature

*/

INSERT IGNORE INTO WORKS_ON VALUES -- notice that IGNORE allows statement to continue when error encountered.

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
('888665555',20,NULL);  -- this is the culprit entry, IGNORE will allow entry, with default (0) value



# end
