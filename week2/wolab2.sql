# wolab2.sql by Watru Oshima
# last modified on 9-8-21
# CINS 370 - lab#2


# AUTHORS - all authors & their country of origin
USE woshima;
DROP TABLE IF EXISTS authors;
CREATE TABLE authors
(author_id int AUTO_INCREMENT,
author_last varchar(50),
name_first varchar(50),
country varchar(50),
PRIMARY KEY (author_id));

# BOOKS - a book title may exist multiple times, each with its own unique isbn, 
# but with a common Original Publication Year (orig)
DROP TABLE IF EXISTS books;
CREATE TABLE books (
isbn char(20) UNIQUE NOT NULL, # of the original publication
title varchar(50) NOT NULL,
author_id int NOT NULL REFERENCES authors(author_id),
orig char(4),			# the original publication year
description text,
PRIMARY KEY (isbn));

# PUBLISHERS - all publishers by name
DROP TABLE IF EXISTS publishers;
CREATE TABLE publishers
(pid int AUTO_INCREMENT,	# publisher ID
pname varchar(50) NOT NULL,
PRIMARY KEY (pid));

# PUBLICATIONS - a book/text may have multiple publications, 
# each with its own isbn and publication year
DROP TABLE IF EXISTS publications;
CREATE TABLE publications
(isbn char(20) UNIQUE NOT NULL, # unique to each publication 
pub_id int NOT NULL REFERENCES publishers(pid),	# publisher ID
pub_yr char(4),			# year of this particular publication of the title
PRIMARY KEY (isbn));

###########################
# POPULATE the database
###########################
INSERT INTO authors (author_last, name_first, country)
VALUES('Kafka','Franz','Czech Republic'),
	('Dostoevsky','Fyodor','Russian');

INSERT INTO books (title, author_id, isbn, orig)
VALUES('The Castle', '1', '0805211063','1926'),
	('Brothers Karamozov','2','0553212168','1880'),
	('Crime & Punishment','2','0679420290','1866'),
	('Crime & Punishment','2','0553211757','1866'),
	('Idiot','2','0192834118','1869'),
	('Notes from Underground','2','067973452X','1918');

INSERT INTO books (title, author_id, isbn, orig)
VALUES('The Trial','1','0805210407', '1925'),
('The Metamorphosis', '1', '0553213695','1915'),
('Amerika', '1','0805210644','1927');

INSERT INTO publications (isbn, pub_id, pub_yr)
VALUES('0192834118', '1', '1998'),
	('0553211757','2','1984'),
	('0553212168','2','1984'),
	('0553213695','2','1972'),
	('0679420290','3','1993'),
	('067973452X','4','1993'),
	('0805210407','5','1956'),
	('0805210644','5','1996'),
	('0805211063','5','1998');
 
INSERT INTO publishers (pname)
VALUES('Oxford University Press'),
('Bantam Classics'),
('Everyman\'s Library'),
('Vintage'),
('Schocken');



-- select '3. Retrieve the publisher ID and publisher name for all publishers.' as '';
select pid, pname from publishers;

-- select '4. Retrieve the isbn, publisher ID, and publication year for all publications.' as '';
select isbn, pub_id, pub_yr from publications;

-- select '5. Retrieve the last name of all authors, along with their country of origin. ' as '';
select author_last, country from authors;

-- select '6. Retrieve the set of all unique book titles, along with the author''s last name and country.[hint: join using]' as '';
select title, author_last, country from books join authors using (author_id);

-- select '7. Retrieve the publisher name and isbn for all publications. [hint: join on]' as '';
select pname, isbn from publishers join publications on publishers.pid = publications.pub_id;

-- select  '8. Retrieve the author''s full name, isbn, and title for all books titled The Castle. [hint: join where]' as '';
select name_first, author_last, isbn, title from authors join books using (author_id) where books.title = "The Castle" ;

--  select '9. Retrieve the title and isbn for all instances of Crime & Punishment, ordered by isbn. Use
-- SQL pattern matching to capture variations on spelling and spacing of the and/& in the
-- title. [hint: like %]' as '';
select title, isbn from books where title like '%&%' order by isbn;

--  select '10. Retrieve the unique book titles and original publication year for all of Dostoevsky''s
-- works. Display by the original publication year, in descending order. Use pattern
-- matching to capture alternative spellings (Dostoevski, Dostoevskii, Dostoyevsky).
-- [hint 1: only be concerned with the original work, not all subsequent publications -
-- requires join of only 2 relations; hint 2: while capturing alternatives, be careful not to be
-- to free, as to avoid inclusion of other potential authors, such as Dost]' as '';
select distinct title, orig from books join authors using (author_id) where author_last like 'Dostoev%' order by orig DESC;
