# Getting Started

## Course Overview

Welcome to Data Stack Academy's Data Engineering Bootcamp. By the end of this course you will be a well-seasoned Cloud Engineer. Throughout the course you will learn to use nearly all of Google Cloud Platform (GCP) analytical services. This includes services such as Google BigQuery, Dataflow, Dataproc, Cloud Pub/Sub, Cloud Run, Cloud AI, BigTable, and Cloud Composer.

We have specifically chosen Google Cloud over other cloud platforms because we believe GCP to offer the best combination of services in the data enginering space, and because the GCP services are the closest to their open source Big Data counterparts, such as Apache Hadoop, Hive, Hbase, Spark, Beam, Kafka, Airflow, and more. Learning the material in this course will also prepare you to become a professional Big Data developer.

We believe that we have put together a course curriculum that is second to none. Learning these data and cloud skills will enable you to enter the job market as a modern Data Engineer. These days, nearly all startup companies and applications run on cloud infrastructure and seek to maximize their competitive advantage by leveraging large amounts of data.

We hope you enjoy this course, and are confident that it will teach you all the necessary skills to start a rewarding career in Data Engineering.

## Setting up your development environment

Before we begin to go through the course material, it is important for everyone to set up their development environment so that you can easily access all the resources we will use for this project (code, repository material, cloud resources). Here is an overview of the setup steps:
1. [Windows Subsystem for Linux (WSL) install](#windows-subsystem-for-linux(wsl)) (for Windows users only)
1. [Clone the git repository](#git-project)
1. [Python setup](#python)
    - Account creation
    - Project setup
    - Permissions and access
    - Service account configuration
    - Storage bucket configuration
    - Cloud SDK setup
1. [IDE setup](#ide-setup)
### Windows Subsystem for Linux (WSL)

Follow the instructions for [Windows Subsystem for Linux (WSL) setup](windows-setup.md), then return here and continue to follow this guide.

### Git Project

The source code, examples, and answers to exercises on this course are accessible by cloning our Github project. Clone the project (so that you will have your own local copy) under your home directory:

```
cd ~
git clone https://github.com/datastackacademy/deb-intro.git
```

Let's walk through the project folder together. Inside it you should see:

- [data/](data/) contains source data files. You will also use it as an output folder for your scripts and utilize it for storing intermediate files and results. 
- [deb/](deb/) is the main course content folder, and contains all the code samples, instructions, and daily exercises for this course. Code samples are organized into chapters and episodes (ie: deb/ch1/ep2 refers to chapter 1 episode 2). You will be adding your python scripts for each exercise (episode) under these directories; while you can access the finished scripts (the answers) to each episode under /deb/answers.
- [getting-started/] contains introductory and overview material to help new students get quickly oriented and ready to proceed with the rest of the course.

Notice that these directories are organized as python packages. Therefore, make sure you execute your scripts as python modules using the -m option from your project root folder as shown below:
```
python -m deb.ch1.ep2.load_airlines
```
### Python

This course is developed for python 3.7. Even though python 3.8 (and 3.9) is currently available, a lot of the dependency packages used by this course (such as the google cloud components) don't support it. Please make sure that you follow the instructions below to properly install python 3.7.

You can install and use other python versions side-by-side your 3.7 version. That's why we always recommend using a python virtualenv (below).

To check if you have python3.7 installed:
```
python3.7 -V
>> Python 3.7.9
```

Follow the instructions below if you do NOT have Python 3.7 installed.

You can download python3.7 and follow installation instructions from python.org. Feel free to Google complete installation instructions for your operating system. The procedure for installing the correct version of Python depends on your operating system. Below are instructions for installing on each system.

*Do NOT change your default python3 symlink (/usr/bin/python3) under any system. We will be setting up a virtualenv, so there's no need to change your default python link.*

#### Mac OS

User brew to install python 3.7:
```
brew install python3.7
# install/upgrade pip, setuptools, and virtualenv
python3.7 -m pip install --upgrade setuptools pip virtualenv
```

#### Linux (Ubuntu)

First add the *deadsnake* ppa repos which contain Python3.7 binaries:

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
```
Now, install Python 3.7 along with pip and virtualenv:
```
sudo apt install python3.7
sudo apt install python3-pip
python3.7 -m pip install --upgrade setuptools pip virtualenv
```

#### Windows 10

Follow the instructions for [Windows Subsystem for Linux (WSL) setup](windows-setup.md), then return here and continue to follow this guide.

### Python virtualenv

ALL users MUST setup a python virtualenv (below).

A virtualenv creates an isolated Python environment where you can freely install pip dependency packages on a per-project basis without creating conflicts with the system-wide versions. This allows you to install packages locally for specific applications (ie: this bootcamp) which are only compatible with each other.

Follow the instructions below to create a new python virtualenv and install the python dependency packages used in this course:

```
# go to your project root directory
cd ~/deb
# create a virtualenv called venv
python3.7 -m venv venv
# activate your virtualenv
source venv/bin/activate
# upgrade pip and setup tools (if not done already)
python -m pip install --upgrade pip setuptools
# install python all the dependency packages for this course
pip install -r requirements.txt
# check to see if all packages are installed correctly:
pip freeze
```

### Installing Jupyter

Many of the code examples for this course are in [Jupyter notebook format](https://ipython.org/ipython-doc/3/notebook/nbformat.html). Jupyter notebooks have become the standard for interactive, collaborative programming and reproducible research. Nearly all data analysts, scientists, and engineers use these notebooks regularly as part of their work.

Installing Jupyter (with pip) is easy and the same across all systems. Simply run:
```
pip install jupyterlab
```

Once the installation finishes, you can launch Jupyter with:
```
jupyter-lab
```

Note that the name of the python package ('jupyterlab') and the name of the Jupyter binary executable ('jupyter-lab') are slightly different.

When you run Jupyter, it will give you a link to open its its browser-based interface, which lets you explore files and open and compose notebooks:

![Launching Jupyter in a web browser](img/jupyter-browser-launch.png)

Copying and pasting one of those links into your browser will bring up the interface:

![The Jupyter Lab interface](img/jupyter-interface.png)

Navigate to the project folder containing your local copy of the git repository for the course, and go to the deb/ch/ep1/ folder. Open one of the .ipynb notebook files in Jupyter and make sure that you can view it. From time to time in this course, we will make use of the ability to run code interactively in Jupyter notebooks. We'll talk more about then when we get a bit farther along. For now, just make sure that Jupyter is installed and that you know how to run it.

For more details, see the [official Jupyter installation guide](https://jupyter.org/install).

<br>

### IDE Setup

This section will give you a couple options to install and use our favorite IDEs. Feel free to use whichever one works best for you. In short:

- VS Code is much more lean and easier to get started
- PyCharm is feature rich and better suited for someone who's gonna be coding a lot in Python

We recommend VSCode for the data engineering workflow demonstrated in this course, but some people prefer PyCharm, and it is very useful for those doing a lot of Python work.

#### Microsoft Virtual Studio Code (VSCode)

VS Code

1. Download and install Visual Studio (VS) Code
    - For Ubuntu users, you can easily install VS Code via snap:
        ```
        sudo snap install code --classic
        ```
2. Once you have VS Code installed and started up, add the Python Extension. Go to the extensions tab by clicking this icon:
![VSCode extensions icon](vs_code_extensions.png)
We recommend installing a few very helpful extensions that will make your workflow much more productive.
    - Python extension: search for 'ms-python.python'. Click on the extension and install it. This contains support for python itself, linting (style checking), notebooks, and much more.
    - MySQL extension: search for 'mysql'. There are two extensions with the same name; select the one by author Jan Hun. Click to install.
    - Jupyter extension (search for 'Jupyter')
    - Github (search for 'github'). You won't be doing a lot of contribution to the git repository for this course, but having git/github integration set up in your IDE will be indispensable for when you starting working as a data engineer.
3. Navigate to project folder where you want to clone the deb project from our previous step
4. If you have already created a virtualenv in python setup, you can click the python version icon in the bottom left side of the VS Code window and select it using the drop down menu.

>If you prefer to use a terminal, you can open an inline terminal by >pressing >`ctrl+``. Use the following command to activate the virtual >environment.
>```
>source [VENV FOLDER NAME]/bin/activate
>```

Once your virtualenv is activated, you can can use pip to install the project dependencies:
```
pip install -r requirements.txt
```

VS Code has a built in Source Control interface for git. To stage and create commits, navigate to the Source Control tab by clicking on the Source Control icon, and add the files you would like to stage and commit.To change branches or create a new branch, you can click on the Git Branch icon at thebottom right of the VS code window.

VS Code has a huge number of official and community extensions, so you can customize your coding environment to your heart's content.