-- ----------------------------------------------------------
-- DATA DEFINITION LANGUAGE (DDL) STATEMENTS
-- ----------------------------------------------------------

-- you can use SQL to define databases and tables
-- SQL is very rigid, it requires users to define the structure of databases and tables before they can be used
-- this way, it can ensure that all rows maintained in the database will follow the defined structure
-- you have to remember that SQL databases where originally designed to inventory things, therefore it required 
-- all rows to obey the table structure. not standard things can not be inventoried! 
-- hence the meaning behind "structured query language (SQL)" or "structured data". 
-- later on you'll learn newer big data and cloud databases which gave way to "unstrctured databases" 

-- let's create a new database called lego2
CREATE DATABASE lego2;

-- now let's use that database
use lego2;

-- ----------------------------------------------------------
-- CREATE TABLE
-- ----------------------------------------------------------

-- now let's replicate our colors table
CREATE TABLE `colors` (
  `id` varchar(256) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `rgb` varchar(256) DEFAULT NULL,
  `is_trans` bool DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- there's a lot to unpack here:
--      1- the ` character is used to escape names, this is not conflict with keywords. this is not standard SQL, other database use other characters to escape names
--      2- columns are defined by individual lines separated by commas
--      3- `id` varchar(256) NOT NULL refer to <column name> <data type> <column constraints>
--          in this case, data type is varchar(256) which means a string with maximum length of 256 characters
--          and column value can not be NULL (or empty)
--          other columns set the default value to NULL, which is the default value if column value is not specified by the insert statement
--      4- PRIMARY KEY (`id`) tell the database that column `id` must be used as a primary key for this table
--          this means that no 2 rows can ever have the same id (this is good!). If a user tried to insert multiple rows with the same (or existing) id it will fail
--          tables do not have to have a primary key, but it's a very good practice to include them

-- ** note: every database has a slightly different CREATE TABLE syntax. unfortunately you have to read their documentation to get the know the database capabilities
--          mariadb CREATE TABLE: https://mariadb.com/kb/en/create-table/ 
--          or a better source: https://www.mariadbtutorial.com/mariadb-basics/mariadb-create-table/


-- now lets list of the tables and see what we did
show tables;
describe colors;

-- insert a new row into the table and query it
INSERT INTO colors (id, name, rgb, is_trans) VALUES (301, 'Pastel Green', '77dd77', 0);
SELECT * FROM colors;

-- you can also inspect the CREATE TABLE statement for any existing tables
SHOW CREATE TABLE colors;

-- let's do more practice
CREATE TABLE `sets` (
  `set_num` varchar(256) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `theme_id` varchar(256) DEFAULT NULL,
  `num_parts` int(11) DEFAULT NULL,
  PRIMARY KEY (`set_num`)
);

CREATE TABLE `themes` (
  `id` varchar(256) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ----------------------------------------------------------
-- DROP TABLE
-- ----------------------------------------------------------

-- to drop a table use DROP
-- be very careful, all the data in the table is forever lost!
DROP TABLE colors;

-- syntax is simple
-- DROP TABLE <table name>

-- colors table is no longer listed
show tables;

-- there's a better syntax
-- with this syntax the statement does not fail if the table doesn't exists
DROP TABLE IF EXISTS colors;


-- ----------------------------------------------------------
-- ADVANCED CREATE TABLE with LIKE and SELECT
-- ----------------------------------------------------------

-- you can create a table that's just like another table
use lego2;

-- this will create a table called colors in lego2 which is same as lego.colors tables
-- note that you can use the database name in front of the table name
CREATE TABLE lego2.colors LIKE lego.colors;

-- there also a better syntax which doesn't fail if the table already exists:
CREATE TABLE IF NOT EXISTS lego2.colors LIKE lego.colors;

-- inspect your new table
describe lego2.colors;
show create table lego2.colors;


-- you can also create table and insert data to it from another existing table
-- first drop any existing one
DROP TABLE IF EXISTS colors;
-- now let's create a color table and insert rows to it at the same time!
CREATE TABLE lego2.colors AS (SELECT id, name, rgb FROM lego.colors WHERE id < 50);

-- note: that we only selected 3 columns out of lego.colors and limited to only ids less than 50
-- note: table constrains like primary keys do NOT get carried over with this statement while they do using CREATE LIKE 
-- pretty neat!!

describe colors;
SELECT * FROM lego2.colors;
