# Advanced Queries 
Now that we are comfortable with basic SQL queries, let's learn some advanced methods we can add to our queries. These are covered in the scrip `sql/advanced_query.sql`. Start your database with `start_db.sh` and select the lego database with

```sql
use lego;
```

In this episode, we will look at:
- Name **aliasing**
- `IN` clauses 
- **Sub-select queries**
- Data manipulate within `SELECT` statements


## Aliasing
When selecting data, the column names in the table may not be the most clear "AS" we would like; to address this and we can [alias column names](https://www.w3schools.com/sql/sql_alias.asp). This is particularly useful when you're working with multiple tables in the same query which you will learn later. Let's say we want to make it clear that the `id` and `name` in our `colors` table refer to the color id and name respectively. We use the `column_name AS alias_name` syntax for this:

```sql
-- rename id to color_id and name to color_name in the returned query (this does not effect the table!)
SELECT id AS color_id, name AS color_name, rgb FROM colors LIMIT 10;
```

The same syntax works with table names. This is helpful when using the `table_name.column_name` syntax if the table name is long. This also helps add clarity when multiple tables are involved in the future:

```sql
-- you can also alias a table name
SELECT a.id AS color_id, a.name AS color_name, a.rgb FROM colors AS a LIMIT 10;
```

While the `AS` adds clarity, it is not strictly required. You can use the syntax `column_name alias_name` omitting the `AS` (but make sure you don't miss the commas):

```sql
SELECT a.id color_id, a.name color_name, a.rgb FROM colors a LIMIT 10;
```

### Positional aliasing
You can also alias columns with their position in the `SELECT` list within an `ORDER BY` clause:

```sql
-- order by color_name and then color_id
SELECT id AS color_id, name AS color_name, rgb FROM colors ORDER BY 2, 1 LIMIT 10;
```

## `IN` clause
We learned how to use a `WHERE` clause to filter our data in the last episode but let's learn a new condition we can use, the `IN` clause. We used the `=` operator to compare a column's value to one value but often, we have several values we'd like in our filter. We could combine these using `OR` but a more compact and readable syntax is to use an `IN` clause. The syntax for `IN` is

```sql
WHERE column_name IN (<list of values>)
```

For example, if we want all the sets from 2013, 2014, and 2017, we could use the following `IN` clause:

```sql
-- show all sets in 2013, 2014, and 2017

SELECT * FROM sets WHERE year IN (2013, 2014, 2017);
```

Conversely, you can use `NOT IN` in to find all rows *not* in the list:

```sql
SELECT * FROM sets WHERE year NOT IN (2013, 2014, 2017);
```

and as with any condition, you can combine the IN with other conditions:

```sql
SELECT * FROM sets WHERE year IN (2013, 2014, 2017) AND num_parts > 3000;

-- try some more examples
SELECT * FROM colors WHERE name IN ('Bright Green', 'Metal Blue', 'Medium Blue');
SELECT * FROM colors WHERE id IN (41, 42, 46);
```


## Sub queries

One of the things that makes SQL incredibly powerful is the ability to run one query inside another. All that's necessary is that the inner (or sub) query returns something in the right format. Often this is a list. For example, the following SQL query returns a list of `id`s from our `themes` table with `name` based off the `WHERE` filter:


```sql
SELECT id FROM themes WHERE name IN ('Disney', 'The Hobbit', 'Architecture')
```

Now, to query all the lego `sets` with these theme `id`s, we can use this query AS a _sub query (sub-select)_ within an `IN` clause:

```sql
SELECT * 
FROM sets 
WHERE theme_id IN (SELECT id FROM themes WHERE name IN ('Disney', 'The Hobbit', 'Architecture'));
```

Let's unpack this quickly:
- Our _sub-select_ returns a list of theme ids for a list of theme names: 'Disney', 'The Hobbit', 'Architecture'
- We use this list as the `IN` clause to filter our lego sets matching the themes


As another example, we can list all inventory parts where certain color legos are used:

```sql
SELECT * 
FROM inventory_parts 
WHERE color_id IN (SELECT id FROM colors WHERE name IN ('Bright Green', 'Metal Blue', 'Medium Blue'));
```

Sub-queries are extremely powerful and widely used! The above examples show how they make it easy to use data across different tables which comes up often when working with real-world data but we aren't limited to `IN` clauses.

**Exercise**:
Return inventory_parts from certain sets (use the set ids in an IN clause for an outer select of inventory_parts)

We also saw a sub query used in our `CREATE TABLE` example last episode:

```sql
CREATE TABLE lego.colors2 AS (SELECT id, name, rgb FROM lego.colors WHERE id < 50);
-- see the resulting table
SELECT * FROM  lego.colors2;
```

Sub queries can also be used AS a table in the `FROM` clause of a `SELECT` statement:

```sql
SELECT a.id, a.name 
FROM (SELECT * FROM colors WHERE id < 50) a 
WHERE a.name LIKE 'Trans%' 
ORDER BY a.name;
```
There's a lot to unpack here!
1. The inner select returned all colors with `id < 50` (and all columns in `colors`).
1. You have to alias sub-tables so they can be reference, here we alias that select AS `a` (without an `AS`).
1. The outer select, return only two columns from `a` (`a.id` and `a.name`).
1. The outer select also adds a `WHERE` condition and sorts the results.

## Manipulate values in `SELECT`

You can change or apply transformation functions within the columns selection section of a `SELECT` statement. This is often useful if we want to scale numbers or change units. Let's say we have the following simple query:

```sql
SELECT id, name FROM colors WHERE name like 'Trans%';
```

If we want to manipulate the value for `id`, say multiply it by 2, we can easily do this within our `SELECT`:

```sql
-- now let's multiply the ids of the returned columns by 2
SELECT id * 2, name FROM colors WHERE name like 'Trans%';
```

>Note: column transformations are always specified inside the SELECT section of a SQL statement

For decimal columns, you can use arithmetic operators such as: +, -, *, /

We can use multiple operators in a single select as well. Let's say we want to play around with incrementing, decrementing, and checking how many dozens of a set we have, all in one query. We can simply use each operator within the `SELECT`:

```sql
SELECT
    quantity,
    quantity + 1 AS add_quantity, 
    quantity - 10 AS subtract_quantity, 
    quantity/12 AS dozens
FROM inventory_sets WHERE quantity > 1;
```

You can also use string function on text columns. The SQL function `UPPER()` casts the string in uppercase letter:

```sql
-- return name in upper case
SELECT id, UPPER(name) FROM colors WHERE name like 'Trans%';
```

Similarly, the string function `CONCAT` combines any number of columns, or strings. Let's say you want to combine the color name and rgb, separated by a ` - ` into a single column:

```sql
-- this example combines the color name and rgb into a single column called name_rgb
SELECT id, CONCAT(name, ' - ', rgb) AS name_rgb FROM colors WHERE name like 'Trans%';
```

> **NOTE**: Every database has its own set of built-in string manipulation functions. Here is the list of the [string manipulation functions](https://mariadb.com/kb/en/string-functions/) in MariaDB (MySQL).

> **NOTE**: Most databases also support defining user-defined custom functions; these are called **UDFs**. This is a very powerful feature where you can define complex transformation functions in SQL. These functions often can be developed in other languages (such as C, Java, or python) supported by the database. This is a fairly advanced topic which would not be covered here; but don't let us to subdue your curiosity :wink: 


Let's go over a few more of string functions...

## Working with Strings

We will look at the examples within `sql/working_with_strings.sql` to see a few more uses of the string functions.

We learned about `UPPER()`:

```sql
-- upper case string
SELECT id, UPPER(name) FROM colors WHERE name like 'Trans%';
```

but there is also a `LOWER()` for lower case conversion:

```sql
-- lower case
SELECT id, LOWER(name) FROM colors WHERE name like 'Trans%';
```

If we only want the first N characters, we can use `LEFT(<column name>, N)` to select that many characters. For example, let's get the first 4 characters of the name:

```sql
-- take only first few character
SELECT id, LEFT(name, 4) FROM colors WHERE name like 'Trans%';
```

And the function `RIGHT` works the same way for the trailing characters:

```sql
-- take right (last) character
SELECT id, RIGHT(name, 4) FROM colors WHERE name like 'Trans%';
```

Since the output of a string manipulation function is itself a string, we can combine multiple of them together:

```sql

-- combine multiple functions
SELECT id, RIGHT(UPPER(name), 4) FROM colors WHERE name like 'Trans%';
```

Perhaps the most powerful function is REGEXP which tests if the string value matches a regex pattern. The word regex stands for regular expression which are used to match complex string patterns than the simple `=` or `LIKE` syntax we've been using. To learn more about REGEX syntax you can read [this guide](https://www.guru99.com/regular-expressions.html). We can use a simple pattern without any wildcards AS our first example. Let's find the transparent colors:

```sql
-- match name with 'Trans' pattern (this is a very simple pattern)
SELECT id, name, name REGEXP 'Trans' FROM colors;
```

While the exact regex syntax varies between SQL flavors, [here is the syntax our MariaDB uses.](https://mariadb.com/kb/en/regular-expressions-overview/) As you can tell, there is a lot of power and flexibility in regex and they could be their own lesson. Let's learn some of the special characters we can use.
- **Repeated character**:  The `+` character matches _one or more_ of the character that immediately proceeds it. So if we want all colors that have 1 or more `e` in them, we could use the following query:

```sql
SELECT name FROM colors WHERE name REGEXP 'e+';
```

Similarly, the `*` character matches _zero or more_ of a character. We can use `{n}` to match _exactly_ n repetitions of the proceeding character or `{n,m}` to match any number between `n` and `m` (we'll see an example of this bellow).

- **Wildcard**: in MariaDB, the character `.` matches _any_ single character. For example if we want to match any Star Wars Episode themed set, we could run:

```sql
SELECT name FROM themes WHERE name REGEXP 'Star Wars Episode .';
```

> **NOTE**: [regex101](https://regex101.com/) is a great free online tool to build, test, and learn regex patterns. They have a really nice cheatsheet for learning how to use basic patterns.

- **Character sets**: In addition to wildcard characters, we can use `[ ]` to specify sets of characters. Any character within the brackets is matched in that spot. For example, if we want to match only Star Wars Episodes 1, 2, or 3, we could use the following query:

```sql
SELECT name FROM themes WHERE name REGEXP 'Star Wars Episode [123]';
```

We can also use _ranges_ within `[ ]` sets. The above example could therefore be written:

```sql
SELECT name FROM themes WHERE name REGEXP 'Star Wars Episode [1-3]';
```

Character sets also combine very nicely with the repeated character special characters. For example, let's say we want all themes that have _two or more digits_ next to each other? We can combine the character set `[0-9]` (all digits from 0 to 9) with the brackets `{2}` which looks for 2 repetitions of that proceeding set:

```sql
SELECT name FROM themes WHERE name REGEXP '[0-9]{2}';
```

These only begin to scratch the surface of the flexibility of regex but give you an idea of how flexibly they are. Another great resource for regex is the site [regex101](https://regex101.com/). You can enter a regular expression in the top field and then enter test strings in the box bellow to see if they do or do not match your expression. This is very helpful when you're trying to build the right regex for your task.


# Working with Dates

Another type of data we will often work with dates. We saw a bit of this when learning Python and Pandas but let's learn how they're handled in SQL. To do this, we will switch to another database, the `northwind` database of sales data that includes date columns. Let's switch databases:

```sql
-- switch to using the northwind database which has date columns
use northwind;
```

Date is a data type for columns within SQL. Just like strings, there are special functions for working with and manipulating dates. Here is a complete [list of date functions](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html). Let's go through a few of them together.

## Extract a portion of the date
Let's extract the year, month, and day portion of a date. This uses the `YEAR()`, `MONTH()`, and `DAY()` functions respectively:

```sql
SELECT order_date, YEAR(order_date) AS year, MONTH(order_date) AS month, DAY(order_date) AS day FROM orders;
```

Each of these functions takes a date column name AS the input and returns the calculated value (year, month, etc)

There are also functions to extract the day of the week, the names of days and month, and even the week of the year:

```sql
SELECT 
    order_date, 
    WEEKDAY(order_date) AS weekday, 
    DAYNAME(order_date) AS weekday_name,
    MONTHNAME(order_date) AS monthname,
    WEEKOFYEAR(order_date) AS weekofyear
FROM orders;
```

We can also add or subtract to dates; we can use `DATE_ADD` for this. This function takes a date column and then an `INTERVAL` statement. For example, here we can add 2 days or 2 weeks to a date:

```sql
SELECT 
    order_date, 
    DATE_ADD(order_date, INTERVAL 2 DAY) AS plus_2_days,
    DATE_ADD(order_date, INTERVAL 2 WEEK) AS plus_2_weeks
FROM orders;
```

If we use a negative number with our `INTERVAL`, we subtract from our data:

```sql
SELECT 
    order_date, 
    DATE_ADD(order_date, INTERVAL -2 DAY) AS minus_2_days,
    DATE_ADD(order_date, INTERVAL -2 WEEK) AS minus_2_weeks
FROM orders;
```


There are also function to return the current date/time:

```sql
SELECT 
    order_date, 
    CURRENT_DATE() AS cur_date,
    CURRENT_TIME() AS cur_time
FROM orders;
```

Note that these aren't selected from the table, so we could select them all by themselves:

```sql
SELECT CURRENT_DATE() AS cur_date, CURRENT_TIME() AS cur_time;
```

If we want to know the difference between dates or times, we can use the `DATEDIFF` or `TIMEDIFF` functions. `DATEDIFF` returns number of days and `TIMEDIFF` returns a time difference (hour, minute, second).

```sql
SELECT 
    order_date,
    shipped_date,
    DATEDIFF(shipped_date, order_date) AS num_days_to_ship,
    TIMEDIFF(shipped_date, order_date) AS time_to_ship
FROM orders;
```

As you can see from our dive into strings and dates, there are many ways to manipulate the data as wel query it. This combined with the flexibility of sub queries means we can perform very complex calculations within SQL. Next episode we will learn how to calculate aggregate values from our data.