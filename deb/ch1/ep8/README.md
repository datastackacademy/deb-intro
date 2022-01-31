# Ch. 1, Ep. 8: Aggregates and Joins

In this episode we will build on the previous Pandas episodes and look at aggregation and joining, which are crucial concepts for the working data engineer.

## Episode Resources
1. [Aggregates](01_aggregates.ipynb) (notebook)
1. [Joins](02_joins.ipynb) (notebook)

## Aggregates in Pandas

Pandas provides a `.groupby()` method which makes it easy to compute aggregates over the `DataFrame`. This is very handy to find things like sums, counts, min. and max values.

The example below shows how to use `count()`, `sum()`, `min()`, and `max()`:

```python
import pandas as pd

# read data fom csv
data_dir = '../../../data/input/ch1/'
routes_file = data_dir + 'routes.csv'
routes = pd.read_csv(routes_file, header=0)

# get routes leaving a src
routes_per_src = routes.groupby('src').src.count()

# get total stops leading to each dest
stops_per_dest = routes.groupby('dest').stops.sum()

# get max stops per src
max_stops_src = routes.groupby('src').stops.max()

# get min stops per src
min_stops_src = routes.groupby('src').stops.min()

print("Routes per src:\n", routes_per_src.head(10))
print("Stops per dest:\n", stops_per_dest.head(10))
print("Max stops per src:\n", max_stops_src.sort_values(ascending=False).head())
print("Min stops per src:\n", min_stops_src.head())
```
Output:
<pre>
Routes per src:
 src
AAE     9
AAL    20
AAN     2
AAQ     3
AAR     8
AAT     2
AAX     1
AAY     1
ABA     4
ABB     2
Name: src, dtype: int64
Stops per dest:
 dest
AAE    0
AAL    0
AAN    0
AAQ    0
AAR    0
AAT    0
AAX    0
AAY    0
ABA    0
ABB    0
Name: stops, dtype: int64
Max stops per src:
 src
BOS    1
YRT    1
HOU    1
ARN    1
YVR    1
Name: stops, dtype: int64
Min stops per src:
 src
AAE    0
AAL    0
AAN    0
AAQ    0
AAR    0
Name: stops, dtype: int64
</pre>

<br/>

#### Multiple Aggregates Using .agg()

Alternatively, pandas provides the `.agg()` method to apply multiple aggregates on a column at the same time. You can accomplish the same results much more concisely by using the `.agg()` method such as:

```python
# create a grouped series
grouped = routes.groupby('src').stops.agg([len, sum, min, max])
print(grouped.head(5))
```
Output:
<pre>
     len  sum  min  max
src                    
AAE    9    0    0    0
AAL   20    0    0    0
AAN    2    0    0    0
AAQ    3    0    0    0
AAR    8    0    0    0
</pre>

<br/>

#### GroupBy Multiple Columns

You can pass an list of columns to `groupby()` method to aggregate by multiple columns at the same time. The example below calculates flight counts per airline route (airline, src, dest):

```python
# get flight counts for distinct routes
routes_per_pair = routes.groupby(['src', 'dest']).src.count()
routes_per_pair.head(25)
```
Output:
<pre>
src  dest
AAE  ALG     1
     CDG     1
     IST     1
     LYS     1
     MRS     2
     ORN     1
     ORY     2
AAL  AAR     1
     AGP     1
     ALC     1
     AMS     2
     ARN     1
     BCN     2
     BLL     3
     CPH     2
     IST     1
     LGW     1
     OSL     3
     PMI     1
     SVG     1
AAN  CCJ     1
     PEW     1
AAQ  DME     1
     LED     1
     SVO     1
Name: src, dtype: int64
</pre>

<br>

## Joins

You may have noticed during your data exploration that the `iata` codes in the `airports` data correspond to the `scr` and `dest` in the `routes` data. This is a frequent occurrence in data; there are common fields that will allow us to link or join information in our two datasets.

When joining data, one of the most important issues is the *cardinality* of our data. Cardinality refers to the numerical relationship between rows in one table and rows in another table, when performing a join. There are two types of relationships that we will encounter most commonly:
- One-to-one: this type of relationship exists when each row in one table has only one related row in another table. An airline related example might be seat assignments - on a given flight, each passenger occupies only one seat, and each seat contains only one passenger.
- One-to-many: this type of relationship exists when each row in one table has more than one related row in another table. Passenger lists are an example - each flight contains many passengers.
- Many-to-many: multiple records in a table are associated with multiple records in another table. An example might be passenger flight history - a single passenger might have taken many flights, and each flight contains multiple passengers.

