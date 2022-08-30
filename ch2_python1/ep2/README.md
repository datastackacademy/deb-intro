# Classes, and Nesting Lists and Dictionaries


## Classes

Classes can be a confusing concept at first, but you use them in real life all the time. A class, to put it loosely, is a category, like 'Book', 'Dog', or 'House'. To belong to a category, an object has to have and do certain things. For instance, every object in the dog category can bark, has fur, and has a name. Every object in the book category has pages, an author, and a title. Instances (examples) of objects in a category have specific values for what it has and does. Each dog in the dog category, for example, has their own name and fur color.

A class in Python is like an outline or blueprint for creating a new object. The class an object belongs to determines its attributes (what it has) and methods (what it does). An object is a single instance of the type defined by a class.

You've already been using objects; in Python, numbers, strings, and lists are all objects. When you define, say, a list, you're making an instance of a list object. It has all the methods and attributes available to any list, like `.append()`, `.sort()`, or `.pop()`. 

Python can be used in a functional style, where programs are made mainly using functions, or an object-oriented style, which focuses on creating objects from classes. Though the Python language is composed mainly of objects, we focus on this course on writing code using functional programming. However, both in this course and in your career you'll encounter classes, so they're important to know. Head over the the notebook `classes_and_scope.ipynb` for more info and practice.

## Nested Lists and Dictionaries

When we learned about lists and dictionaries, we saw that the objects in a list, as well as the values in the dictionaries, can be any data type: strings, booleans, numbers, even other lists or dictionaries. You can have a list of lists of lists, a dictionary of dictionary of dictionaries, a list of dictionaries of lists of dictionaries...as you can see, it can get complicated! 

Learning how to work with nested data structures just takes a little practice. Head over the the notebook `nested_dicts_and_lists.ipynb` for info and exercises.
