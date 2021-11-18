-- ----------------------------------------------------------
-- ADVANCED SQL QUERY
-- ----------------------------------------------------------


-- ----------------------------------------------------------
-- COLUMN AND TABLE ALIASING
-- ----------------------------------------------------------

-- to simplify selects you can use alias columns
-- this is very useful when you're working with multiple tables in the same query which you will learn later

-- rename id to color_id and name to color_name in the returned query (this does not effect the table!)
SELECT id AS color_id, name AS color_name, rgb FROM colors LIMIT 10;

-- you can also alias a table name
SELECT a.id AS color_id, a.name AS color_name, a.rgb FROM colors AS a LIMIT 10;

-- you can also skip the "as". doesn't make sense, we know! 
SELECT a.id color_id, a.name color_name, a.rgb FROM colors a LIMIT 10;

-- you can also alias columns with their position in the select list in order by 
-- order by color_name and then color_id
SELECT id AS color_id, name AS color_name, rgb FROM colors ORDER BY 2, 1 LIMIT 10;


-- ----------------------------------------------------------
-- IN CLAUSE
-- ----------------------------------------------------------

-- to list a series of values in a WHERE clause you can use IN
-- show all sets in 2013, 2014, and 2017

SELECT * FROM sets WHERE year IN (2013, 2014, 2017);

-- note: the in clause provides a list of items

-- Conversely, you can use NOT IN 
SELECT * FROM sets WHERE year NOT IN (2013, 2014, 2017);

-- of course you can combine the IN with other conditions
SELECT * FROM sets WHERE year IN (2013, 2014, 2017) AND num_parts > 3000;

-- try some more examples
SELECT * FROM colors WHERE name IN ('Bright Green', 'Metal Blue', 'Medium Blue');
SELECT * FROM colors WHERE id IN (41, 42, 46);


-- ----------------------------------------------------------
-- SUB QUERIES
-- ----------------------------------------------------------

-- you can use the result of one query inside another query! (typically as a list)
-- for example to list all the sets with theme: disney, hobbit, and architecture
SELECT * FROM sets WHERE theme_id IN (SELECT id FROM themes WHERE name IN ('Disney', 'The Hobbit', 'Architecture'));

-- note: the inner query (SELECT id FROM themes WHERE name IN ('Disney', 'The Hobbit', 'Architecture') return a list of ids for the themes selected
--       while the outer select uses those as list of ids in an IN clause to query sets

-- another example
-- list all inventory parts where certain color legos are used
SELECT * FROM inventory_parts WHERE color_id IN (SELECT id FROM colors WHERE name IN ('Bright Green', 'Metal Blue', 'Medium Blue'));

-- sub-queries are extremely powerful and widely used!

-- ** exercise **::
-- return inventory_parts from certain sets (use the set ids in an IN clause for an outer select of inventory_parts)

-- you've also seen these used in create table statements
CREATE TABLE lego.colors2 AS (SELECT id, name, rgb FROM lego.colors WHERE id < 50);
-- see the resulting table
SELECT * FROM  lego.colors2;

-- sub-queries can also be used as a table in the FROM clause
SELECT a.id, a.name FROM (SELECT * FROM colors WHERE id < 50) a WHERE a.name LIKE 'Trans%' ORDER BY a.name;

-- there's a lot to unpack here! mind-blown!!!
--      1) the inner select returned all colors with id < 50 (and all columns in colors)
--      2) you have to alias sub-tables, here we alias that select as "a" (or a table called a)
--      3) the outer select, return only few columns from a (a.id and a.name)
--      4) the outer select also adds a where condition and sorts the results


-- ----------------------------------------------------------
-- MANIPULATING COLUMN VALUES IN SELECT
-- ----------------------------------------------------------

-- you can change or apply transformation function on the select columns
-- first, simply return a list of sub-selected columns
SELECT id, name FROM colors WHERE name like 'Trans%';
-- now let's multiply the ids of the returned columns by 2
SELECT id * 2, name FROM colors WHERE name like 'Trans%';

-- note: the id * 2
-- note: the returning ides are doubled
-- note: column transformations are always specified inside the SELECT section of SQL

-- you can use arithmetic operators on decimal columns like: +, -, *, /
-- We can use multiple operators in a single select as well: 

SELECT
    quantity,
    quantity + 1 AS add_quantity, 
    quantity - 10 AS subtract_quantity, 
    quantity/12 AS dozens
FROM inventory_sets WHERE quantity > 1;


-- you can also use string function on text columns
-- return name in upper case
SELECT id, UPPER(name) FROM colors WHERE name like 'Trans%';

-- this example combines the color name and rgb into a single column called name_rgb
SELECT id, CONCAT(name, ' - ', rgb) as name_rgb FROM colors WHERE name like 'Trans%';

-- note: UPPER and CONCAT are built-in string manipulation functions. you'll see more later
--       for complete list you can see: https://mariadb.com/kb/en/string-functions/

