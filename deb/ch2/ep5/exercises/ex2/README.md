# Challenge questions
For this challenge, we will be reading data from CSV files into Panda's DataFrames and writing these to a database.

## Get data
Run the `get_data.sh` script within the `data/` directory. This will download 12 CSVs of air quality data from Beijing. 

## Make database
With your Docker MariaDB running, use a SQL script to make a new database called `airquality`.

## Data pipeline
Create a Jupyter notebook or Python script that does the following:
1. Loads the CSV into DataFrames. 
1. Format the columns into the correct data types.
1. Write each DataFrame to your `airquality` database.