# Ch. 1, Ep. 1: Getting Started and Python Introduction
## Code Resources:
1. [Basic Python](01-python_intro.ipynb) (notebook)
2. [Basic Linux Command Line](02-other_tools.ipynb) (notebook)

## What is Data Engineering?

By now you probably have some idea of what data engineering is and what data engineers do. But the term has only come into use in the last few years, and so it is worth having some discussion about data engineering practice and the skills required, so that you have a good understanding of why the course material is structured the way it is.

You are no doubt aware that we live in a world that is inundated with data, and that the amount of data is growing very rapidly. According to one typical prediction, there will be 175 zettabytes (10<sup>21</sup> bytes, or a trillion gigabytes) of data in the world by 2025. There has been a growing awareness of the need to collect and leverage data for business, research, and decision-making, and in an increasingly digital world, data has become the single most valuable asset for many businesses.

But the amount of data has grown faster than the number of people who have the skills to work with it. Now that it is becoming common for companies to deal not just with terabytes of data, but with petabytes and more, new tools and techniques are required to efficiently deal with such staggeringly large quantities of information.

Data Engineers are responsible for managing an organization's data from ingestion, through various kinds of processing, to its eventual consumption by data scientists/analysts or end users. One of the reasons for the rapid rise of data engineering as a field is that in the last few years, as data science received a lot of attention, many organizations started to realize that for data scientists and analysts to be effective, they require a well-developed data infrastructure which enables them to easily access the data they need. Developing and maintaining that infrastructure is the job of the data engineer.

The tool stack used by data engineers is large, and includes programming, databases and SQL, APIs, containerization, and numerous cloud tools for orchestration, data processing, serverless architecture, streaming, and data visualization. See the [course overview](course-overview.md) for more details. Everything you learn in this class, and the skills that you will use as a data engineer, depends on developing a solid foundation in programming. And because Python has become unquestionably the dominant language for data professionals, the course will focus on developing and reinforcing your Python skills.

## Why Python

You might be wondering why Python has become so dominant in the realm of working with data. Python has a number of important and useful features that make it the language of choice for data engineers, scientists, and analysts:

- Code quality - the focus on readability means that Python code is also very readable and maintainable.
- Developer productivity - Python developers are often significantly more productive than with other languages. Python code is typically one-fifth to one-third the size of equivalent Java or C++.
- Code portability - Python is supported by all major operating systems, and porting code between them is usually as simple as just copying code from one machine to another.
- Library support - Python boasts a large collection of built-in functionality (its *standard library*). When more functionality is needed, Python can be extended with user-created libraries, or with a huge collection of third-party support software.
- Component integration - Python is easy to integrate with other application components. It is written in C, can invoke C and C++ libraries, and can be called from C and C++ programs. It also supports integration with many other languages and frameworks.

Python was designed with the goal of having a simple syntax that is less cluttered than other languages, and to be fun to use. The combination of the above features with the focus on an enjoyable developer experience have made Python ubiquitous, particularly for users who are working with large amounts of data.

<br>

## Python Basics
## The Python Interpreter

