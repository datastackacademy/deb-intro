# Ch. 1, Ep. 4: More Python Practice

## Episode Resources:
- [Dates and Times](01-dates_and_times.ipynb) (notebook)
- [Debugging](02-debugging.ipynb) (notebook)

This episode gives you a chance for additional Python practice by introducing two new topics: date and time data, and debugging. 

## Dates and Times

One of the most common data types you will be interacting with as a data engineer is temporal data. This can range from timestamps showing when records were created, to a date telling when a book was published, to a range of time for which a process was running. Because of the prevalence of temporal data, Python has an entire library to handle date and time data, called `datetime`. To import a python library, we just need to do the following:

```python
import datetime
```

Using this library, let's create our first `datetime` object using the `datetime.datetime.now()` method:

```python
current_time = datetime.datetime.now()
print(current_time)
print(type(current_time))
```

Output:
<pre>
2021-04-23 09:53:36.492874
&lt;class 'datetime.datetime'&gt;
</pre>

As we can see from the print statements, this creates a datetime class object with the time in the current timezone. This illustrates one of the first issues with a `datetime`: timezones. Python tends to default to the local timezone in functions, but one must always check the documentation or specify a `datetime.tzone` object to verify behavior; awareness of timezone is the first step to not being tripped up when times do not line up as expected. One important timezone for us to consider is Universal Coordinated Time or UTC. This is the standard reference timezone from which all others can be calculated as a difference. If we would like the current time in UTC, we can use the `utcnow` method of `datetime`:

```python
current_time = datetime.datetime.now()
utc_current_time = datetime.datetime.utcnow()
print(f"Local time is{current_time}")
print(f"But UTC time is {utc_current_time}")
```
Output:
<pre>
Local time is2021-04-23 10:01:29.487813
But UTC time is 2021-04-23 17:01:29.487848
</pre>

If we would like to create a `datetime` object for a specific time, we can use the `datetime.datetime()` method:

```python
new_years = datetime.datetime(2021, 1, 1)
print(new_years)
```
Output:
<pre>
2021-01-01 00:00:00
</pre>

Until now we've been printing the full datetime object. But we can also print specific fields which are stored as attributes of the class:

```python
current_time = datetime.datetime.now()
print(current_time.day)
print(current_time.second)
print(current_time.tzinfo)
```
Output:
<pre>
23
5
None
</pre>


