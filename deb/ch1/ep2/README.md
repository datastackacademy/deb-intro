# Ch. 1, Ep. 2: Python Collections, Loops and Iterators

## Episode Resources

This episode's code resources are all in notebook format:
1. [Lists](01-lists.ipynb)
1. [Dictionaries](02-dicts.ipynb)
1. [Tuples and Sets](03-tuples_sets.ipynb)
1. [Flow control (loops and conditionals)](04-loops_conditionals.ipynb)
1. [Functions](05-functions.ipynb)

Hopefully by now everyone has at least the Python portion of your development environment set up. Try downloading one of the above notebooks and make sure that you can open them locally in Jupyter (run `jupyter-lab` first). There is no additional setup needed for viewing the notebooks for this episode, and each of them will walk you through the concepts with code examples.

This episode looks in a bit more detail at the data types you will use most commonly as a data engineer, and also further explore using functions in Python. We will walk through the notebooks together in class.

## Collection data types

Python comes with four built-in collection data types: lists, tuples, sets, and dictionaries. First we will take a look at the list type.

### Lists

One of the most important and commonly used data types in Python is the list. Lists are ordered, mutable (changeable), and allow duplicates. They also allow mixing of types in the same list. Usually we declare a list with brackets (`[ ]`) with items separated by commas:

```python
my_first_list = [1, 3, 5]
```

We can put any type of item in a list, including another list. And we can mix data types within the same list. Let's see an example:

```python
my_second_list = ['Hello', 8, 4.5, my_first_list]
```

How do we access the individual items in a list once we have created it? There is more than one way, but let's look at the most common way of list indexing. Python, like many other languages, uses zero-indexing, so you can get the first element by using brackets and the number 0:

```python
my_first_list[0]
```

The following example shows accessing the last element in the two lists we have created:

```python
print(my_first_list[2])
print(my_second_list[3])
```

But what if we don't know the length of the list, but still need the last element? We will often encounter this situation when building lists dynamically, and when many changes are made after the list is created. In this case, we can use *negative indexing* to retrieve items from the end of a list:

```python
my_first_list[-1]
my_first_list[-2]
```

As we can see, using index `-1` gives us the last element in the list, and using the index `-2` gives us the second to the last element.