Python is an [interpreted language](https://discuss.python.org/t/is-python-a-compiled-language-or-an-interpreted-language/6556) which can be used in two different ways:
1. Interactive mode (one command at a time in an interpreter session):
    ```bash
    $ python
    Python 3.7.9 (v3.7.9:13c94747c7, Aug 15 2020, 01:31:08) 
    [Clang 6.0 (clang-600.0.57)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> 1 + 1
    2
    >>> print("Hello world")
    Hello world 
    ```

1. Scripting mode
This is the way we will most often use the interpreter, by specifying a .py file. If we have a file (`hello_world.py`) that contains the above print statement (`print("Hello world")`), then running
```python
$ python hello_world.py
```
will run the entire file and exit the interpreter.

## Jupyter notebooks

If you followed the [Getting Started Guide](/getting-started/), you should have installed [Jupyter](jupyter.org) by now. 

```bash
jupyter lab
```
will open Jupyter's browser-based interface that will allow you to explore files and compose notebooks. By now you also should have created a local clone of this repository on your own machine; navigate to the directory where you cloned the repo and you can open notebooks in the Jupyter interface to run them interactively. From time to time during the course we will explore interactive code demonstrations together, and you will need to know how to work with notebooks outside of the pre-rendered view in GitHub.

### Google Colaboratory
Another great resource for interactive programming and reproducible research is [Google Colaboratory](colab.research.google.com). Colab has been called 'Jupyter notebooks on steroids', because it takes notebooks and adds some additional features that data engineers and scientists will find very useful, such as showing resource usage, which is helpful for example when training machine learning models on the cloud.

## Python white space
Python's syntax is unique among programming languages in its use of white space. In Python, whitespace is used in two ways:
- newlines terminate logical lines
- changes in indentation delimit code blocks

```python
# Two logical lines
x = 1
y = 2

# One logical line escaped with backslash
x = 1 + \
    2

# One logical line, this time escaped by a newline within parentheses
x = (1 + 
    2)
```

Code blocks in Python are delimited by indentation. Let's see how that works:

```python
# Indentation with tabs
for i in range(10):
    if i % 2 == 1:
        print(i)

# Indentation with 4 spaces
for i in range(10):
    if i % 2 == 1:
        print(i)
```

See the very helpful [Python Style Guide](https://www.python.org/dev/peps/pep-0008/) for more details on this and other related topics. As noted in that guide, spaces are the preferred indentation method. Whichever you use, make sure to keep your indentation consistent.

<br>

## Naming Conventions
See the official style guide's [discussion of naming conventions](https://www.python.org/dev/peps/pep-0008/#naming-conventions). For a condensed version that is helpful as a cheat sheet, see [this convention guide](https://visualgit.readthedocs.io/en/latest/pages/naming_convention.html).

<br>

## Comments

Commenting your code is very important, other people (and you) can easily understand what your code is doing. Something that seems obvious to you might not be obvious to someone else, so providing clear explanations in your comments is very important. And this can even help you when you are looking at your own code. There will be times when you have to revisit code you have not looked at in months or years, and you might have forgotten why you did what you did.

Here are some basic examples:

```python
# This is a single-line comment

print("Some output") # this comment goes at the end of a line

"""
This is a multi-line comment.
When enclosed in triple quotes, your comments can be as long as you need.
This comment is three lines long.
"""
```

Above we see examples of three styles of comments:
1. A single line comment, by itself
2. A comment which follows a code statement, on a single line
3. Multiline comments enclosed in triple-quote blocks

For more details on best practices when commenting in Python, see this [Guide To Writing Comments in Python](https://realpython.com/python-comments-guide/).

<br>

## Variable assignments
Unlike C++, Java, and many other languages, Python has no way of declaring a variable separately from assigning a value. Variables are created when they are assigned a value (typically using the `=` operator).

<br>

# Assign a single variable
```python
x = 5
y = 10
```

```python
x, y, z = 1, 2, 3
my_num, my_list, my_dict = 1, [1, 'a', True], {"name": "Alice", "year": 1985}
```

```python
# Assign a single variable
x = 5
y = 10

# Multiple assignment
x, y, z = 1, 2, 3
my_num, my_list, my_dict = 1, [1, 'a', True], {"name": "Alice", "year": 1985}
```

In the second pair of examples, notice that Python allows us to declare multiple variables with a single assignment statement, and that we can even mix variable types in doing do. This is one of the many ways in which Python gives you, the programmer, a degree of flexibility and expressiveness not found in other languages.

<br>

## Built-in data types
Python has a number of [built-in data types](https://docs.python.org/3/library/stdtypes.html) to allow us to work with many different kinds of data. For your reference, here is the complete list of built-in types:
- Text Type: str
- Numeric Types: 	int, float, complex
- Collection Types: list, tuple, set, dict
- Set Types: 	set, frozenset
- Boolean Type: 	bool
- Binary Types: 	bytes, bytearray, memoryview

For our purposes, we are most interested in the text (str), numeric (int, float), collection (list, tuple, range), and boolean types. In [episode 2](../ep2), we will look in more detail at using these data types.

<br>

## The print() function
One of the most commonly used functions in python is `print()`. 

```python
### print the content of a variable
a, b = 5, "This is a string"
print(a)
print(b)

### using print() with a compound expression
import os
print('Your system username is ' + os.getlogin() + '.')

### using f-strings
name, age = 'Alex', 26
print(f'My name is {name}, and I am {age} years old.')

#printing to a file
import sys
with open('hello_world.txt', mode='w') as file_object:
    print('Hello world', file=file_object)
```

Output:
<pre>
5
This is a string
Your system username is root.
My name is Alex, and I am 26 years old.
</pre>

<br>

# Basic Unix-style CLI
Here you will find a list of the most common commands 
Note: almost all of the commands described here are standard on any Linux-flavored OS, but they might not all be available on every system, depending on your distribution. Because Mac OS is based on Free BSD, most (though not all) standard Linux commands are available from a Mac OS terminal.

Files

`ls` - lists your files
    
`ls -l` - lists your files in 'long format', which contains lots of useful information, e.g. the exact size of the file, who owns the file and who has the right to look at it, and when it was last modified.

`ls -a` - lists all files, including the ones whose filenames begin in a dot, which you do not always want to see. There are many more options, for example to list files by size, by date, recursively etc.
    
`more filename` - shows the first part of a file, just as much as will fit on one screen. Just hit the space bar to see more or q to quit. You can use /pattern to search for a pattern.
    
`nano filename` - is an editor that lets you create and edit a file. See the [beginner's guide to nano](https://itsfoss.com/nano-editor-guide/).
    
`mv filename1 filename2` - moves a file (i.e. gives it a different name, or moves it into a different directory (see below)
    
`cp filename1 filename2` - copies a file
    
`rm filename` - removes a file. It is wise to use the option rm -i, which will ask you for confirmation before actually deleting anything. You can make this your default by making an alias in your .cshrc file.
    
`diff filename1 filename2` - compares files, and shows where they differ
    
`wc filename` - tells you how many lines, words, and characters there are in a file
    
`chmod options filename` - lets you change the read, write, and execute permissions on your files. The default is that only you can look at them and change them, but you may sometimes want to change these permissions. For example, chmod o+r filename will make the file readable for everyone, and chmod o-r filename will make it unreadable for others again. Note that for someone to be able to actually look at the file the directories it is in need to be at least executable. See [this guide to Linux permissions](https://opensource.com/article/19/6/understanding-linux-permissions) for more details.

<br>
    
## File Compression
`gzip filename` --- compresses files, so that they take up much less space. Usually text files compress to about half their original size, but it depends very much on the size of the file and the nature of the contents. There are other tools for this purpose, too (e.g. compress), but gzip usually gives the highest compression rate. Gzip produces files with the ending '.gz' appended to the original filename.
        
`gunzip filename` - uncompresses files compressed by gzip.
        
`gzcat filename` - lets you look at a gzipped file without actually having to gunzip it (same as gunzip -c). 

`tar -xzvf` - untar a .tar file

<br>

## Directories
Directories are used to group files together in a hierarchical structure. Here are some commands for navigating directory structure.

`mkdir dirname` - make a new directory

`cd dirname`  - change directory. Your working directory will change, and you will see the files in that directory when you do 'ls'. You always start out in your 'home directory', and you can get back there by typing 'cd' without arguments. 'cd ..' will get you one level up from your current position. You don't have to walk along step by step - you can make big leaps or avoid walking around by specifying pathnames.
    
`pwd` - tells you where you currently are. 

<br>

## Finding things
`ff` - find files anywhere on the system. This can be extremely useful if you've forgotten in which directory you put a file, but do remember the name. In fact, if you use ff -p you don't even need the full name, just the beginning. This can also be useful for finding other things on the system, e.g. documentation.
    
`grep string filename(s)` - looks for the string in the files. This can be useful a lot of purposes, e.g. finding the right file among many, figuring out which is the right version of something, and even doing serious corpus work. grep comes in several varieties (grep, egrep, and fgrep) and has a lot of very flexible options. Check out the man pages if this sounds good to you. 

<br>


## About your (electronic) self
`whoami` - returns your username. Sounds useless, but isn't. You may need to find out who it is who forgot to log out somewhere, and make sure *you* have logged out.

`ps` - lists running processes. Contains lots of information about them, including the process ID, which you need if you have to kill a process. 

`kill PID` --- kills (ends) the processes with the ID you gave. This works only for your own processes, of course. Get the ID by using ps. If the process doesn't 'die' properly, use the option -9. But attempt without that option first, because it doesn't give the process a chance to finish possibly important business before dying. 
    
`du filename` - shows the disk usage of the files and directories in filename (without argument the current directory is used). du -s gives only a total.
    
`df' - shows a list of disks on the system and the amount of disk space used


<br>

You can find out more about these commands by looking up their manpages:
`man commandname` shows you the manual page for the command 

<br>

### Further Reading
- [Basic Python code samples](http://wiki.python.org/moin/BeginnersGuide/Examples) (python.org)
- [Python standard library reference](https://docs.python.org/3/library/)
- [Python Style Guide](https://www.python.org/dev/peps/pep-0008/)
- [Guide To Writing Comments in Python](https://realpython.com/python-comments-guide/).
- [Learning The Shell](https://linuxcommand.org/lc3_learning_the_shell.php)
- [Basic Linux Commands](basic_cli.md)

