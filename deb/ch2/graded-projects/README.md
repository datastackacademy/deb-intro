# Project Overview
In this graded project we will create a database of Spotify music data. We will start by downloading the data we need, then we will start up database and then it will be up to you to complete the accepting criteria.

## Setup git
For this graded assessment, create a new Git project to store your code. As you write your code to meet the accepting criteria below, commit your files to this repo _and_ update the README.md to provide information about the organization and use of the code you're writing.

## Data
We are working with a dataset of Spotify data that includes information on artists, albums, and individual tracks. In the `data/` directory is a script called `get_data.sh`. This will use `gsutil` to download 3 CSV files of Spotify data into the `data/` directory:
- `spotify_albums.csv`
- `spotify_artists.csv`
- `spotify_tracks.csv`
>Note: If you have not installed `gsutil`, please follow the [Google Cloud section of the Getting Started guide](/getting-started/README.md)

Familiarize yourself with the 3 CSV files to see what columns are present and how they are arranged using Pandas (note these files, especially the `spotify_tracks.csv` are large and do not load well with excel or other spreadsheet tools. Pandas is your friend here). Things to note about this dataset:
- Each row of the csv corresponds to a single artist, album, or track.
- Each csv has a unique id column called `id`.
- These `id`s are referenced as `artist_id`, `album_id`, or `track_id` in the other csv.
- This is an incomplete dataset. For example:
    - Not all tracks for every `spotify_albums.csv` are present in `spotify_tracks.csv` (We'll learn how to pull this missing data in the future).
    - Not every `spotify_artists.csv` entry has albums or songs.
    - Take these into account when cleaning and joining this data.

## Start database
Within the `scr` directory are the expected Docker database scripts: `start_db.sh`, `stop_db.sh`, and `connect_db.sh`. In this case, running the `start_db.sh` starts the MariaDB container with an empty database named `spotify` ready for you to connect to just as we have in all the episodes for this chapter!
We note that this script mounts a volume so Docker can persist data even when stopped and restarted. This means you can run `stop_db.sh` to stop your database and when you restart with `start_db.sh` any work you wrote to the database will still be there. If you do want to wipe your database and start again, see the comment in `stop_db.sh`.

## Accepting criteria:
1. Create Python script or Jupyter Notebook that load the 3 CSVs into Pandas DataFrames and performs the following cleaning steps:
    1. Set the `id` column as your index.
    1. Drop the following columns from all tables: `available_markets`, `images`, `external_urls`.
    1. Drop the `track_id`, `track_name_prev` columns from `albums` and `artists`. This data set has put an arbitrary track in each of the spots for the artist and album.
    1. Convert any `date` column to a datetime data type.
    1. For columns that are lists like `genre` in our `artists` data, convert the whole list to a string.
    3. Check for duplicate rows and drop any you find.
1. Write the 3 tables to our MariaDB as `artists`, `albums`, and `tracks`. 
    1. Be sure the data types are correct in your database!
    1. Set your index as the primary key for each table.
1. Create SQL scripts that query this data to answer the following questions:
    1. Find all artists with more than 1000 followers whose genres include any form of 'pop'.
    1. Find the average `energy`, `dancibility`, and `tempo` for all tracks and then for each `time_signature`.
    1. For each artist, find the total number of albums present in our `albums` table.
    1. Find all albums released before 2000 and order by artist popularity score. 
    1. For each album, find the difference between the total tracks in the `albums` table and the number of tracks present in the `tracks` table.
1. Create a DDL script that queries `artists` for only artists that appear in `albums` or `tracks` and uses this query to create a new table called `featured_artists`.