Understanding cardinality is important when choosing the details of a join method in Pandas or SQL (which we'll discuss in the next chapter). Looking at some detailed examples will help to fill in the details.

Another related concept to discuss before we look at the details of Pandas functions is [join types](https://en.wikipedia.org/wiki/Join_(SQL)). There are many possible types of joins, reflecting different possible cardinality relationships in data. Pandas supports the following join types:
- Inner Join or Natural Join: To keep only rows that match from the data frames, specify the argument how=‘inner’ (more details below in the discussion of `merge()`).
- Outer Join or Full Outer Join: To keep all rows from both data frames, specify how=‘outer’.
- Left Join or Left Outer Join: To include all the rows of your data frame x and only those from y that match, specify how=‘left’.
- Right Join or Right outer join: To include all the rows of your data frame y and only those from x that match, specify how=‘right’.

This Venn diagram should help you to visualize the relationships:

![Join types in Pandas](img/join-types.png)

Joins are a complex topic and there are many more details than we can discuss in this introduction. We will talk about joins in more detail in the next chapter when we get to SQL and databases. [This paper](https://www.lexjansen.com/wuss/2017/124_Final_Paper_PDF.pdf) is a good reference on join types that will provide much more detail for those who are interested; it refers to SQL joins, but the concepts are the same - joining in Pandas is closely based on the equivalent database operations.


Now we can look at some concrete examples that will help you understand the different join types and how to use them in Pandas. First, let's do our standard import and data setup:


 ```python
 import pandas as pd

data_dir = '../../../data/input/ch1/'
airports_file = data_dir + 'airports.csv'
routes_file = data_dir + 'routes.csv'

# read data fom csv
airports = pd.read_csv(airports_file, header=0)
routes = pd.read_csv(routes_file, header=0)
```

### Merge

First we will learn about Pandas' `merge()` function, the most flexible way to combine data. [`pd.merge()`](https://pandas.pydata.org/docs/reference/api/pandas.merge.html) starts with two required arguments, the `DataFrame`s to be joined. Next we have the following positional arguments:
- `how`: the strategy for joining the data. The default value is `'inner'`, with `'outer'`, `'left'`, and `'right'` being the other possible values (refer to the list of join types above).
- `on`: the columns to join on (if the column name is the same in both `DataFrame`s being joined)
- `left_on` and `right_on`: columns from the respective tables (if the column names differ between `DataFrames`)
- `left_index` or `right_index`: used if you simply want to join on indices, you can use the Boolean parameters `left_index` or `right_index` to specify which to use.
- `suffixes`: this is an optional `tuple` of `str` allows us to specify a suffix to append to columns with the same name that appear in both `DataFrames` that are not joined on.

There are a LOT of possible usages of merge(), so let's look at some specific examples to help you understand how to call `merge()` based on the type of join you are performing.

First we will look at an *inner join* example, in the context of a real-world problem. Given the route and airport data we loaded, suppose we want to get a list of all possible route combinations where the originating airport is in the state of New York. This is precisely the sort of data operation which you will be expected to perform on a regular basis as a data engineer - given some large amount of raw data, you will need to figure out how to filter and merge that data into another layer of data that helps to answer some important business question.

Before we look at any code, let's think through this join operation a bit more. In order to decide what we want our resulting data to look like when performing a join, it is important to think through the structure of all of our input tables as well the structure that we want out of the resulting joined data. In this case, we have two input data sources - airports and routes. What we want is a set of records giving all possible route combinations for each NY airport. So in performing our join, we want to select records where the `iata` column from `ny_airports` (the left `DataFrame`) matches the `src` column of the routes data (`src_dest`). The fact that we want our resulting data to contain rows that match between both `DataFrame`s tells us that we want to use an *inner join* in this case.

We want to do a bit of preprocessing on each of the input `DataFrame`s to meet our requirements. In the case of airport data, we want to select only New York airports before we perform the join. In the case of the route data, we want to remove duplicate route combinations.

Here is how to perform the whole procedure, applying a preprocessing step to both input tables, and then joining the two subsets of data that result from that preprocessing:


```python
# filter for only NY airports
ny_airports = airports[airports.state == 'NY']
print(ny_airports)
print("Just New York airports:\n", ny_airports.shape)

# drop duplicate routes
src_dest = routes[['src', 'dest']].drop_duplicates(ignore_index=True)
print(src_dest)
print("All possible src and dest pairs:\n", src_dest.shape)

# inner join on the resulting DataFrames using merge()
ny_src_routes = pd.merge(ny_airports, src_dest, left_on='iata', right_on='src')
print(ny_routes_inner.head(10)) 
print(ny_routes_inner.shape)
```

Output:
<pre>
     iata                 airport            city state country        lat  \
3     01G            Perry-Warsaw           Perry    NY     USA  42.741347   
19    06N                Randall       Middletown    NY     USA  41.431566   
42    0B8              Elizabeth   Fishers Island    NY     USA  41.251308   
54    0G0  North Buffalo Suburban        Lockport    NY     USA  43.103184   
57    0G7   Finger Lakes Regional    Seneca Falls    NY     USA  42.880623   
...   ...                     ...             ...   ...     ...        ...   
2901  SCH         Schenectady Cty     Schenectady    NY     USA  42.852456   
2972  SLK              Adirondack    Saranac Lake    NY     USA  44.385310   
3039  SWF                 Stewart        Newburgh    NY     USA  41.504094   
3048  SYR   Syracuse-Hancock Intl        Syracuse    NY     USA  43.111187   
3193  UCA              Oneida Cty           Utica    NY     USA  43.145119   

            lon  
3    -78.052081  
19   -74.391917  
42   -72.031611  
54   -78.703346  
57   -76.781620  
...         ...  
2901 -73.928867  
2972 -74.206185  
3039 -74.104838  
3048 -76.106311  
3193 -75.383859  

[97 rows x 7 columns]
Just New York airports:
 (97, 7)
       src dest
0      ASF  KZN
1      ASF  MRV
2      CEK  KZN
3      CEK  OVB
4      DME  KZN
...    ...  ...
37589  TSV  WIN
37590  WGA  MEL
37591  WIN  LRE
37592  WIN  TSV
37593  WYA  ADL

[37594 rows x 2 columns]
All possible src and dest pairs:
 (37594, 2)
  iata     airport    city state country        lat        lon  src dest
0  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  ALB  BOS
1  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  ALB  MSS
2  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  ALB  OGS
3  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  ALB  CLT
4  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  ALB  DCA
(358, 9)

</pre>

Looking at all the output will help us to understand how the data is transformed from start to finish. The first output block shows what happens when we select NY airports from the airports data (giving us the `ny_airports` `DataFrame`). The result is a `DataFrame` where each row corresponds to one NY airport, and there are no duplicates. This `DataFrame` contains 97 rows.

The second output block shows some rows from the filtered route data (after removing duplicates). This is the `src_dest` `DataFrame`. There are many possible route combinations, because other than removing duplicates, we have not placed any restrictions on the source or destination. This `DataFrame` contains 37,594 rows. Note that many of these routes will not originate at NY airports, so only a small subset of these records will match the airports in the other `DataFrame`.

The last output block shows a few rows from the `DataFrame` that results from the merge operation (`ny_routes_inner`). This `DataFrame` contains 358 rows, which is more than the number of airports in NY. This fact tells us that, in this case, our join operation expresses a *one-to-many* relationship. For each airport, there is at least one (and often more than one) corresponding route. We can see at a glance that there are several routes which originate at the Albany airport.

It is not always obvious which join type is appropriate for a given situation. While it is very important to think carefully through data operations before you perform them (particularly since, when working on the cloud, your organization is incurring costs for almost everything you do), sometimes it is helpful (especially when learning) to try different things out and see what result you get.

Let's see what happens if, given the same data and requirements as in the above example, we do an outer join instead of an inner join. Because an outer join keeps all records from both `DataFrame`s (or tables), instead of only those with matching rows, we should expect that an outer join will return more records than an inner join - probably many more.

Let's look at what happens when we use an outer join on the same data:

```python
# outer join:
ny_routes_outer = pd.merge(ny_airports, src_dest, how='outer', left_on='iata', right_on='src')
print(ny_routes_outer.head(5)) 
print(ny_routes_outer[30:35])
print(ny_routes_outer.shape)
```

Output:
<pre>
  iata                 airport            city state country        lat  \
0  01G            Perry-Warsaw           Perry    NY     USA  42.741347   
1  06N                Randall       Middletown    NY     USA  41.431566   
2  0B8              Elizabeth   Fishers Island    NY     USA  41.251308   
3  0G0  North Buffalo Suburban        Lockport    NY     USA  43.103184   
4  0G7   Finger Lakes Regional    Seneca Falls    NY     USA  42.880623   

         lon  src dest  
0 -78.052081  NaN  NaN  
1 -74.391917  NaN  NaN  
2 -72.031611  NaN  NaN  
3 -78.703346  NaN  NaN  
4 -76.781620  NaN  NaN  
   iata           airport     city state country        lat        lon  src  \
30  9G0  Buffalo Airfield  Buffalo    NY     USA  42.862003 -78.716585  NaN   
31  9G3             Akron    Akron    NY     USA  43.021087 -78.482968  NaN   
32  9G5          Royalton  Gasport    NY     USA  43.182002 -78.557805  NaN   
33  ALB        Albany Cty   Albany    NY     USA  42.748119 -73.802979  ALB   
34  ALB        Albany Cty   Albany    NY     USA  42.748119 -73.802979  ALB   

   dest  
30  NaN  
31  NaN  
32  NaN  
33  BOS  
34  MSS  
(37673, 9)
</pre>

In this resulting `DataFrame`, the number of records is much larger than when we performed an inner join. Instead of 358 records, the outer join produces 37,673, reflecting the fact that all rows from BOTH tables are being preserved (rather than only matching rows). Not only the number of records, but the structure of the resulting data has changed as well. In particular, this outer join result contains many records where the source and/or destination columns both contain the `NaN` value (remember that `NaN` is essentially a placeholder for a null value, a way to say that no value is present). This should not surprise us, because an outer join returns all rows from both `DataFrame`s, even if there is not a match, so there will be empty values in the result where there was not a matching row in both `DataFrame`s.

What does that mean, in non-technical language? Where there are rows with empty values for `src` and `dest`, that tells us that the airports represented by those rows do not have corresponding route data in the routes table (there is no recorded route that originates or concludes at that airport). Take the first row above (Perry-Warsaw Airport, code '01G') - a quick search of `routes.csv` confirms that the '01G' airport code is not present in our route data.

So, what is the right choice of join operation to use in a given situation? The answer is that it depends heavily on what the data scientists/analysts and decision-makers want out of the data. Probably the inner join is what someone would be more interested in, because there are fewer records, and not a lot of empty values. But if the business question at hand involved understanding which airports were not present in the given route data, then the outer join might be more appropriate, because it gives more information (though it requires a bit more interpretation).

Let's look now at what happens when we perform a *left outer join* on the same data.

```python
# left outer join:
ny_routes_left_outer = pd.merge(ny_airports, src_dest, how='left', left_on='iata', right_on='src')
print(ny_routes_left_outer.head()) 
print(ny_routes_left_outer.shape)
```

Output:
<pre>
  iata                 airport            city state country        lat  \
0  01G            Perry-Warsaw           Perry    NY     USA  42.741347   
1  06N                Randall       Middletown    NY     USA  41.431566   
2  0B8              Elizabeth   Fishers Island    NY     USA  41.251308   
3  0G0  North Buffalo Suburban        Lockport    NY     USA  43.103184   
4  0G7   Finger Lakes Regional    Seneca Falls    NY     USA  42.880623   

         lon  src dest  
0 -78.052081  NaN  NaN  
1 -74.391917  NaN  NaN  
2 -72.031611  NaN  NaN  
3 -78.703346  NaN  NaN  
4 -76.781620  NaN  NaN  
(437, 9)
</pre>

The *left outer join* returns 437 rows, more than the inner join, but far fewer than the full outer join, reflecting the fact that the left outer join only includes rows with a column match in the left `DataFrame` (`ny_airports`). In this case, all the `NaN` values are found in the `src` and `dest` columns, which illustrates that a left outer join does not require a column match in the right `DataFrame`.

Similarly, a `right` join returns all the rows which have a match in the right `DataFrame`, `Nan` filled when no merging data is present. Notice that now, all the `NaN` values appear in the columns from the left `DataFrame` (`ny_airports`) instead of the right `DataFrame`, as in the above example.

```python
# right join:
ny_routes_right_join = pd.merge(ny_airports, src_dest,how='right', left_on='iata', right_on='src')
print(ny_routes_right_join.head()) 
print(ny_routes_right_join.shape)
```

Output:
<pre>
  iata airport city state country  lat  lon  src dest
0  NaN     NaN  NaN   NaN     NaN  NaN  NaN  ASF  KZN
1  NaN     NaN  NaN   NaN     NaN  NaN  NaN  ASF  MRV
2  NaN     NaN  NaN   NaN     NaN  NaN  NaN  CEK  KZN
3  NaN     NaN  NaN   NaN     NaN  NaN  NaN  CEK  OVB
4  NaN     NaN  NaN   NaN     NaN  NaN  NaN  DME  KZN
(37594, 9)
</pre>

### Join with Pandas join() method

`DataFrames` also have built in `join` methods. This object method uses `merge` but can be a more straightforward method for performing joins onto a specific `DataFrame`. `join()` always joins using the index of the other `DataFrame` so it is less flexible but can give similar behavior to `merge()` when many indices are common:

```python
left_join = ny_airports.join(src_dest.set_index('src'), how='left', on='iata')
print(left_join.head()) 
print(left_join.shape)

inner_join = ny_airports.join(src_dest.set_index('src'), how='inner', on='iata')
print(inner_join.head()) 
print(inner_join.shape)
```

Output:
<pre>
   iata                 airport            city state country        lat  \
3   01G            Perry-Warsaw           Perry    NY     USA  42.741347   
19  06N                Randall       Middletown    NY     USA  41.431566   
42  0B8              Elizabeth   Fishers Island    NY     USA  41.251308   
54  0G0  North Buffalo Suburban        Lockport    NY     USA  43.103184   
57  0G7   Finger Lakes Regional    Seneca Falls    NY     USA  42.880623   

          lon dest  
3  -78.052081  NaN  
19 -74.391917  NaN  
42 -72.031611  NaN  
54 -78.703346  NaN  
57 -76.781620  NaN  
(437, 8)
    iata     airport    city state country        lat        lon dest
825  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  BOS
825  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  MSS
825  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  OGS
825  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  CLT
825  ALB  Albany Cty  Albany    NY     USA  42.748119 -73.802979  DCA
(358, 8)
</pre>

### Concat()

The last way to combine `DataFrames` we will discuss is using the `concat()` method. Unlike the joins we have been discussing, `concat()` does not attempt to match common data within columns. Instead, it can be thought of as simply stacking the `DataFrames` on top of or next to each other. The first argument of `concat()` is a list of objects to concatenate, usually `DataFrames`. 
We then specify which way to concatenate them with the `axis` argument. With `axis=0`, the `DataFrames` are concatenated vertically (stacked on top of each other). All column names are retained and columns common to the `DataFrames` are combined. Similarly, `axis=1` is a horizontal concatenation; the `DataFrames` are stacked next to each other, aligned by index.

```python
# vertical concatenate
first_airports = airports.head()
first_routes = routes.head().copy()
second_airports = airports.iloc[5:10]
first_routes.rename(columns={'src': 'iata'}, inplace=True)
print("Vertical concat:\n", pd.concat([first_airports, first_routes, second_airports], axis=0))
print("Horizontal concat:\n", pd.concat([first_airports, first_routes, second_airports], axis=1))
```

Output:
<pre>
Vertical concat:
   iata               airport              city state country        lat  \
0  00M              Thigpen        Bay Springs    MS     USA  31.953765   
1  00R  Livingston Municipal        Livingston    TX     USA  30.685861   
2  00V           Meadow Lake  Colorado Springs    CO     USA  38.945749   
3  01G          Perry-Warsaw             Perry    NY     USA  42.741347   
4  01J      Hilliard Airpark          Hilliard    FL     USA  30.688012   
0  ASF                   NaN               NaN   NaN     NaN        NaN   
1  ASF                   NaN               NaN   NaN     NaN        NaN   
2  CEK                   NaN               NaN   NaN     NaN        NaN   
3  CEK                   NaN               NaN   NaN     NaN        NaN   
4  DME                   NaN               NaN   NaN     NaN        NaN   
5  01M     Tishomingo County           Belmont    MS     USA  34.491667   
6  02A           Gragg-Wade            Clanton    AL     USA  32.850487   
7  02C               Capitol        Brookfield    WI     USA  43.087510   
8  02G     Columbiana County    East Liverpool    OH     USA  40.673313   
9  03D      Memphis Memorial           Memphis    MO     USA  40.447259   

          lon airline dest codeshare  stops equipment  
0  -89.234505     NaN  NaN       NaN    NaN       NaN  
1  -95.017928     NaN  NaN       NaN    NaN       NaN  
2 -104.569893     NaN  NaN       NaN    NaN       NaN  
3  -78.052081     NaN  NaN       NaN    NaN       NaN  
4  -81.905944     NaN  NaN       NaN    NaN       NaN  
0         NaN      2B  KZN       NaN    0.0       CR2  
1         NaN      2B  MRV       NaN    0.0       CR2  
2         NaN      2B  KZN       NaN    0.0       CR2  
3         NaN      2B  OVB       NaN    0.0       CR2  
4         NaN      2B  KZN       NaN    0.0       CR2  
5  -88.201111     NaN  NaN       NaN    NaN       NaN  
6  -86.611453     NaN  NaN       NaN    NaN       NaN  
7  -88.177869     NaN  NaN       NaN    NaN       NaN  
8  -80.641406     NaN  NaN       NaN    NaN       NaN  
9  -92.226961     NaN  NaN       NaN    NaN       NaN  
Horizontal concat:
   iata               airport              city state country        lat  \
0  00M              Thigpen        Bay Springs    MS     USA  31.953765   
1  00R  Livingston Municipal        Livingston    TX     USA  30.685861   
2  00V           Meadow Lake  Colorado Springs    CO     USA  38.945749   
3  01G          Perry-Warsaw             Perry    NY     USA  42.741347   
4  01J      Hilliard Airpark          Hilliard    FL     USA  30.688012   
5  NaN                   NaN               NaN   NaN     NaN        NaN   
6  NaN                   NaN               NaN   NaN     NaN        NaN   
7  NaN                   NaN               NaN   NaN     NaN        NaN   
8  NaN                   NaN               NaN   NaN     NaN        NaN   
9  NaN                   NaN               NaN   NaN     NaN        NaN   

          lon airline iata dest codeshare  stops equipment iata  \
0  -89.234505      2B  ASF  KZN       NaN    0.0       CR2  NaN   
1  -95.017928      2B  ASF  MRV       NaN    0.0       CR2  NaN   
2 -104.569893      2B  CEK  KZN       NaN    0.0       CR2  NaN   
3  -78.052081      2B  CEK  OVB       NaN    0.0       CR2  NaN   
4  -81.905944      2B  DME  KZN       NaN    0.0       CR2  NaN   
5         NaN     NaN  NaN  NaN       NaN    NaN       NaN  01M   
6         NaN     NaN  NaN  NaN       NaN    NaN       NaN  02A   
7         NaN     NaN  NaN  NaN       NaN    NaN       NaN  02C   
8         NaN     NaN  NaN  NaN       NaN    NaN       NaN  02G   
9         NaN     NaN  NaN  NaN       NaN    NaN       NaN  03D   

             airport            city state country        lat        lon  
0                NaN             NaN   NaN     NaN        NaN        NaN  
1                NaN             NaN   NaN     NaN        NaN        NaN  
2                NaN             NaN   NaN     NaN        NaN        NaN  
3                NaN             NaN   NaN     NaN        NaN        NaN  
4                NaN             NaN   NaN     NaN        NaN        NaN  
5  Tishomingo County         Belmont    MS     USA  34.491667 -88.201111  
6        Gragg-Wade          Clanton    AL     USA  32.850487 -86.611453  
7            Capitol      Brookfield    WI     USA  43.087510 -88.177869  
8  Columbiana County  East Liverpool    OH     USA  40.673313 -80.641406  
9   Memphis Memorial         Memphis    MO     USA  40.447259 -92.226961  
</pre>

## Further Reading
- [Cardinality](https://en.wikipedia.org/wiki/Cardinality_(data_modeling))
- [Join Types](https://en.wikipedia.org/wiki/Join_(SQL))
- Pandas function documentation:
    - [join()](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.join.html)
    - [merge()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.merge.html)
    - [concat()](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.concat.html)