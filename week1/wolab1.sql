USE woshima;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS series;

CREATE TABLE books (
isbn CHAR(20) PRIMARY KEY, 
title VARCHAR(50),
author_id INT,
publisher_id INT,
year_pub CHAR(4),
description TEXT );

CREATE TABLE authors
(author_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name_last VARCHAR(50),
name_first VARCHAR(50),
country VARCHAR(50) );


DESCRIBE books;

INSERT INTO authors
(name_last, name_first, country)
VALUES('Kafka', 'Franz', 'Czech Republic');

INSERT INTO books
(title, author_id, isbn, year_pub)
VALUES('The Castle', '1', '0805211063', '1998');

SELECT title 
FROM books;

SELECT title 
FROM books
LIMIT 5;

SELECT title, name_last 
FROM books 
JOIN authors USING (author_id);

SELECT title AS 'Kafka Books'
FROM books 
JOIN authors USING (author_id)
WHERE name_last = 'Kafka';

UPDATE books
SET title = 'Amerika'
WHERE isbn = '0805210644';

DELETE FROM books
WHERE author_id = '2034';
