-- ----------------------------------------------------------
-- DATA MANIPULATION LANGUAGE (DML) STATEMENTS
-- ----------------------------------------------------------

-- SQL can be used to manipulate data as well as querying them
-- DML statements are used to insert data into tables and change data that already exists in tables


-- ---------------------------------------------------------_
-- INSERT STATEMENT
-- ----------------------------------------------------------

-- to insert new values (rows) into a table use INERT
-- insert a new color in colors table
INSERT INTO colors (id, name, rgb, is_trans) VALUES (301, 'Pastel Green', '77dd77', 0);

-- INSERT syntax is:
-- INSERT INTO <table name> (<list of columns>) VALUES (<column values>)
-- where list of columns are the columns you are inserting and values positionally match the value for those columns

-- try it more, add two more pastel colors
INSERT INTO colors (id, name, rgb, is_trans) VALUES (302, 'Pastel Red', 'ff6961', 0);
INSERT INTO colors (id, name, rgb, is_trans) VALUES (303, 'Pastel Purple', 'b39eb5', 0);

-- query the rows you inserted
SELECT * FROM colors WHERE name LIKE 'Pastel%';

-- you can insert multiple rows at a time by separating the values with commas (,)
INSERT INTO colors (id, name, rgb, is_trans) VALUES (304, 'Pastel Pea', 'bee7a5', 0), (305, 'Pale Mauve', 'c6a4a4', 0);


-- ----------------------------------------------------------
-- UPDATE STATEMENT
-- ----------------------------------------------------------

-- to update existing rows use UPDATE
-- let's update the RGB value for Pastel Green color
UPDATE colors SET rgb = '78DD78' WHERE name = 'Pastel Green';

-- query the changed row
SELECT * FROM colors WHERE name = 'Pastel Green';

-- UPDATE syntax
-- UPDATE <table name> SET <new values for columns> WHERE <the rows you want to update>

-- try some more
UPDATE colors SET rgb = 'FF6962' WHERE name = 'Pastel Red';
UPDATE colors SET rgb = 'B39EB5' WHERE name = 'Pastel Purple';

-- you can update multiple columns at the same time
UPDATE colors SET rgb = 'XXXXXX', is_trans = 1 WHERE name = 'Pastel Red';
SELECT * FROM colors WHERE name = 'Pastel Red';

-- now, let's set it back
UPDATE colors SET rgb = 'FF6962', is_trans = 0 WHERE name = 'Pastel Red';

-- you can also update with multiple conditions
UPDATE colors SET rgb = 'XXXXXX', is_trans = 1 WHERE name = 'Pastel Red' OR id = 302;

-- ** be careful ** if your WHERE clause is too broad you can update multiple rows at the same time, but sometimes this is desired
-- update all Pastel colors to have is_trans set to 1
UPDATE colors SET is_trans = 1 WHERE name LIKE 'Pastel%';
SELECT * FROM colors WHERE name LIKE 'Pastel%';
-- now, let's set them back
UPDATE colors SET is_trans = 0 WHERE name LIKE 'Pastel%';

-- last point, you can self reference columns when setting values
-- for example, let's add 10 to the id of Pastel Green
UPDATE colors SET id = id + 10 WHERE name = 'Pastel Green';
-- query it and then set it back
SELECT * FROM colors WHERE name = 'Pastel Green';
UPDATE colors SET id = id - 10 WHERE name = 'Pastel Green';

-- ----------------------------------------------------------
-- DELETE STATEMENT
-- ----------------------------------------------------------

-- use DELTE to remove rows from the table
DELETE FROM colors WHERE name = 'Pastel Green';

-- ** be very careful, this will permanently delete rows and they are NOT recoverable

-- DELETE syntax
-- DELETE FROM <table name> WHERE <condition to filter rows for deletion>

-- you can also delete multiple rows at the same time with a broader condition that spans multiple rows
DELETE FROM colors WHERE name LIKE 'Pastel%';

-- there's an ultimate deletion statement called TRUNCATE which removes all the rows from a table
-- DO NOT use this command lightly
TRUNCATE TABLE colors;

-- ** in our database, this command fails because of a foreign key constraint which means the values we are deleting are used in another table that depends on them. You'll learn this later
