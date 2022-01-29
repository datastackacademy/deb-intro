# Ch. 1, Ep. 9: Data Cleaning

## Episode Resources:
- [Data Transformations](01_transformations.ipynb)
- [Data Cleaning](02_data_cleaning.ipynb)

In this episode we will discuss data transformations using map functions, and data cleaning.

## Transformations

When working with data, you will often need to apply transformations, in order to make the data more consistent, more usable, easier to understand, or to meet any number of other criteria. Pandas provides a number of functions to make this process easier.

### `Map()`: Single-Column Transformations

Pandas has a number of handy functions that can be used for applying transformation rules to columns. The simplest method is to apply a `map()` function to transform values within a column.

We notice that in our airline data, each airline is represented by short codes such as 'AA'. There's nothing wrong with that, but they're not very readable. What if we want to map those short codes to full airline names, so that the data is easier to understand? Pandas provides a `map()` function that makes this sort of thing easy.

```python
import pandas as pd

# read data fom csv
data_dir = '../../../data/input/ch1/'
routes_file = data_dir + 'routes.csv'
routes = pd.read_csv(routes_file, header=0)

def decode_airline(value:str):
    mapper = {
        'AA': 'American Airlines', 
        'AS': 'Alaska Airlines', 
        'DL': 'Delta Air Lines',
        'UA': 'United Airlines', 
        'WN': 'Southwest Airlines',
    }
    if value in mapper:
        return mapper[value]
    else:
        return 'Other'

# decode airline names and assign to a new column
routes['airline_name'] = routes.airline.map(decode_airline)

# print decoded flights
routes.loc[routes.airline_name != 'Other'][['airline', 'airline_name', 'src', 'dest','stops']]
```

Output:
<pre>
	airline	airline_name	src	dest	stops
4654	AA	American Airlines	ABE	CLT	0
4655	AA	American Airlines	ABE	PHL	0
4656	AA	American Airlines	ABI	DFW	0
4657	AA	American Airlines	ABQ	DFW	0
4658	AA	American Airlines	ABQ	LAX	0
...	...	...	...	...	...
64556	WN	Southwest Airlines	TUS	DEN	0
64557	WN	Southwest Airlines	TUS	LAS	0
64558	WN	Southwest Airlines	TUS	LAX	0
64559	WN	Southwest Airlines	TUS	MDW	0
64560	WN	Southwest Airlines	TUS	SAN	0
8191 rows × 5 columns
</pre>

