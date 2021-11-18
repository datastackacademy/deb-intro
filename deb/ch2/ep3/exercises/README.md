# Challenge questions
For these challenges, use the `lego` database. This database is already included in our `start_db.sh` script so simply connect to the Docker container as usual using VSCode's extension or `connect_db.sh` and running:

```sql
use lego;
```

With the database up and running, create SQL scripts to complete the following challenges.

## Aggregation functions
1. Find the total number, average number, min and max number of `parts`,  in all `sets`.

## Grouping data
1. Find the total number, average number, min and max number of `parts`,  for each `theme_id` in `sets`.
1. Find all `theme_id`s that have more than 200 parts on average.
1. Find how many total parts each theme had every year.
1. Find the set with the most number of parts each year.
1. How many sets do we have with more than one version in `set_inventories`?
