# Functions, Flow Control, Sets, and Tuples

## Tuples and Sets
In the past few days, we've been learning about the Python collection data types lists and dictionaries. Let's look at the last two Python collection data types: tuples and sets. 

Tuples are an ordered, unchangeable collection that allows duplicate members. They're a lot like lists; the main difference is that lists can be changed with methods like `pop()` and `append()`, while tuples cannot. 

Sets are an unordered and unindexed collections that do not allow duplicates. They are less commonly used than lists or dicts but still serve an important role.

Head to notebook `01_sets_and_tuples.ipynb` for more instruction and practice.

<br/>

## Collection summary
Now you know all the basic types of Collections you will encounter in Python. These will serve as the building blocks for your future work in data engineering with Python. Let's give a quick summary of them so you know what collection to use when a project requires you to store multiple objects:
- `list` - The simplicity and flexibility of `lists` means you will often use them whenever you simply need to store multiple values. As ordered collections, they are great for storing items sequentially, which also makes them great for iteration. They are not well suited to finding specific items inside them since there is no labeling on the values.
- `dict` - These are great any time you want to store labeled values for future use, which happens often. They are often used to store configuration information because of this feature. They are also great for iterating over and allow you to check the label before performing certain actions as well. Additionally as of Python 3.7, the items can be iterated over in the order they were added, similar to a list.
- `tuple` - an ordered, unchangeable set of values. Tuples will show up most often in return values from functions. Their more rigid structure is well suited to functions interacting with each other; if you expect a specific number of returned values, a `tuple` won't let you down.
- `set` - probably the least frequently used collection type but they have utility when you want to keep unique values and/or check if an input is in a specific set of values. You won't use them often, but every once in a while, they'll be exactly what is needed.

<br/>

## Flow Controls
In Python, 'flow control' means how the code is executed, based on a condition. Today, we're going to look 'for' loops, 'while' loops, and 'if' conditions. Please work through notebooks `02_for_loops.ipynb`, `03_while_loops.ipynb`, and `04_if_conditions.ipynb` before moving on.

Once you're familiar with 'for' loops, 'while' loops, and 'if' conditions, go to notebook `05_flow_control_misc.ipynb` for more info about how flow controls can be used.

<br/>

## Functions
Python functions define a block of code that can be called and run by name. Functions are one of the most common features in all modern programming languages; the ability to define a portion of code and call it by name makes code much more compact and reusable (since it only has to be updated in one place, the function definition, rather than every place the function is called). A function can accept inputs and can return values. Go to notebook `06_functions.ipynb` to learn more about functions.

<br/>

## Conclusion
Looooooooooooooooooooooong day for sure. Let's skip the conclusion and get some rest 😊️😴️

These are very important Python topics. You'll have to make sure you keep exercising these techniques later.