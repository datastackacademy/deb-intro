# Ch. 1, Ep. 3 - Advanced Python Functions and Classes

## Episode Resources
Both of this episode's code resources are in notebook format:
- [args and kwargs](01-args-kwargs.ipynb) (notebook)
- [Python Classes](02-classes.ipynb) (notebook)

This episode further explores the use of Python functions and introduces a discussion of Objected Oriented Programming in Python.

<br>

## args and kwargs
Sometimes you will see function definitions in Python that take one or both of the following arguments: <b>*args</b> and <b>**kwargs</b>. When you first encounter these arguments, they can be somewhat confusing. Let's take a look to understand what these arguments are and how to use them.

The main use for <b>*args</b> and <b>**kwargs</b> is that they allow us to pass a *varying number* of arguments to a function. You often see a function definition that looks like this:

```python
def my_sum(a, b):
    return a + b
```

This function returns the sum of exactly two numbers. But how can we find the sum of multiple numbers, when we do not know ahead of time how many numbers there will be? The above type of constructor, where the input arguments are explicitly declared, does not allow us to do that. We could pass a list of numbers to the `my_sum()` function, but that is not always possible or desirable.

<b>*args</b> and <b>**kwargs</b> will help us to solve this problem. Let's look first at <b>*args</b> to see how it works:

```python
def second_and_last(*args):
    print(args[1])
    print(args[-1])

second_and_last(1,2,3,4,5)
```

This constructor collects all of the input arguments (five numbers) in a single indexed tuple. Now we only have to specify one input argument (<b>*args</b>) but that argument contains an (iterable) tuple of values:

```python
def print_all(*args):
    for arg in args:
        print(arg)
print_all(None, True, "cake", 2, 1)
```

This is very useful, but <b>*args</b> has a limitation: we can only access the arguments via numerical index. But what if we want to be able to access the arguments via a name label? That is where <b>**kwargs</b> comes in. We can access <b>**kwargs</b> as a dict and access the elements with a key:

```python
def middle_namer(**fullname):
    print(f"My middle name is {fullname['middle']}")

middle_namer(first="Joe", middle="Don", last="Baker")
```

Finally, we can combine <b>*args</b> and <b>**kwargs</b>. This lets us write functions that accept a changeable number of both positional and named arguments:

```python
def combine_print_all_middle_name(*args, **kwargs):
    print_all(*args)
    middle_namer(**kwargs)

combine_print_all_middle_name(1,2,4, 5, last="Bacon", middle="Aaron")
```

It is important to remember that <b>*args</b> must always come before <b>**kwargs</b> in the fuction definition. If you reverse the order, you will get a `SyntaxError`

<br>

## Classes
A class in Python is like an outline or blueprint for creating a new object. The class an object belongs to determines its attributes and properties. An object is a single instance of the type defined by a class.

Let's look at the most basic class definition. Defining a class is roughly similar to defining a function:

```python
class FirstInClass:
    description = "I'm a very simple class"

f1 = FirstInClass()
print(f1.desctiption)
```

Gives the output:
<pre>
I'm a very simple class
</pre>

This class definition works, but it's not very functional. Using the `__init__()` constructor will allow us to initialize the class attributes when creating an object. Let's create a Book class with title, author, and genre attributes:

```python
class Book:
    def __init__(self, title, author, genre):
        self.title = title
        self.author = author
        self.genre = genre


the_iliad = Book("The Iliad", "Homer", "Epic Poem")
print(the_iliad.genre)

runaway_ralph = Book("Runaway Ralph", "Beverly Cleary", "Children's Novel")
print(runaway_ralph.author)
```

Output:
<pre>
Epic Poem
Beverly Cleary
</pre>

You might notice the **self** argument in the input to the `__init()__` constructor function. The first argument to the constructor always refers to the object itself. We could call it anything, but by convention it is almost always called **self**. Because **self** refers to the object being created, we can use it to set the attributes of the new Book object we are creating.

We can define other class methods besides the `__init()__` constructor. For example, let's add a function to the Book class that prints a question asking if the user has read the book:

```python
class Book:
    def __init__(self, title, author, genre):
        self.title = title
        self.author = author
        self.genre = genre
    
    def have_you_read(self):
        print(f"Have you read {self.title} by {self.author}?")

runaway_ralph = Book("Runaway Ralph", "Beverly Cleary", "Children's Novel")
runaway_ralph.have_you_read()
```

Output:
<pre>
Have you read Runaway Ralph by Beverly Cleary?
</pre>

Once an object has been instantiated, we can access its attributes directly using the `object.attribute` syntax. Let's create a new Book object, print its title, and then set the title to a new value:

```python
animporphs = Book("The Invasion", "K. A. Applegate", "YA SciFi")
print(animporphs.title)
animporphs.title = "The Visitor"
print(animporphs.title)
```

Output:
<pre>
The Invasion
The Visitor
</pre>

We can also use this syntax to add attributes to an object that are not included in the class definition (and thus were not set by the constructor when the object was instantiated):

```python
animporphs = Book("The Invasion", "K. A. Applegate", "YA SciFi")
animporphs.good = True
print(animporphs.good)
```

Output:
<pre>
True
</pre>

What if we want to be able to define specific types of books, with some differences in attributes between them? To do that, we can make use of *inheritance*. Instead of defining a totally new class for a sub-type of book (like a biography), we can specify that the Biography sub-type inherits properties from the parent class (Book). To use inheritance, we specify a parent class in parentheses in the definition of the child class:

```python
class Biography(Book):
    pass

bio1 = Biography("The Immortal Life of Henrietta Lacks", "Rebecca Skloot", "Biography")
bio1.have_you_read()
```

Output:
<pre>
Have you read The Immortal Life of Henrietta Lacks by Rebecca Skloot?
</pre>

Notice that even though the Biography constructor doesn't do anything (we just call `pass`), the new Biography object still has attributes. Those are being set by the constructor for the Book class, which is automatically being called when the Biography object is being created, since we have declared that Biography (the child class) inherits from Book (the parent class).

One of the most useful things about sub-classes is that sub-classes can share common properties of the parent class while each having their own additional set of properties. In the example above, we haven't made use of that feature yet. Let's take a look at how to do that, using the `__init()__` method for the child class (Biography). We will also add a method to Biography that prints the subject:

```python
class Biography(Book):
    def __init__(self, title, author, bio):
        super().__init__(title, author, "biography")
        self.bio = bio
    def about(self):
        print(f"This is a biography about {self.bio}")

bio1 = Biography("The Immortal Life of Henrietta Lacks", "Rebecca Skloot", "Henrietta Lacks")
bio1.have_you_read()
bio1.about()
```

Using the `__init()__` constructor for Biography lets us set both the attributes inherited from the parent class (Book) and the attributes specific to the child class (Biography). To set the parent class attributes without repeating code, we can use the `super().__init__(title, author, genre)` syntax, which calls the constructor for the parent class from within the constructor for the child class.

<br>

### Further Reading
- [Python args and kwargs: Demystified](https://realpython.com/python-kwargs-and-args/)
- [Python classes docs](https://docs.python.org/3/tutorial/classes.html)
- [Inheritance and Composition](https://realpython.com/inheritance-composition-python/)