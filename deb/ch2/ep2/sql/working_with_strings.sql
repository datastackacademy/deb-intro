-- ----------------------------------------------------------
-- STRINGS
-- ----------------------------------------------------------

-- there are a number of built-in string manipulation functions 
-- for the complete list refer to: https://mariadb.com/kb/en/string-functions/

-- to see few examples:

-- upper case string
SELECT id, UPPER(name) FROM colors WHERE name like 'Trans%';
-- lower case
SELECT id, LOWER(name) FROM colors WHERE name like 'Trans%';

-- take only first few character
SELECT id, LEFT(name, 4) FROM colors WHERE name like 'Trans%';
-- take right (last) character
SELECT id, RIGHT(name, 4) FROM colors WHERE name like 'Trans%';

-- combine multiple functions
SELECT id, RIGHT(UPPER(name), 4) FROM colors WHERE name like 'Trans%';

-- concatenate strings
-- this example combines the color name and rgb into a single column called name_rgb
SELECT id, CONCAT(name, ' - ', rgb) as name_rgb FROM colors WHERE name like 'Trans%';

-- perhaps the most powerful function is REGEXP which tests if the string value matches a regex pattern 
-- regex stands for regular expression which is used to match complex string patterns
-- to learn more about REGEX syntax: https://www.guru99.com/regular-expressions.html
-- match name with 'Trans' pattern (this is a very simple pattern)
SELECT id, name, name REGEXP 'Trans' FROM colors;
-- note: the return value for columns with Trans in name

-- match any name with one or more 'e' in it:
SELECT name FROM colors WHERE name REGEXP 'e+';

-- match any Star Wars Episode
SELECT name FROM themes WHERE name REGEXP 'Star Wars Episode .';

-- match the first 3 Star Wars Episodes
SELECT name FROM themes WHERE name REGEXP 'Star Wars Episode [213]';

-- the same but using a range
-- [\w\S]+ uses special characters which matches any words (\w) or non-whitespace (\S) characters. The + sign indicates to match once or more times.
SELECT name FROM themes WHERE name REGEXP 'Star Wars [\w\S]+ [1-3]';

-- match any name with two digits in a row
SELECT name FROM themes WHERE name REGEXP '[0-9]{2}';