A common task when working with lists is to return the last element in the list and remove that element (for example, if we are processing the list and no longer need the items after we do something with each one). The [`pop()` list method](https://docs.python.org/3/tutorial/datastructures.html) will do this for us. Let's see it in action:


```python
my_first_list = [1, 3, 5]
last_item = my_first_list.pop()
print(last_item)
print(my_first_list)
first_item = my_first_list.pop(0)
print(first_item)
print(my_first_list)
```

As we can see, `pop()` gives us the last item in the last, then removes that item. If we do not specify an index, `pop()` returns the last item, or we can specify an index to return a particular item. In the code above, `pop(0)` returns and removes the first element in the list.

If we want to remove an item without returning the value we can use `return()`.

To add elements to a list, we can use the `append()` function. That function takes a single argument (the value to be appended), and places it in the last spot in the list. That change happens in-place, meaning that you do not have to use the `=` operator to place the new value into the list. Let's look at adding some values to `my_first_list`:

```python
my_first_list = [3]
my_first_list.append([5, 7, 9])
print(my_first_list)
my_first_list.pop()
my_first_list.append(5)
my_first_list.append(7)
my_first_list.append(9)
my_first_list

# also could use a for loop
my_first_list = [3]
for i in [5,7,9]:
    my_first_list.append(i)

print(my_first_list)
```

You may have noticed that if we try to append a list of numbers to an existing list, the list being appended remains as a three-item list, and goes in the last position. Another way to say this is that the whole list (`[5,7,9]`) becomes the second item in my_first_list, rather than the individual items in `[5,7,9]` each becoming a new item in my_first_list (in which case that list would contain four items). What if simply want to extend our existing list by the list `[5, 7, 9]`? Luckily, lists have a built in `extend()` method:

```python
my_first_list = [3]
my_first_list.extend([5, 7, 9])
my_first_list
```

How do we check to see if a list contains a particular item? Using the `in` membership operator will do that for us:

```python
my_first_list = [3, 5, 7, 9]
print(5 in my_first_list)
print(0 in my_first_list)
```

Finally, how do we put a list in order? Lists have an in-place `sort()` method which uses the `>` comparison operator

```python
unruly_list = [52, 32, 520, -40, 1]
unruly_list.sort()
print(unruly_list)
```

Be aware that `sort()` cannot be used to sort lists of mixed types, since they cannot be compared with the `>` operator.

<br>

**List slicing**

*Slicing* refers to accessing a range of elements in a list. It's something that you will do frequently as a data engineer, and that we will see in action a number of times later in the course. 

The basic syntax for slicing is `List[Initial:End:Jump]`. Given a list object, that expression will return the portion of the list from index `Initial` to but not including index `End`, at a step size of `Jump`. Note that `Jump` is optional - if you omit it, and just use `List[Initial:End]`, the interpreter will use a default step size of 1 and return the portion of the list between the `Initial` and `End` indexes.

Here are a few basic examples:

```python
# initialize a list
my_list = [10,20,30,40,50,60,70,80,90]

# example 1: display the whole list
# these two statements are equivalent, demonstrating that the Jump parameter is optional
print(my_list[::])
print(my_list[:])

# example 2: use jump size to show every other item
print(my_list[::2])

# example 3: display a portion of the list
print(my_list[3:6])

# use negative indexing to display list items, starting from the end
# example 4: display the whole list in reverse
print(my_list[::-1])
# example 5: in this case, we display the last 7 items
print(my_list[-7:])
# example 6: use a negative step size to traverse the list in reverse
print(my_list[-5::-1])

# if your slicing expression does not make sense, an empty list will be generated
# example 7: noncomputable slicing expression (index out of range)
print(my_list[10::2])
```

Output:
<pre>
[10, 20, 30, 40, 50, 60, 70, 80, 90]
[10, 20, 30, 40, 50, 60, 70, 80, 90]
[10, 30, 50, 70, 90]
[40, 50, 60]
[90, 80, 70, 60, 50, 40, 30, 20, 10]
[30, 40, 50, 60, 70, 80, 90]
[50, 40, 30, 20, 10]
[]
</pre>

The comments in the above code give you the details on each example. From these, we can see that Python provides an extremely concise and powerful list slicing syntax that makes it easy to get the items you need from a list, in the order you need them.

Notice that, in the last example, a nonsensical slicing expression returns an empty list. In this case, the list only contains 9 items, but we are using an index of 10, which is out of range. But when this happens with slicing expressions, the interpreter will NOT produce an error. It is important to be aware of this behavior, because in performing complex data manipulation, you might encounter a situation where subsequent operations which depend on your incorrectly formulated slicing expression do not give you the expected result, but the code runs without error.

We will see many more examples of list slicing when we get to Pandas and other topics in later chapters!

### Dictionaries

The second collection data type we will take a look at is the `Dictionary` type. Dictionaries are mutable (changeable) but (unlike lists) they do *not* allow duplicates. As of Python 3.7, dictionaries are now ordered. Whereas lists contain only the items themselves, dictionaries contain key-value pairs, where each value is associated with a label or key. The keys for a dictionary must be both unique (so there is no ambiguity when trying to access items) and immutable. For example `int`, `float`, `str`, etc are all immutable but `list` or other `dicts` (which can be changed, i.e. are mutable) cannot be keys. Let's make a dictionary that the following key value pairs: `A: 1`, `B: "this is the value for B"`, `C: [1, 2, 4, 8]`, and `2: "int as a key"`:

```python
my_first_dict = {
    "A": 1,
     "B": "this is the value for B",
     "C": [1, 2, 4, 8],
      2: "int as a key"
}
my_first_dict
```

Accessing an item in a dictionary is similar to doing the same thing with a list: we use brackets `[ ]` with the dictionary name, and inside the brackets we put a key:

```python
print(my_first_dict['A'])
print(my_first_dict[2])
my_first_dict
```

We can add an item to a dict using the following syntax:

To return and remove a key, we can once again use the `pop()` method with the key as the first argument of `pop()` (instead of a numeric index, as with a list). This time we also have an optional argument for what value to return if a key is not present in the `dict`. This allows us to avoid an error if we try to `pop()` a key that isn't in the `dict`.

```python
my_first_dict["new_key"] = 3.3
my_first_dict
```

Here's an example of adding an item to a dict using pop():
```python
print(my_first_dict.pop('new_key'))
my_first_dict
```

When calling pop(), we can specify default behavior for when the key is not present (the second argument, `None`)
```python
print(my_first_dict.pop('not_a_key', None))
my_first_dict
```

Len() will give you the number of items in a dict (just as with a list):
```python
len(my_first_dict)
```

To get a list of keys in the dictionary, use keys():

```python
my_first_dict.keys()
```

And to get a list of values, use values():

```python
my_first_dict.values()
```

Using `in` will let us see whether a key is present in the dictionary:
```python
"A" in my_first_dict
```

And to see if a value is present in a dictionary, we can use `dict.values()`:
```python
print(1 in my_first_dict)
print(1 in my_first_dict.values())
```

<br>

### Tuples and Sets
Let's look at the last two Python collection types: tuples and sets. Tuples are an ordered, unchangeable collection that allows duplicate members. Sets are an unordered and unindexed collections that do not allow duplicates. They are less commonly used than lists or dicts but still serve an important role.

Let's start with tuples. They are used to store multiple values in a single object. Tuples are ordered, and therefore can be accessed by index like a list. However, they are unchangeable which means they cannot be modified after creation. Let's create a tuple using `( )` and store the first three letters of the alphabet:

```python
my_first_tuple = ("A", "B", "C")
print(my_first_tuple)
print(my_first_tuple[0])
print(my_first_tuple[2])
```

Tuples allow duplicates, and they can contain any item (including another tuple):
```python
my_second_tuple = (1, 1, my_first_tuple)
my_second_tuple
```

If we would like to create a tuple with a single value, we either have to leave a trailing comma or use the `tuple()` constructor on another collection:
```python
test_tuple = (1)
print(type(test_tuple))
test_tuple = (1,)
print(type(test_tuple))
test_tuple = tuple([1])
print(type(test_tuple))
```

As with other collections, we can check how many items are in our tuple with the `len()` function:
```python
print(len(my_first_tuple))
print(len(test_tuple))
```

We can check if items are in a tuple with an `in` membership operator just like a list:
```python
"A" in my_first_tuple
```

We will conclude by pointing out that tuples are often used to return values from functions when multiple return values are needed.

### Sets
Sets are collections of unique objects, meaning that duplicates are not allowed. They are unordered and unindexed. If duplicate items are included when the set is created, only one copy of the duplicate value will go into the list. We create a set with braces (`{ }`), but without the colon used in dictionaries to separate keys and values:

```python
my_first_set = {1, 2, 2, "A", "a"}
print(my_first_set)
print(type(my_first_set))
```

As with other collection types, we can use `in` to check for set membership, and get the number of items with `len()`:

```python
print(1 in my_first_set)
print(len(my_first_set))
```

While the items in a set are unchangeable, sets do have an `add()` method for including new items. If the item is a duplicate of an existing item, nothing is added. It is also worth noting that the `add()` method has no return value; the set is updated in-place. This means there will be no feedback if an existing value is not added - the set will remain unchanged. You need to use the `in` operator as above if you need a return value about `set` membership.

```python
print(my_first_set)
my_first_set.add("fancy new string")
print(my_first_set)
my_first_set.add("A")
print(my_first_set)
```

## Collection summary
Now you know all the basic types of Collections you will encounter in Python. These will serve as the building blocks for your future work in data engineering with Python. Let's give a quick summary of them so you know what collection to use when a project requires you to store multiple objects:
- `list` - The simplicity and flexibility of `lists` means you will often use them whenever you simply need to store multiple values. As ordered collections, they are great for storing items sequentially which also makes them great for iteration. They are not well suited to finding specific items inside them since there is no labeling on the values.
- `dict` - These are great any time you want to store labeled values for future use, which happens often. They are often used to store configuration information because of this feature. They are also great for iterating over and allow you to check the label before performing certain actions as well. Additionally as of Python 3.7, the items can be iterated over in the order they were added similar to a list.
- `tuple` - an ordered unchangable set of values. Tuples will show up most often in return values from functions. Their more rigid structure is well suited to functions interacting with each other; if you expect a specific number of returned values, a `tuple` won't let you down.
- `set` - probably the least frequently used collection type but they have utility when you want to keep unique values and/or check if an input is in a specific set of values. You won't use them often but everyone once in a while, they'll be exactly what is needed.

## Flow control (loops and conditionals)

Using loops to iterate through a sequence of steps is one of the most important skills in Python. As a data engineer, you will constantly find yourself needing to iterate through some data in order to perform some calculation. The basic loop construction is simple - first we need need something to iterate over. We'll make a list of the first ten integers and call it `loop_list`. Then we can use a `for` loop with `in`:

```python
loop_list = list(range(10))
for item in loop_list:
    print(item)

print("We are out of the loop")
```

In this example, *item* is the variable name we are using for each value in our list. After our declaration line telling us what we are looping over, the block of indented code is executed once for every *item* in the object we're looping over (in this case, a list). Pretty straightforward, right? Python loves to loop and many objects are naturally iterable, For example, we can loop over every character in the string *"this is a string"*:

```python
for char in "this is a string":
    print(char)
```

We can also nest loops. Here's an example showing how to loop over each character in a list of strings, using nested `for` loops:
```python
stringy_list = ["this", "is", "a", "str", "list"]
for item in stringy_list:
    for char in item:
        print(f"the character '{char}' from the word '{item}'")
```

Another powerful flow control tool is the conditional statement, also known as an `if ... else` statement. In Python, the syntax is straightforward - it begins with the declaration `if condition:` followed by a block of indented text to be executed if `condition` evaluates as `True`. For example:

```python
if True:
    print("True is always true")
```

We can combine the `if` with an `else:`, which is what will be executed if `condition` is `False`: 

```python
if False:
    print("This will never print")
else:
    print("But this will always print")
```

A third version of the `if... else' statement uses `elif` to handle multiple conditionals in the same statement:
```python
my_number = 3
if my_number > 3:
    print(f"{my_number} is > 3")
elif my_number == 0:
    print(f"{my_number} equals 0")
elif my_number ==  3:
    print(f"{my_number} is in fact 3")
elif my_number < 5:
    print(f"{my_number} is < 5")
else:
    print("what was my number?")
```

We can also create compound conditions using `and` and `or`:
```python
test_number = 5
if test_number > 0 and test_number % 2 == 0:
    print(f"{test_number} is a positive even number")
elif test_number > 0:
    print(f"{test_number} is a positive odd number")
else:
    print(f"{test_number} is not greater than 0")
```

We should note that conditionals are evaluated in the order written, and that the first condition that evaluates to `True` is the *only* one which is executed. Once the interpreter encounters a `True` condition, it skips the rest of the conditions, even if they are also `True`.


The following example uses the `%` (modulus) operator, which returns the remainder of an integer division, to print the even numbers between 1 and 10:
```python
for num in range(1,11):
    if num % 2 == 0:
        print(num)
```

We can also use conditionals to explore two new loop controls: `continue` and `break`. When a loop encounters a `continue`, the current step of the loop evaluation stops and the interpreter goes to the next item in the loop. We can use that behavior to print all the odd numbers from 1 to 10:

```python
for num in range(1,11):
    if num % 2 == 0:
        continue
    print(num)
```
One benefit of using `continue` is that it helps us to avoid deeply nested conditionals in our loops. The other new loop control is `break`. which causes the interpreter to exit (break out of) the loop.

```python
for num in range(10):
    if num > 5:
        break
    print(num)

print("Out of the loop")
```

### List Comprehension

Another type of iteration that Python supports, and which is one of the most important elements in the Pythonic code style paradigm, is *list comprehension*. This very neat syntax is what to use when we want to iterate over a list and return some result, without having to write many lines of code. Let's start with an example that takes a list of even numbers from one to ten and returns a result list containing each of those numbers divided by 2:

```python
starting_list = list(range(2,11,2))
print(starting_list)
divided_list = [num/2 for num in starting_list]
print(divided_list)
```

The list comprehension is in the third line of code above: `[num/2 for num in starting_list]`
When the Python interpreter encounters an expression in the form `[expression for item in list]`, it knows to iterate through the list, evaluate the expression for each element, and put all the results into a single list. As you can see, this lets you do with one line of code what would other require a loop and several lines of code.

<br>

### Iterators

This brings us to the Python concept of *iterators*. All the collection types (list, dict, set, tuple) we've been working with are iterators, as is the `str` (string) type. *iterators* are python objects capable of returning their members one at a time, permitting them to be iterated over in a for loop. This means that iterators have built in `__iter__()` and `__next__()` methods (we will learn more about creating these whe we discuss Python classes). In addition to the collection objects, we've also used the iterator `range()` when making lists of numbers. One aspect of iterators that `range()` helps illustrate is that they can be lazily evaluated. What this means is that the iterator does not have to store all the values to be iterated on; instead it can store the logic for creating that logic and all the values are enumerated once iteration is invoked.

```Python
print(range(5, 10))
print([2*num for num in range(5, 10)])
```

<br>

## Functions
Python functions define a block of code that can be called and run by name. Functions are one of the most common features in all modern programming languages; the ability to define a portion of code and call it by name makes code much more compact and reusable (since it only has to be updated in one place, the function definition, rather than every place the function is called). A function can accept inputs and can return values. An example of a function you already know that takes input is `print()`! This simple function takes the input supplied in the `()` and prints it to the screen. We note that `print()` has no return value as we can see below:

```python
print(print("Hello friends!"))
```
Output:
<pre>
Hello friends!
None
</pre>

The `print()` function is an example of a Python [standard library]() function - one that is included with Python. Since `print()' is in the standard library, we do not have to install any packages or explicitly define it in order to use it anywhere in our code. But what if we need a custom function that does something no existing function does? In this case, we can define our own functions using the following syntax:

```python
def new_function():
    print("I'm a brand new function")

new_function()
```

Notice that this function takes no input arguments and returns `None`. [Read more on `None`](https://docs.python.org/3/c-api/none.html)

Now let's look at using input arguments in our functions. We can do that by adding comma-separated variables in the function definition:

```python
def input_function(first_input, second_input, third_input):
    print(f"My first input was {first_input}, my second input was {second_input} and I refuse to tell you that {third_input} was my third input")

input_function(1, "cake", ["secret", "list"])
```

We can return values from a function by using a `return` statement. Once a function encounters a `return` statement, the specified value is returned to the calling function or expression:

```python
def add_numbers(num_1, num_2):
    return num_1 + num_2

add_numbers(3, 4)
```

We note that Python does not enforce type on the inputs to a function. This means we can use the addition operator on any data types that have a supported `+` operator.

```python
print(add_numbers("A", "B"))
print(add_numbers([1, 3], [5, 6]))
```

If we want to annotate an expected type in a function, Python3 allows us to do so with a colon in the parameter declaration. This still will not strictly enforce type but add clarity and allows other tools to know what inputs are expected. Similarly, if we want to annotate what the output type should be, we can follow the `( )` with `-> type`. Let's annotate our adding function to say it takes two `int` at input and returns an `int`:

```python
def add_numbers(num_1:int, num_2:int) -> int:
    return num_1 + num_2

print(add_numbers(4,5))
print(add_numbers("Hello", " friends"))
```

When defining a function, we can also set default values for some or all of the input arguments. To do this, all that is needed is to follow the argument name with `=default_value`. Note that if you are using a mix of default arguments and non-default arguments, all arguments without a default value must come first. Let's make a string reversing function that defaults to capitalizing the string as well:

```python
def flip_string_and_reverse(input_str, cap=True):
    if cap:
        input_str = input_str.upper()
    return input_str[::-1]

print(flip_string_and_reverse("race car"))
print(flip_string_and_reverse("Yellow carD"))
print(flip_string_and_reverse("no cap", False))
```

If there are multiple default arguments for a function and you only want to specific a non-default value for one of them, you can use `default_arg=new_value` when calling the function. This must come after any non-default arguments when calling the function. 

```python
def string_formatting(input_str, cap_first=True, reverse=False):
    if cap_first:
        input_str = input_str.title()
    if reverse:
        input_str = input_str[::-1]
    return input_str

test_string = "hello everyone, how is your day going?"
print(string_formatting(test_string))
print(string_formatting(test_string, reverse=True))
```

We can also invoke our defined function inside other functions. Let's make a function that adds two numbers if they are both even but return `None` if either is odd: 

```python
def is_even(num):
    if num % 2 == 0:
        return True
    return False

def even_adder(num_1, num_2):
    if is_even(num_1) and is_even(num_2):
        return add_numbers(num_1, num_2)
    return None

print(even_adder(1,2))
print(even_adder(2,2))
print(even_adder(-2,2))
```

We see what happens when we invoke another function inside our function. What happens if we invoke our function _inside itself_? This is the concept called *recursion*. While we must be careful that our functions do not recurse endlessly, we can use recursion to do some cool things. Let's make a function that takes a number and returns the sum of all positive integers up to that number (e.g. given 3, it will add 1 + 2 + 3 and return the value 6):

```python
def add_recursion(num):
  if num > 0:
    result = num + add_recursion(num - 1)
    print(result) # this lets us keep an eye on the current sum
  else:
    result = 0
  return result
print(f"Lets check the value for 3: {add_recursion(3)}")
print(f"And the value for 6: {add_recursion(6)}")
```

### Lambda Functions

An important type of function in Python is the *lambda* function. These are small anonymous functions that are declared inline. What does it mean to be an anonymous function? It simply means it does not have to be bound to an identifier like the functions we have seen up to this point. Let's make a very simple lambda function that will double a number:

```python
dubs = lambda a: 2*a
print(dubs(2))
print(dubs(5))
```

Lambda functions can have any number of inputs but only one expression following the `:`

```
multiplier = lambda a, b: a*b
print(multiplier(3, 5))
print(multiplier(4, -2))
```

Why are lambda functions useful? The two examples we've created could be done simply with a regular function that is defined separately in a block. The utility of anonymous lambda functions is more easy to see when they're used inside other functions. Let's create a simple function that will multiply by an unknown number, then use that function to build our doubling function as well as a tripling function:

```python
def scale_by_num(num):
    return lambda a: num*a

dubs = scale_by_num(2)
print(dubs(5))

trips = scale_by_num(3)
print(trips(5))
```

That wraps up our discussion of collection types, flow control, and functions. This episode contains a lot of information, but we'll be sure to take time for questions. The [next episode](../ep3) covers function arguments and classes, a key concept in Object Oriented Programming (OOP).

<br>

### Further Reading:
- [Python list functions](https://docs.python.org/3/tutorial/datastructures.html)
- [Python collection data types](https://realpython.com/python-collections-module/)
- [Guide to Python Code Style](https://docs.python-guide.org/writing/style/)