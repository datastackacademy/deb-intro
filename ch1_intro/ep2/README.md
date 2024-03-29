# Command Line Basics and Python Collections

## Episode Resources

This episode is a crash-course in command-line basics. It also looks in a bit more detail at the data types you will use most commonly as a data engineer. 

Before we dive back into Python notebooks, let's learn some command-line interface (CLI) tools. The command-line lets your search and navigate your file system. We'll get more practice with it when we start using Git and GitHub later in this chapter.

# Basic Unix-style CLI
First, open a terminal.

    Keyboard shortcuts for opening a terminal:
    - Linux: `[Ctrl + Alt + t]`
    - Windows: `[Ctrl + Alt + w]`
    - Mac: `[Cmd + space]`, then type "terminal" into the search bar

Here, we will practice the most common commands. 

Note: almost all of the commands described here are standard on any Linux-flavored OS, but they might not all be available on every system, depending on your distribution. Because Mac OS is based on Free BSD, most (though not all) standard Linux commands are available from a Mac OS terminal.

> **NOTE:** We recommend that you also research how to use these commands on your own. For example: here is a [link](https://www.geeksforgeeks.org/find-command-in-linux-with-examples/?ref=lbp) for working with the `find` command.

You can find out more about these commands by looking up their man (manual) pages:
`man commandname` shows you the manual page for the command 

If a command is stalling out, you can stop it by typing `Ctrl + c`

Test each of the commands below in your terminal:


## Files

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

<br/>

## Directories
Directories are used to group files together in a hierarchical structure. Here are some commands for navigating directory structure.

`mkdir dirname` - make a new directory

`cd dirname`  - change directory. Your working directory will change, and you will see the files in that directory when you do 'ls'. You always start out in your 'home directory', and you can get back there by typing 'cd' without arguments. 'cd ..' will get you one level up from your current position. 'cd ../..' will get you two levels up from your current position, and so on. You don't have to walk along step by step - you can make big leaps or avoid walking around by specifying pathnames.
    
`pwd` - tells you where you currently are. 

<br/>

## File Compression
`gzip filename` --- compresses files, so that they take up much less space. Usually text files compress to about half their original size, but it depends very much on the size of the file and the nature of the contents. There are other tools for this purpose, too (e.g. compress), but gzip usually gives the highest compression rate. Gzip produces files with the ending '.gz' appended to the original filename.
        
`gunzip filename` - uncompresses files compressed by gzip.
        
`gzcat filename` - lets you look at a gzipped file without actually having to gunzip it (same as gunzip -c). 

`tar -xzvf` - untar a .tar file

<br/>

## Finding things
`find` - find files anywhere on the system. This can be extremely useful if you've forgotten in which directory you put a file, but do remember the name. In fact, if you use ff -p you don't even need the full name, just the beginning. This can also be useful for finding other things on the system, e.g. documentation.
    
`grep string filename(s)` - looks for the string in the files. This can be useful a lot of purposes, e.g. finding the right file among many, figuring out which is the right version of something, and even doing serious corpus work. grep comes in several varieties (grep, egrep, and fgrep) and has a lot of very flexible options. Check out the man pages if this sounds good to you. 

<br/>


## About your (electronic) self
`whoami` - returns your username. Sounds useless, but isn't. You may need to find out who it is who forgot to log out somewhere, and make sure *you* have logged out.

`ps` - lists running processes. Contains lots of information about them, including the process ID, which you need if you have to kill a process. 

`ps aux | grep chrome` - list processes and filter to only running chrome processes

`kill PID` --- kills (ends) the processes with the ID you gave. This works only for your own processes, of course. Get the ID by using ps. If the process doesn't 'die' properly, use the option -9. But attempt without that option first, because it doesn't give the process a chance to finish possibly important business before dying. 
    
`pkill PNAME` - kill a particular process using the process name

`du filename` - shows the disk usage of the files and directories in filename (without argument the current directory is used). du -s gives only a total.
    
`df` - shows a list of disks on the system and the amount of disk space used

<br/>

## Working with file content 

`echo "hello"` - print a message to the console

`echo "hello" > test.txt` - use the redirect symbol (`>`) to direct the output of `echo` command into a file

`cat test.txt` - display the content of test.txt

`echo " world" >> test.txt` - use the redirect-append symbol (`>>`) to append the output of `echo` command into an existing file

`cat test.txt` - display the content of test.txt

<br/>

# Python Data Types, Lists, and Dictionaries

Alright, now back to Python! We'll continue with the basics, looking at some built-in data types. We'll focus especially on lists and dictionaries.

Before you start working through the notebooks, read the lesson below.

<br>

## Built-in data types

Python has a number of [built-in data types](https://docs.python.org/3/library/stdtypes.html) to allow us to work with many different kinds of data. 

We are typically most interested in the **numeric** types (int, float), **text** (str), **collections** (list, tuple, range), and **boolean** types. 

For your reference, here is the complete list of built-in types:
- Text Type: str
- Numeric Types: 	int, float, complex
- Collection Types: list, tuple, set, dict
- Set Types: 	set, frozenset
- Boolean Type: 	bool
- Binary Types: 	bytes, bytearray, memoryview

'Boolean' types can only have two values, "True" or "False". 

All primitive types include members (or methods) that perform various actions. For example the `str` type has methods to capitalizing (upper case), lower case, search for phrases within the string, or replace phrases. Let's take a look at some of the `str` members.

You can access primitive type methods by including a `.` after the variable name and then adding the member name. For example:

```python
name = "data stack"
name.upper()
```

This will uppercase our name variable. Members are functions. You'll learn more about functions later; to invoke a function you need to include `()` at the end of its name (ie: `.upper()`). If the function takes any arguments (parameters), they are included in between the opening `(` and closing `)` parenthesis. 

You can always use the _Code Completion_ feature of VS Code to see a list of available members for a data type. Enter your variable name and a trailing dot `.` to start invoking its members, then press `CTRL` + `SPACE` to open the code completion window. You can scroll through the list of available members and choose the one you like to invoke.

<br>

### Numeric Types
Before we continue with more complex data types like strings and collections, let's take a quick look at numeric types.

The two main numeric types are int (whole numbers) and float (decimal numbers).

```python
# int assignment (whole numbers)
x = 3

# float assignment (numbers with decimals)
pi = 3.14159265359

# print values
print(x, pi)
```

For details and practice with strings, lists, and dictionaries, work through notebooks `01_strings.ipynb`, `02_lists.ipynb`, and `03_dictionaries.ipynb`. You'll find extra practice in `04_exercises.ipynb`.

<br>



# Further Reading

If you have more time, you can complete the following additional readings/exercise:
- Review section 1-6 of [Kaggle Python tutorial](https://www.kaggle.com/learn/python)
- Kaggle [Hello Python](https://www.kaggle.com/code/colinmorris/hello-python) tutorial
- [Python Introduction](https://www.programiz.com/python-programming/first-program) section of Programiz tutorial

## References

### Python Tutorials
- [Kaggle Interactive Tutorials](https://www.kaggle.com/learn/python)
- [Programiz Tutorials and Examples](https://www.programiz.com/python-programming)

### Python
- [Python data types](https://docs.python.org/3/library/stdtypes.html)
- [Python standard library reference](https://docs.python.org/3/library/)
- [Python Style Guide](https://www.python.org/dev/peps/pep-0008/)
- [Python naming conventions (brief)](https://visualgit.readthedocs.io/en/latest/pages/naming_convention.html)
- [Guide to the print() function](https://realpython.com/python-print/)
- [The Python Tutorial](https://docs.python.org/3/tutorial/#the-python-tutorial)

### Shell/CLI
- [Ubuntu CLI Guide](https://ubuntu.com/tutorials/command-line-for-beginners#1-overview)
- [Learning The Shell](https://linuxcommand.org/lc3_learning_the_shell.php)
- [Basic Linux Commands](basic_cli.md)
