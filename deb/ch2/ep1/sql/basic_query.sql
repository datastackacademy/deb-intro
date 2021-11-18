--  ----------------------------------------------------------
-- LEARNING BASIC SQL
--  ----------------------------------------------------------

-- ** remember, code comment lines start with '--'

-- display all databases
show databases;

-- change the current working database
use lego;

-- display all tables in the current database
show tables;


-- ----------------------------------------------------------
-- USING SELECT
-- ----------------------------------------------------------

-- show all the rows in colors table
SELECT * FROM colors;

-- limit the number of rows displayed
SELECT * FROM colors LIMIT 10;

-- SQL keywords (SELECT, FROM, WHERE, ...) are caase insensitive but other things like table (and sometimes column names) are case sensitive
-- it's better practice to keep keywords in upper case
-- these two statements are the same
SELECT * FROM colors LIMIT 10;
select * from colors limit 10;

-- repeat the same to see the list of our lego sets
SELECT * FROM sets;
SELECT * FROM sets LIMIT 20;

-- HOW TO LIMIT THE QUERY COLUMNS

-- use describe to see the structure (columns) of a table
describe sets;

-- to select only a few columns, list them after your 
SELECT name, year FROM sets LIMIT 20;

SELECT year, name, set_num FROM sets LIMIT 20;

SELECT id, name, rgb FROM colors;


-- ----------------------------------------------------------
-- ORDER BY
-- ----------------------------------------------------------

-- you can sort the rows returned by the database
-- return colors sorted by name alphabetically
SELECT * FROM colors ORDER BY name;

-- you can reverse the order with DESC
-- return colors sorted by name alphabetically in descending oder (reversed)
SELECT * FROM colors ORDER BY name DESC;

-- this is useful with LIMIT
SELECT * FROM colors ORDER BY name DESC LIMIT 10;

-- you can use multiple columns in ORDER BY, which means rows are sorted by the first column, then by second, third, ...
-- sort sets by number of parts and then by name
SELECT * FROM sets ORDER BY num_parts, name;


-- ----------------------------------------------------------
-- FILTERING ROWS USING WHERE 
-- ----------------------------------------------------------

-- to filter specific rows, add a WHERE clause with your condition
SELECT * FROM sets WHERE year = 1990;

-- selecting strings (text) must be wrapped in single qoutes (')
SELECT * FROM sets WHERE name = 'Glory Glider';

-- try other values: Helicopter, Wave Racer
SELECT * FROM sets WHERE name = 'Helicopter';
SELECT * FROM sets WHERE name = 'Wave Racer';


-- ----------------------------------------------------------
-- USING OPERATORS
-- ----------------------------------------------------------

-- you can combine conditions with AND, OR, and NOT to make more complex conditions

-- show all sets in 1990 and with more than 200 parts
SELECT * FROM sets WHERE year = 1990 AND num_parts > 200;

-- show all sets in 1990 and with more than 200 (or equal to) parts but less than 300 parts
SELECT * FROM sets WHERE year = 1990 AND num_parts >= 200 AND num_parts < 300;

-- you can use parenthesis to logically group conditions
-- this is the same statement as before
SELECT * FROM sets WHERE year = 1990 AND (num_parts >= 200 AND num_parts < 300);

-- try more examples
-- list lego sets over 2,000 parts and in 2015 or 2016
SELECT * FROM sets WHERE (year = 2016 OR year = 2015) AND num_parts > 2000;
SELECT * FROM sets WHERE (year = 2016 OR year = 2015) AND (num_parts > 2000 AND num_parts < 3000);

-- you can use NOT to negate a group or condition
-- this will show all sets in 1990 but outside of 200-300 parts (so with 1-199 and above 300 parts)
SELECT * FROM sets WHERE year = 1990 AND NOT (num_parts >= 200 AND num_parts < 300);


-- full list of operators are:
-- =  :(equal), 
-- <> : not equal to
-- <  : less then
-- <= : less then or equal to
-- >  : greater than
-- >= : greater than or equal to
-- try them
SELECT * FROM sets WHERE num_parts >= 2000 AND num_parts < 3000;

SELECT * FROM sets WHERE year = 2016 AND num_parts >= 2000 AND num_parts < 3000;

-- lego sets with over 3,000 parts and not in 2016
SELECT * FROM sets WHERE year <> 2016 AND num_parts > 3000;

-- there's also BETWEEN
-- select sets between 2015-2017
-- ** notice that using between includes the boudaries
SELECT * FROM sets WHERE year BETWEEN 2015 AND 2017;

-- select any sets between 200 and 205 parts
SELECT * FROM sets WHERE num_parts BETWEEN 200 AND 205;


-- **************************
-- EXERCISE
-- **************************
-- let's do a combination of queries to look up any architectural themed sets in 2016
-- first let's get the id for Architecture theme
SELECT * FROM themes WHERE name = 'Architecture'
-- we find that the id is 252
-- now let's use that to find the sets
SELECT * FROM sets WHERE year = 2016 AND theme_id = 252;
-- done ;)

-- a little peak... later you find out that you can combine these two statement into one by using what's called "sub-queries"... but don't worry about that now
SELECT * FROM sets WHERE year = 2016 AND theme_id = (SELECT id FROM themes WHERE name = 'Architecture');

-- **************************


-- ----------------------------------------------------------
-- USING LIKE
-- ----------------------------------------------------------

SELECT * FROM colors;

-- use LIKE with '%' to match only part of a string column
-- % is a wildcard that matches anything!

-- select any color starting with Dark
SELECT * FROM colors WHERE name LIKE 'Dark%';

-- select any color ending in Blue
SELECT * FROM colors WHERE name LIKE '%Blue';

-- select colors with Blue, Gold, Trans anywhere in the name
SELECT * FROM colors WHERE name LIKE '%Blue%';
SELECT * FROM colors WHERE name LIKE '%Gold%';
SELECT * FROM colors WHERE name LIKE '%Trans%';

-- select Star Wars sets
SELECT * from sets WHERE name LIKE '%Star Wars%';
-- select Batman sets
SELECT * from sets WHERE name LIKE '%Batman%';

-- you can also use NOT LIKE to look for things that are not like a pattern
-- see all sets that have Batmen but not Joker (what's the fun in that!!!)
SELECT * from sets WHERE name LIKE '%Batman%' AND name NOT LIKE '%Joker%';

