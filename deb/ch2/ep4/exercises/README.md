# Challenge questions
For these challenges, use the `lego` database. This database is already included in our `start_db.sh` script so simply connect to the Docker container as usual using VSCode's extension or `connect_db.sh` and running:

```sql
use lego;
```

With the database up and running, create SQL scripts to complete the following challenges.

## `JOIN`
1. Query the `part_num`. color `name` and `rgb` for each part with more than 500 in inventory.
1. Find the set `name` and theme `name` for all sets that have a theme (INNER JOIN).
1. What are the `theme_id`s for all sets with more than one version in `set_inventories`?

## Multiple table `JOIN`
1. Create a query that returns the `set_num`, set `name`, theme `name`, and quantity of the set in inventory for all rows in `sets`.
1. Create a query that returns the `part_num`, part `name`, part color `name`, and quantity in inventory for all rows of `inventory_parts`.