Notice that our mapper function simply uses a dictionary, with the airline short codes as keys and the full names as values. That makes it easy to get the full airline name from a shortcode, by simply indexing the dictionary with the short code (`mapper[value]'). The last line above uses `.loc` to filter out records that cannot be mapped to an airline name. 

Let's practice more to get familiar with using `map()` effectively. The following function simply converts the `stops` column to a floating-point value:

```python
# use lambda functions as map
routes.stops = routes.stops.map(lambda v: float(v))

print(routes.head(5))
```

Output:
<pre>
  airline  src dest codeshare  stops equipment airline_name
0      2B  ASF  KZN       NaN    0.0       CR2        Other
1      2B  ASF  MRV       NaN    0.0       CR2        Other
2      2B  CEK  KZN       NaN    0.0       CR2        Other
3      2B  CEK  OVB       NaN    0.0       CR2        Other
4      2B  DME  KZN       NaN    0.0       CR2        Other
</pre>

### `applymap`
The `map()` function we have been using is a built-in function of `Series` objects. There is a similar built-in function of `DataFrame`s: `applymap()`. The behavior is similar but the input and output are `DataFrame`s instead of series:

```python
# read data fom csv
data_dir = '../../../data/input/ch1/'
routes_file = data_dir + 'routes.csv'
routes = pd.read_csv(routes_file, header=0)

# use applymap with our decode_airline function
routes[['airline_name']] = routes[['airline']].applymap(decode_airline)
routes[['stops']] = routes[['stops']].applymap(lambda v: float(v))
# print decoded flights
routes.loc[routes.airline_name != 'Other'][['airline', 'airline_name', 'src', 'dest', 'stops']]
```

Output:
<pre>

airline	airline_name	src	dest	stops
4654	AA	American Airlines	ABE	CLT	0.0
4655	AA	American Airlines	ABE	PHL	0.0
4656	AA	American Airlines	ABI	DFW	0.0
4657	AA	American Airlines	ABQ	DFW	0.0
4658	AA	American Airlines	ABQ	LAX	0.0
...	...	...	...	...	...
64556	WN	Southwest Airlines	TUS	DEN	0.0
64557	WN	Southwest Airlines	TUS	LAS	0.0
64558	WN	Southwest Airlines	TUS	LAX	0.0
64559	WN	Southwest Airlines	TUS	MDW	0.0
64560	WN	Southwest Airlines	TUS	SAN	0.0
8191 rows × 5 columns
</pre>

### `Apply()`: Multi-Column Transformations

While the `.map()` method allows transformation over a single column, pandas DataFrame `.apply()` method allows transformation over multiple column values. You can use `.apply()` when you need to transform more than one column within a row.

In the following example, we create an `encode_route_key()` method which concatenates airline, src, and dest fields  to create a unique route key for each row:

```python
import pandas as pd

# read data fom csv
data_dir = '../../../data/input/ch1/'
routes_file = data_dir + 'routes.csv'
routes = pd.read_csv(routes_file, header=0)

def encode_route_key(row):
    # a dataframe row is passed. access columns with row.column_name
    route_key = f"{row.airline}-{row.src}-{row.dest}"

    return route_key

# apply a function over entire row values
# set axis=1 to apply function over rows. axis=0 would apply over columns
routes['route_key'] = routes.apply(encode_route_key, axis=1)
routes['route_key']
```

```python
0        2B-ASF-KZN
1        2B-ASF-MRV
2        2B-CEK-KZN
3        2B-CEK-OVB
4        2B-DME-KZN
            ...    
67657    ZL-WYA-ADL
67658    ZM-DME-FRU
67659    ZM-FRU-DME
67660    ZM-FRU-OSS
67661    ZM-OSS-FRU
Name: route_key, Length: 67662, dtype: object
```

Pay attention to the `axis=1` argument for `apply()`, which directs Pandas to apply the function horizontally over row values. `axis=0` directs pandas to apply a function vertically to all column values. Please refer to [DataFrame.apply](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.apply.html) documentation for more information.

Pandas passes the row values as the first parameter to the apply function. You can use the `args` parameter if your function requires more parameters. For example:

```python
import pandas as pd

# read data fom csv
data_dir = '../../../data/input/ch1/'
routes_file = data_dir + 'routes.csv'
routes = pd.read_csv(routes_file, header=0)

# passing more parameters to apply function by position

def encode_route_key(row, key_type):
    # a dataframe row is passed. access columns with row.column_name
    if key_type == "short":
        route_key = f"{row.airline}-{row.src}-{row.dest}"
    else:
        route_key = f"{row.airline}-{row.src}-{row.dest}-{row.stops}-{row.equipment}"
    return route_key

# apply a function over entire row values
# set axis=1 to apply function over rows. axis=0 would apply over columns
routes['route_key'] = routes.apply(encode_route_key, axis=1, args=("short",))
routes['route_key_long'] = routes.apply(encode_route_key, axis=1, args=("long",))
routes[['route_key', 'route_key_long']]
```

Output:
<pre>

route_key	route_key_long
0	2B-ASF-KZN	2B-ASF-KZN-0-CR2
1	2B-ASF-MRV	2B-ASF-MRV-0-CR2
2	2B-CEK-KZN	2B-CEK-KZN-0-CR2
3	2B-CEK-OVB	2B-CEK-OVB-0-CR2
4	2B-DME-KZN	2B-DME-KZN-0-CR2
...	...	...
67657	ZL-WYA-ADL	ZL-WYA-ADL-0-SF3
67658	ZM-DME-FRU	ZM-DME-FRU-0-734
67659	ZM-FRU-DME	ZM-FRU-DME-0-734
67660	ZM-FRU-OSS	ZM-FRU-OSS-0-734
67661	ZM-OSS-FRU	ZM-OSS-FRU-0-734
67662 rows × 2 columns
</pre>

### Complex

The section below shows an example where we apply a function over multiple columns which produces multiple columns in a DataFrame. 

In this example, we will produce two new columns called "nonstop" and "loop" depending on if there are no stops and if the `src` is also the `dest`.

```python
routes[routes.src == routes.dest]
```

Output:
<pre>
	airline	src	dest	codeshare	stops	equipment	route_key	route_key_long
33275	IL	PKN	PKN	NaN	0	AT7	IL-PKN-PKN	IL-PKN-PKN-0-AT7
</pre>

```python
import pandas as pd

# read data fom csv
data_dir = '../../../data/input/ch1/'
routes_file = data_dir + 'routes.csv'
routes = pd.read_csv(routes_file, header=0)

def encode_route_type(row):
    # nonstop: stops = 0
    # loop: src == dest
    nonstop = row.stops == 0
    loops = row.src == row.dest
    # return as a tuple
    return (nonstop, loops)


# apply a function over row values and
# unpack multiple return column values by using zip()
routes['nonstop'], routes['loop'] = zip(*routes.apply(
    encode_route_type, axis=1
))

# print
print(routes.loc[routes.nonstop == True])
print(routes.loc[routes.loop == True])
```

Output:
<pre>
      airline  src dest codeshare  stops equipment  nonstop   loop
0          2B  ASF  KZN       NaN      0       CR2     True  False
1          2B  ASF  MRV       NaN      0       CR2     True  False
2          2B  CEK  KZN       NaN      0       CR2     True  False
3          2B  CEK  OVB       NaN      0       CR2     True  False
4          2B  DME  KZN       NaN      0       CR2     True  False
...       ...  ...  ...       ...    ...       ...      ...    ...
67657      ZL  WYA  ADL       NaN      0       SF3     True  False
67658      ZM  DME  FRU       NaN      0       734     True  False
67659      ZM  FRU  DME       NaN      0       734     True  False
67660      ZM  FRU  OSS       NaN      0       734     True  False
67661      ZM  OSS  FRU       NaN      0       734     True  False

[67651 rows x 8 columns]
      airline  src dest codeshare  stops equipment  nonstop  loop
33275      IL  PKN  PKN       NaN      0       AT7     True  True
</pre>

# Data Cleaning

Data cleaning is an important part of data engineering, because often your raw data will be somewhat messy, and you will need to perform some initial processing of data sources before you begin building your pipeline. Cleaning your data is usually the next step after your initial exploratory data analysis. That initial exploration will give you an overview of your data, and highlight issues that you might need to address with some cleaning steps before moving on to using that data in a pipeline.

For this episode's example we will use the [`deb-aircraft.csv`](../../../data/input/ch3/deb-aircraft.csv) file from the [chapter 3 data](../../../data/input/ch3/). This file is a good place to illustrate recommended data cleaning procedure, because it has a lot of rows and columns, and also has a lot of missing values.

```python
import pandas as pd
```

```python
data_dir = '../../../data/input/ch3/'
aircraft_file = data_dir + 'deb-aircrafts.csv'
aircraft = pd.read_csv(aircraft_file, header=0)
```

```python
print(aircraft.head())
print(aircraft.shape)
```

Output:
<pre>
  n_number serial_number mfr_mdl_code  eng_mfr_mdl  mfr_year registrant_type  \
0     N100          5334      7100510      17003.0      1940      Individual   
1   N10001           A28      9601202      67007.0      1928      Individual   
2   N10002        79-030      8930105      41525.0      1979     Corporation   
3   N10003             1      056336T          NaN        -1      Individual   
4   N10004     T18208245      2072738          NaN        -1             LLC   

       registrant_name            street street2         city  ...  \
0                  NaN               NaN     NaN      KETCHUM  ...   
1                  NaN               NaN     NaN     LAKELAND  ...   
2  ENGLISH AIR SERVICE  3409 CORSAIR CIR     NaN  SANTA MARIA  ...   
3                  NaN               NaN     NaN    SALISBURY  ...   
4         ETOS AIR LLC               NaN     NaN   NEW LONDON  ...   

              aircraft_type num_engines num_seats weight_class speed  \
0  Fixed wing single engine           1         2      CLASS 1    67   
1  Fixed wing single engine           1         3      CLASS 1    79   
2                Rotorcraft           1         1      CLASS 1     0   
3  Fixed wing single engine           1         2      CLASS 1     0   
4  Fixed wing single engine           1         4      CLASS 1     0   

  eng_mfr_name      eng_model       eng_type horsepower thrust  
0   CONT MOTOR   A&C65 SERIES  Reciprocating       65.0    0.0  
1       WRIGHT     WWJ SERIES  Reciprocating      220.0    0.0  
2     LYCOMING  VO-435 SERIES  Reciprocating      260.0    0.0  
3          NaN            NaN            NaN        NaN    NaN  
4          NaN            NaN            NaN        NaN    NaN  

[5 rows x 32 columns]
(288116, 32)
</pre>

At first glance, we can see that the `street` and `street2` columns have a lot of empty values. Since there are so many missing values, and these columns are probably of ancillary importance to someone who is using the data to make a business decision, let's remove those columns from our `DataFrame`. Pandas makes this easy with the `drop()` function:

```python
# prepare the list of columns to be dropped
drop_cols = ['street','street2']
aircraft.drop(drop_cols, inplace=True, axis=1)

# print the updated DataFrame
aircraft.head(10)
```

Output:
<pre>
  n_number serial_number mfr_mdl_code  eng_mfr_mdl  mfr_year registrant_type  \
0     N100          5334      7100510      17003.0      1940      Individual   
1   N10001           A28      9601202      67007.0      1928      Individual   
2   N10002        79-030      8930105      41525.0      1979     Corporation   
3   N10003             1      056336T          NaN        -1      Individual   
4   N10004     T18208245      2072738          NaN        -1             LLC   

       registrant_name         city state zip_code  ...  \
0                  NaN      KETCHUM    OK    74349  ...   
1                  NaN     LAKELAND    FL    33802  ...   
2  ENGLISH AIR SERVICE  SANTA MARIA    CA    93455  ...   
3                  NaN    SALISBURY    NC    28146  ...   
4         ETOS AIR LLC   NEW LONDON    TX    75682  ...   

              aircraft_type num_engines num_seats weight_class speed  \
0  Fixed wing single engine           1         2      CLASS 1    67   
1  Fixed wing single engine           1         3      CLASS 1    79   
2                Rotorcraft           1         1      CLASS 1     0   
3  Fixed wing single engine           1         2      CLASS 1     0   
4  Fixed wing single engine           1         4      CLASS 1     0   

  eng_mfr_name      eng_model       eng_type horsepower thrust  
0   CONT MOTOR   A&C65 SERIES  Reciprocating       65.0    0.0  
1       WRIGHT     WWJ SERIES  Reciprocating      220.0    0.0  
2     LYCOMING  VO-435 SERIES  Reciprocating      260.0    0.0  
3          NaN            NaN            NaN        NaN    NaN  
4          NaN            NaN            NaN        NaN    NaN  

[5 rows x 30 columns]
</pre>

Now we can see that the `street` and `street2` columns have been removed from our `aircraft` DataFrame. 

Another issue that we can see with our data is that the `thrust` column is also somewhat messy. Some of the entries are empty, some contain zeros, and some contain meaningful values. Let's replace the `NaN`s with zeros, using the `fillna()` function, so that the unrecorded values are consistent:

```python
# replace NaNs with 0s using fillna()
aircraft['thrust'] = aircraft['thrust'].fillna(0)

print(aircraft.head())
```

Output:
<pre>
  n_number serial_number mfr_mdl_code  eng_mfr_mdl  mfr_year registrant_type  \
0     N100          5334      7100510      17003.0      1940      Individual   
1   N10001           A28      9601202      67007.0      1928      Individual   
2   N10002        79-030      8930105      41525.0      1979     Corporation   
3   N10003             1      056336T          NaN        -1      Individual   
4   N10004     T18208245      2072738          NaN        -1             LLC   

       registrant_name         city state zip_code  ...  \
0                  NaN      KETCHUM    OK    74349  ...   
1                  NaN     LAKELAND    FL    33802  ...   
2  ENGLISH AIR SERVICE  SANTA MARIA    CA    93455  ...   
3                  NaN    SALISBURY    NC    28146  ...   
4         ETOS AIR LLC   NEW LONDON    TX    75682  ...   

              aircraft_type num_engines num_seats weight_class speed  \
0  Fixed wing single engine           1         2      CLASS 1    67   
1  Fixed wing single engine           1         3      CLASS 1    79   
2                Rotorcraft           1         1      CLASS 1     0   
3  Fixed wing single engine           1         2      CLASS 1     0   
4  Fixed wing single engine           1         4      CLASS 1     0   

  eng_mfr_name      eng_model       eng_type horsepower thrust  
0   CONT MOTOR   A&C65 SERIES  Reciprocating       65.0    0.0  
1       WRIGHT     WWJ SERIES  Reciprocating      220.0    0.0  
2     LYCOMING  VO-435 SERIES  Reciprocating      260.0    0.0
show more (open the raw output data in a text editor) ...

2     LYCOMING  VO-435 SERIES  Reciprocating      260.0    0.0  
3          NaN            NaN            NaN        NaN    0.0  
4          NaN            NaN            NaN        NaN    0.0  
</pre>

Another common cleaning operation is to drop duplicate rows. If we want to see whether any rows are duplicated, we can use the `duplicated()` method on our DataFrame. In this case, there are no duplicate entries, at least not when comparing across all columns (more on that in a minute). If you do need to remove duplicates, Pandas provides a handy `drop_duplicates()` function. 

```python
print(aircraft.duplicated())

# if you need to remove duplicates, use drop_duplicates()
aircraft.drop_duplicates()
```

Output:
<pre>
n_number
N100      False
N10001    False
N10002    False
N10003    False
N10004    False
          ...  
N9ZS      False
N9ZT      False
N9ZU      False
N9ZV      False
N9ZX      False
Length: 288116, dtype: bool
         serial_number mfr_mdl_code  eng_mfr_mdl  mfr_year registrant_type  \
n_number                                                                     
N100              5334      7100510      17003.0      1940      Individual   
N10001             A28      9601202      67007.0      1928      Individual   
N10002          79-030      8930105      41525.0      1979     Corporation   
N10003               1      056336T          NaN        -1      Individual   
N10004       T18208245      2072738          NaN        -1             LLC   
...                ...          ...          ...       ...             ...   
N9ZS             20004      5760102          0.0      1974      Individual   
N9ZT              0088      2130001      17042.0      2001     Corporation   
N9ZU           18-7028      7101828      41508.0      1959      Individual   
N9ZV              3793      1181511       3020.0      1984             LLC
show more (open the raw output data in a text editor) ...

N9ZU      Reciprocating      180.0    0.0  
N9ZV         Turbo-prop      420.0    0.0  
N9ZX      Reciprocating        0.0    0.0  

[288116 rows x 31 columns]
</pre>

Notice from the output and row counts above that when using the default behavior of `drop_duplicates()` (which is to compare across all columns), there are no duplicate rows in our data. While there may not be any duplicates when we compare records according to all of the columns, `drop_duplicates()` gives us a way to filter out duplicates according to more detailed criteria. In particular, we can pass a list of columns using the `subset` argument, and `drop_duplicates()` will check for duplicates only on those specific columns. 

Let's suppose that, for some regulatory purpose, we need to produce a recordset containing one aircraft from every airline in each ZIP code, and that only contains corporate (and not individual) registrants. We can do this easily with `drop_duplicates` using `subset`. 

First, though, we need to use `dropna()` to drop records with a `NaN` value for the `registry_name`. This will leave only corporate registrants. Then, we can apply `drop_duplicates()` specifying `registrant_name` and `zip_code` as the subset.

```python
# drop individual registrants
aircraft.dropna(subset=['registrant_name'], inplace=True)

# remove duplicate registrants within each ZIP code
aircraft.drop_duplicates(subset=['registrant_name', 'zip_code'], keep='last').iloc[: , :15].head(10)
```

Output:
<pre>
   n_number  serial_number mfr_mdl_code  eng_mfr_mdl  mfr_year  \
9    N1000E       550-1011      2076604      52065.0      2002   
16   N1000Q       310P0195      2074238      17027.0        -1   
20   N1000V           0660      2130001      17042.0      2003   
21   N1000W  CCX-2300-0017      05639MP          NaN        -1   
33   N1001D           7609      2073110      35003.0      1950   
35   N1001F          79033      8930105      42200.0      1979   
37   N1001K     F-16-07-01      060005B      55593.0      2017   
44   N1001W          60208      05620P0      41594.0      2006   
49   N10025            165      8141104      52008.0      1957   
54   N1002G        27-0295      5870222      41533.0      2000   

   registrant_type          registrant_name           city state zip_code  \
9      Corporation               WR HESS CO  OKLAHOMA CITY    OK    73119   
16             LLC               N1000Q LLC        OAKLAND    CA    94605   
20             LLC                  1KV LLC     WILMINGTON    DE    19810   
21             LLC        SES OPERATING LLC        MIDLAND    TX    79702   
33             LLC     JMP & ASSOCIATES LLC     LOUISVILLE    KY    40241   
35     Corporation               AG AIR INC       CHEYENNE    WY    82001   
37             LLC                HORUS LLC          OMAHA    NE    68108   
44     Corporation       RIGHT DOWNWIND INC     ROPESVILLE    TX    79358   
49     Corporation           TRADE AYER INC         LINDEN    NJ    07036   
54             LLC  FLYING FOX AVIATION LLC    IDAHO FALLS    ID    83404   

                region country last_action_date  issue_date status  
9         Southwestern      US       2019-10-10  2016-02-16      V  
16     Western-Pacific      US       2018-08-02  2018-08-02      V  
20             Eastern      US       2019-05-14  2010-03-05      V  
21        Southwestern      US       2020-09-08  2020-09-08      V  
33             Central      US       2018-02-11  2007-10-22      V  
35  Northwest Mountain      US       2019-09-11  2019-09-11      V  
37             Central      US       2018-05-23  2018-05-23      V  
44        Southwestern      US       2018-09-18  2018-09-18      V  
49             Eastern      US       1977-01-14         NaN      N  
54  Northwest Mountain      US       2019-12-20  2017-05-22      V  
</pre>

Every dataset is different, and the exact procedure for cleaning your data will depend on what you find when you perform your initial exploratory analysis. Cleaning data will make your job, and that of the data scientists and analysts, easier, and add value to the process. 

### Further Reading
- [Pandas map() docs](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.map.html)
- [Pandas applymap() docs](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.applymap.html)
- [Pandas apply() docs](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.apply.html)
- [Difference between map(), applymap(), and apply() methods](https://stackoverflow.com/questions/19798153/difference-between-map-applymap-and-apply-methods-in-pandas)
- [Data Cleaning with Pandas and NumPy](https://realpython.com/python-data-cleaning-numpy-pandas/)