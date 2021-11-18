# Challenge questions
For these challenges, use the `lego` database. This database is already included in our `start_db.sh` script so will be ready for use once the container is started.

## Pandas 
Create a Jupyter notebook or Python script that does the following:

1. Create a SQLAlchemy `engine` for `lego`
1. Read the `sets` table and `themes` table into DataFrames.
1. `INNER JOIN` the `theme_name` into our set data.
1. Write the table back to the `lego` database replacing our `sets` table.

## SQLAlchemy

Using SQLAlchemy in a Jupyter notebook or python script, do the following:
1. Create an `orders` table in `lego` with columns `order_id`, `order_date`, `set_num`, `quantity`.
1. Insert an `order` for 3 copies of the set named 'Rock Star' on today's date.
1. Update this order for 1 copy of the set.