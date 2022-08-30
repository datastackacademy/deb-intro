# Welcome to [Data Stack Academy](https://www.datastack.academy/)!
<img style="float: right;"
    src="imgs/home-hero.svg" 
    alt="a picture of a person with long brown hair sitting behind a desk with a laptop next to a green plant."
    >

## The Data Engineering Hub

Welcome to the intro repository for Data Engineering Bootcamp! The full bootcamp curriculum contains seventeen chapters, taught over seventeen weeks. This public preview is limited to a modified version of the first two chapters of material.

Learn more about the course at [datastack.academy](https://www.datastack.academy/), and check out the course outline below.

## The Basics
What you're looking at now is a _repository_, also called a _repo_. A repository is a collection of a project's files. GitHub is the most popular site for storing and sharing repositories.

In this `deb-intro` repo, we'll go read the files called `README`, and work through the interactive notebooks in the `chapters` folder. The other files are scaffolding, and you can ignore them.

In class, we _clone_ the repository for the curriculum (cloning means saving a copy on your personal computer), then run and edit the code in a code editor. Here, to save you from having to install all the software, we'll clone the repository and run the notebooks online, with [Google Colab](https://colab.research.google.com/). 

## Cloning the Repository

So, how do we clone a repository from GitHub? Follow these steps:
1. **Open a terminal**
    The _terminal_ is the command center for your computer. Nearly anything you'd want to do on your computer can be done here.

    Keyboard shortcuts for opening a terminal:
    - Linux: `[Ctrl + Alt + t]`
    - Windows: `[Ctrl + Alt + w]`
    - Mac: `[Cmd + space]`, then type "terminal" into the search bar
2. In the terminal, enter the command
```bash
git clone https://github.com/datastackacademy/deb-intro.git
```
![command to clone repo](./imgs/clone_command.png)

That's it! Now you have a folder called 'deb-intro' containing the whole repository. Look in your file system to check it out.

## Notebooks in Colab
We'll go through our lessons using _notebooks_. Notebooks are interactive files with cells that can be either _Markdown_ (written for humans to read, like the file we're in now) or _Python_ (written for computers to read. Python is a popular programming language, and the one we use in this course).

To use Colab, you'll need to have a Google account, and to be signed into it. 

To open a notebook in Colab:
1. Go to [https://colab.research.google.com/](https://colab.research.google.com/) in your browser.
2. Click 'Upload', then 'Choose File'.
3. Navigate to where you cloned the `deb-intro` repo, then click through the file tree until you get to the notebook you want.
4. Select it, and presto! It will open in Colab. The notebook, and any changes you make, will be saved in your Google Drive.

**NOTES:**

1. It's possible that some of the content blocks are collapsed. To make sure that you see all the steps, expand the block by cliking the small arrow next to it.

   ![collapse_expand](imgs/colab-expand-collapse.png)

1. The gray blocks are Python code cells. You can click and edit them. In some of the exercises, we'll have to edit a Python cell and run it before we can continue to the next section, so _please make sure that you **complete** and **run** each code cell before moving onto to the next one_. You can run the code by clicking the _run_ icon to the left of the block when you hover over it.

   ![run_code](imgs/colab-run-code.png)

1. Some of the code cells depend on the values from the previous ones, so it's very important that you run each code cell before moving onto the next. Otherwise, you may get an error.

## First Steps
If you think data engineering might be your thing, there's additional information about the Data Stack Academy bootcamp below. But for now, let's get started with Python! 

Open the folder `ch1_intro` and read the README for the chapter. Then open episode 1, and the README for that episode will tell you where to go next.

### Bootcamp Overview

Section 1: Foundations

1. [Intro](./chapters/ch1_intro/)

1. [Python pt.1](./chapters/ch2_python1/)

1. Python pt.2         

1. Pandas        

1. Team Week                                                      

Section 2: Data Modeling, SQL, and the Cloud

6. SQL                                                      

7. Cloud, BQ, Data Studio              

8. Data Modeling          

9. Data Build Tool (dbt)                                                      

10. Team Week        

Section 3: Airflow and Spark

11. Airflow pt.1            

12. Airflow pt.2            

13. Spark pt.1          

14. Spark pt.2          

15. Team Week        

Section 4: Capstones

16. Visualization           

17. Capstones            

Each chapter is contained in its own folder, which contains an overview, episode links, and code and data resources. The bootcamp covers one chapter a week. Every week finishes with a graded project which ties together all of the week's material and builds on skills learned earlier in the course.


## Spread the word

We offer our data engineering bootcamp in multiple cohorts during the year. Please help spread the word to friends and family. This bootcamp is geared for non-technical folks making a complete career change.

For more information visit our website: [datastackacademy.com](https://datastack.academy)

Or [download](./docs/DataStack_brochure_v2022.08.30-sm.pdf) a small brochure including the main highlights.

[![Brochure](imgs/PamphletThumbnail.jpg)](./docs/DataStack_brochure_v2022.08.30-sm.pdf)