In addition to printing the specific attributes of a `datetime`, we often want to create a specific `str` representation of the time. To do this we use the `strftime()` method of a `datetime` object. This method takes a single argument, a formatting `str` with the desired output format for the date `str`. A handy reference guide for the format can be [found here](https://strftime.org/). For example, if we want to return a string with the format `month_name day, full_year` we would use the formatting `str`: `"%B %d, %Y"`:

```python
print(current_time.strftime("%B %d, %Y"))
```
Output:
<pre>April 23, 2021</pre>

We can also use these formatting strings to create `datetime` objects from `str` input, a very common data engineering task. To do this, we need an input `str` and a formatting `str` telling us how to interpret the input. Let's read in a date in the same format that we just printed:

```python
date_format =  "%B %d, %Y"
first_of_may = datetime.datetime.strptime("May 1, 2020", date_format)
print(first_of_may, type(first_of_may))

# and now let's try a different format:
new_format = "%Y-%m-%d %H:%M:%S"
feb_29 = datetime.datetime.strptime("2020-02-29 10:04:31", new_format)
print(feb_29)
```
Output:
<pre>
2020-05-01 00:00:00 &lt;class 'datetime.datetime'&gt;
2020-02-29 10:04:31
</pre>

#### Time and Date
In additon to the combined datetime class we've been exploring, `datetime` also has separate `time` and `date` classes which contain just the specified portions of temporal data. 

### Time deltas
Dates and times are great for capturing when events occured, but we often also want to know how much time passes between events. This is where the `timedelta` object comes in. The quickest was to see how these work is simply use the `-` operator between two `datetime` objects:

```python
jan_first = datetime.datetime(2021, 1, 1)
year_so_far = datetime.datetime.now() - jan_first
print(year_so_far)
print(type(year_so_far))
```
Output:
<pre>
116 days, 13:27:25.031352
&lt;class 'datetime.timedelta'&gt;
</pre>

We can also create `timedelta` objects directly using the `datetime.timedelta` class constructor. Let's make a timedelta of 1 day and then add it to `jan_first` and see how it behaves:

```python
day_delta = datetime.timedelta(days=1)
print(day_delta, type(day_delta))
jan_two = jan_first + day_delta
print(jan_two, type(jan_two))
print(jan_two + day_delta)
```
Output:
<pre>
1 day, 0:00:00 &lt;class 'datetime.timedelta'&gt;
2021-01-02 00:00:00 &lt;class 'datetime.datetime'&gt;
2021-01-03 00:00:00
</pre>

As you can see, adding a `timedelta` to a `datetime` results in another `datetime` object. This behavior makes it straightforward to use `timedelta`s to increment `datetime`s.

### Book datetime
Let's put this new knowledge to use by updating our `Book` class. We can now add a published year to our `__init__()` function that can accept either a `str`, an `int`, or a `datetime` object:

```python
class Book:
    def __init__(self, title, author, genre, pub_year=None):
        self.title = title
        self.author = author
        self.genre = genre
        if isinstance(pub_year, datetime.datetime):
            self.pub_year = pub_year
        elif isinstance(pub_year, str):
            self.pub_year = datetime.datetime.strptime(pub_year, "%Y")
        elif isinstance(pub_year, int):
            self.pub_year = datetime.datetime(year=pub_year, month=1, day=1)
        else:
            self.pub_year = pub_year
    
    def have_you_read(self):
        print(f"Have you read {self.title} by {self.author}?")
    
    def was_published(self):
        print(f"{self.title} was published in {self.pub_year.year}")
```

We can also use our knowledge of `datetime` objects to create a subclass of `Book`, `LibraryBook` that has an attribute for when it is checked out, its due date (default loan length of 30 days), and a function that returns how long the book has been checked out for:

```python
class LibraryBook(Book):
    def __init__(self, title, author, genre, pub_year=None, checked_out=None, loan_length=None):
        super().__init__(title, author, genre, pub_year)
        if isinstance(checked_out, datetime.datetime):
            self.checked_out = checked_out
        else:
            self.checked_out = datetime.datetime.now()
        if isinstance(loan_length, datetime.timedelta):
            self.due_date = self.checked_out + loan_length
        else:
            self.due_date = self.checked_out + datetime.timedelta(days=30)
    def on_loan(self):
        cur_dur = datetime.datetime.now() - self.checked_out
        print(f"{self.title} has been on loan for {cur_dur}")
```

```python
from time import sleep
runaway_ralph = LibraryBook("Runaway Ralph", "Beverly Cleary", "Children's Novel", 1970)
runaway_ralph.have_you_read()
runaway_ralph.was_published()
runaway_ralph.on_loan()
sleep(5)
runaway_ralph.on_loan()
```
Output:
<pre>
Have you read Runaway Ralph by Beverly Cleary?
Runaway Ralph was published in 1970
Runaway Ralph has been on loan for 0:00:00.000513
Runaway Ralph has been on loan for 0:00:05.003152
</pre>

Sometimes it is useful to convert a `datetime` into a number of seconds. Here's an example of how to do that. First we initialize a string containing only a time (not a date). When we convert to a datetime representation, a default date (1/1/1900) gets added automatically. To convert the original time to a number of seconds, we have to remove the date portion from `date_time`. Then, we can call `total_seconds()` on the resulting `timedelta` to get a number of seconds represented by our original time string:

```python
# initialize a time string
time_string = "12:01:27"

# convert to datetime representation
date_time = datetime.datetime.strptime(time_string, "%H:%M:%S")
print(date_time)

#remove years, months, and days so only time (not date) is left
a_timedelta = date_time - datetime.datetime(1900, 1, 1)
seconds = a_timedelta.total_seconds()
print(seconds)
```
Output:
<pre>
1900-01-01 12:01:27
43287.0
</pre>

# Python Debugging

As a programmer and data engineer, you will often encounter unexpected behavior from your code, and will need to be able to diagnose the problem and find a solution. That process, of finding and resolving errors (bugs) in your program, is called *debugging*. Debugging is part art and part science - sometimes correcting program errors can be surprisingly difficult. We will only discuss the basics of Python debugging here, but if you are interested to learn more, see the additional links at the bottom of this document. 

## Common Errors

First, let's take a look at some of the most commonly encountered errors.

### Syntax Error

Syntax errors result from things like missing colons or parentheses, or incorrect use of white space. Here's an example of forgetting a colon at the end of a line in a function definition, which will generate a `SyntaxError`:

```python
def hello_world()
    message = "Hello, world!"
    print(message)
     return message
```

Output:
<pre>
  File "/var/folders/p7/1230cnn96dl9pk5c3fbjl5y00000gn/T/ipykernel_98273/92591035.py", line 1
    def hello_world()
                     ^
SyntaxError: invalid syntax
</pre>

Syntax errors are usually easy to correct, but can sometimes be tricky. In the next example, we have corrected the problem with the missing colon, but now there is a different issue with the code:

```python
def hello_world():
	message = "Hello, World!!"
	print(message)
        return message
```

Output:
<pre>
  File "/var/folders/p7/1230cnn96dl9pk5c3fbjl5y00000gn/T/ipykernel_98273/4101766056.py", line 4
    return message
                  ^
TabError: inconsistent use of tabs and spaces in indentation
</pre>

The Python interpreter helpfully tells us the problem (inconsistent use of tabs and spaces). But this error is not quite as straightforward, because the location given in the traceback (the end of the return statement line) is not the actual location of the tab error. And it is not obvious where the mixed tabs and spaces are, because they both look the same to our eye, even though the underlying character representation of what we see is not the same. The fallback when fixing these sorts of errors is to go through your code line by line in the region of the error, delete the whitespace, and correct the indentation, keeping your use of tabs (or spaces, whichever you pick) consistent.

<br>

### Name Error

A `NameError` occurs when you try to use a variable that has not been defined yet, and thus does not exist in your Python namespace. Let's take a look:

```python
# my_new_variable is not defined, so we get a NameError
print(my_new_variable)
```

Output:
<pre>
NameError                                 Traceback (most recent call last)
/var/folders/p7/1230cnn96dl9pk5c3fbjl5y00000gn/T/ipykernel_98273/1110381204.py in <module>
      1 # a is not define, so we get a NameError
----> 2 print(my_new_variable)

NameError: name 'my_new_variable' is not defined
</pre>

### IndexError

Another common error type is the `IndexError`. This occurs when we try to access an element in a list or other object with an index that is out of range:

```python
my_list = range(10)

my_list[11]
```

Output:
<pre>
---------------------------------------------------------------------------
IndexError                                Traceback (most recent call last)
/var/folders/p7/1230cnn96dl9pk5c3fbjl5y00000gn/T/ipykernel_9734/1408825302.py in <module>
      1 my_list = range(10)
      2 
----> 3 my_list[11]

IndexError: range object index out of range
```
</pre>


The easiest and most common debugging method in Python does not involve any special tools - we have been using it already throughout this tutorial. Whenever your code generates an error, the Python interpreter will automatically print out a [traceback](https://realpython.com/python-traceback/) (or *stack trace*), showing you details of the error and where exactly in your code it was produced. Let's take a look at another common error (division by zero) to see:

```python
a = 0
print(1/a)
```

Output:
<pre>
---------------------------------------------------------------------------
ZeroDivisionError                         Traceback (most recent call last)
/var/folders/p7/1230cnn96dl9pk5c3fbjl5y00000gn/T/ipykernel_98273/1992888086.py in <module>
      1 a = 0
----> 2 print(1/a)

ZeroDivisionError: division by zero
</pre>

We can see that the interpreter helpfully points to the exact line of code that generated the error and gives an error message that helps us diagnose the problem.

## Debugging with pdb

Another tool that is included in Python's standard library is *pdb*, the Python debugger. This debugger will let you step through program execution and examine program behavior in detail when you are trying to fix errors.

There are a couple of ways to set a *breakpoint*, which is a point in the program where the interpreter will halt execution, allowing the programmer to check variable values or otherwise examine program behavior in more detail.

The more traditional way uses the `set_trace()` method included with pdb. The other way uses the `breakpoint()` function which is built into Python as of version 3.7.

```
### breakpoint using set_trace()
import pdb; pdb.set_trace()

### breakpoint using breakpoint() (the newer way)
breakpoint()
```

Notice that we do not require an import, or attach a prefix to the function name, to use breakpoint(). Python 3.7 incorporated this function in the standard library.

Here's an example of using `breakpoint()` to invoke the debugger and print out the value of a variable. For this example, let's create a file called `example1.py` which contains the following code:

```python
filename = __file__
import pdb; pdb.set_trace()
print(f'path = {filename}')
```

```bash
python example1.py
```

If we call the python interpreter on the example1.py file, it will halt execution after the first line and enter debugging mode:

```bash
> /Users/myuser/Desktop/example1.py(3)<module>()
-> print(f'path = {filename}')
(Pdb) 
```

Now, if you enter `p filename` at the prompt, the debugger will print the value of the variable (in this case, `filename`):

Output:
<pre>
(Pdb) p filename
'/Users/myuser/Desktop/example1.py'
(Pdb)
</pre>

This is very useful for examing programming behavior in detail. If you are trying to track down the source of an error, you can set breakpoints in your code and take a close look at what is going on in your program at a particular point. Especially with difficult-to-diagnose errors, this can be much more helpful than simply using `print()` to print out variable values, which can get quite messy.

There's another useful feature of pdb besides the ability to set breakpoints. Once you have set a breakpoint and stopped program execution, you can the `n` and `s` commands to execute your program one line at a time:
- `n`: continue execution until the next line and 'step over' any foreign functions (i.e., do not stop in a foreign function if one is called)
- `s`: execute the current line and 'step into' a foreign function if one is called
This allows us to walk through our code, one line at a time. We can check our variables as we go, using `p` as before, allowing us to know the exact state of our code before the line that generates the error. This can also be very helpful if our code is not failing but _is_ producing unexpected results. We can use the debugger to see how the variables change from line to line.

## Exception Handling

As a programmer, you should obviously strive to make your code as error-free as possible. But even in the best code, there will sometimes still be unexpected behavior that causes errors. Python, like most programming languages, provides us a mechanism for handling exceptions so that they do not crash our program. The `try` and `except` block will do this for us.

```python
# demonstration of handling an exception
try:
    with open('nonexistentfile.txt', 'r') as f:
        data = f.read()
except:
    print("The file could not be found.")

print("The program keeps executing.")
```

Output:
<pre>
The file could not be found.
The program keeps executing.
</pre>

Notice that instead of throwing an exception and halting, the interpreter handles the exception by executing the code in the `except` block, and continues to run. We can display an error message to the user and prompt them to specify another file. Use a `try` and `except` block anywhere you have code that you believe will throw an exception (such as file operations, OS-specific code, etc.).
We can also except specific types of errors in our `except` clause. For example, we could specifically `except` the error associated with not finding a file:
```python
# demonstration of handling an FileNotFoundError exception
try:
    with open('nonexistentfile.txt', 'r') as f:
        data = f.read()
except FileNotFoundError as E:
    print(E.message)
    print("The file could not be found.")
print("The program keeps executing.")
### Further Reading
- [Understanding the Python Traceback](https://realpython.com/python-traceback/)
- [pdf - The Python Debugger](https://docs.python.org/3/library/pdb.html)  (python.org)
- [Python debugging in VSCode](https://code.visualstudio.com/docs/python/debugging) (visualstudio.com)
- [Debugging and Profiling](https://docs.python.org/3/library/debug.html) (python.org)
- [Python Built-in Exceptions](https://docs.python.org/3/library/exceptions.html)
- [Python breakpoint() docs](https://www.python.org/dev/peps/pep-0553/)