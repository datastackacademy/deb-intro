# Windows Subsystem for Linux (WSL) Setup

You can use your choice of operating system throughout this course - Linux, Mac OS, or Windows. But the execution scripts and command line examples are written for a Unix-style bash shell, so Windows users will need to install [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about) (WSL), which lets you run a Linux environment directly on Windows without needing a virtual machine or a dual-boot setup. The following instructions will walk you through installing WSL.

## Enabling WSL 2

First, follow the [official install guide](https://docs.microsoft.com/en-us/windows/wsl/install) to install WSL 2, up to the section called "Ways to run multiple Linux distributions with WSL".

>**Running a Windows Build Older than 18362**
>If you are running a Windows Build lower than 18362, before enabling WSL 2 you must upgrade Windows using Windows Update Assistant. To find your Windows Build info, hit the Windows key and type 'System Information'. (At the time of this writing, the latest build is 10.0.19041)

## Installing Ubuntu 

Once you have WSL installed, you can install Ubuntu 20.04, which is our recommended Linux distribution:

**[Install Ubuntu from the Microsoft store](https://www.microsoft.com/en-us/p/ubuntu-2004-lts/9n6svws3rx71?activetab=pivot:overviewtab)**

![Installing Ubuntu from the Microsoft Store](img/wsl-ms-store.png)

<BR>

Once you have Ubuntu installed on your WSL, you should update your Ubuntu install:
1. Start a new terminal from the Start menu 
2. You will be prompted to choose a root password. Make sure to remember it (we recommend using a password manager like [LastPass](lastpass.com) or [BitWarden](bitwarden.com))
3. Run the following commands to update and upgrade Ubuntu:
```
sudo apt update
sudo apt -y upgrade
```

>You MUST first update/upgrade Ubuntu before you can properly install and run Python

## Installing Python 

This course is developed for Python version 3.7. Even though python 3.8 (and 3.9) is currently available, a lot of the dependency packages used by this course (such as the google cloud components) don't support it. Please make sure that you follow the instructions below to properly install Python 3.7.

Note: You can install and use other python versions alongside your 3.7 version. That's why we always recommend using a python virtualenv (more details below).

To install Python 3.7, first add the *deadsnake* ppa repos which contain the appropriate binaries:

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
```

Now install Python 3.7, pip, and virtualenv:
```
sudo apt install python3.7
sudo apt install python3-pip
python3.7 -m pip install --upgrade setuptools pip virtualenv
```

Some users will need to add `pip` to your PATH environment variable. If you can run `pip3` from your terminal, you can skip this step:
```
export PATH=$PATH:/home/{%USER NAME%}/.local/bin
```

# Installing and using virtualenv

virtualenv is a tool that will let you create *virtual environments*, which are project-specific Python environments where you can install packages and make other configuration changes. This will let you manage multiple Python projects, each of which has its own dependency requirements, on your system. Without virtualenv, you would inevitably run into dependency conflicts because those requirements are different for every project.

To create and use a virtual environment:
```
# to create a python3.7 specific virtualenv
python3.7 -m venv venv
# to activate your virtualenv
source venv/bin/activate
# check your python/pip version
python -V
>> Python 3.7.9
pip -V
>> pip 20.1.1 from /tmp/venv/lib/python3.7/site-packages/pip (python 3.7)
# enjoy installing pip packages
pip install tabulate
python -c 'from tabulate import tabulate; print(tabulate([["Sun",696000,1989100000],["Earth",6371,5973.6]], headers=["Planet","R (km)", "mass (x 10^29 kg)"]));'
```

Please refer to [this stackoverflow discussion](https://stackoverflow.com/questions/41430706/pyvenv-returns-non-zero-exit-status-1-during-the-installation-of-pip-stage) if you get the following error while creating your venv:
```
Error: Command '['/home/user/my_venv_dir/bin/python', '-Im', 'ensurepip', 
'--upgrade', '--default-pip']' returned non-zero exit status 1
```
To summarize, run the following to fix this issue:
```
python3.7 -m venv --without-pip venv
source venv/bin/activate
curl https://bootstrap.pypa.io/get-pip.py | python
deactivate
source venv/bin/activate
```

### Deactivating and removing a virtual environment

To deactivate the virtual environment and revert back to using your system-wide Python configuration, run

```
deactivate
```

You can delete a virtualenv (and recreate it) by removing the venv directory:

```
rm -rf venv
```

## Accessing Windows files

To easily access your Windows files, setup symlinks to your Windows directories. Your entire Windows C:\ Drive is mounted on Ubuntu under /mnt/c. The instructions below create symlinks to access your Windows's Home directory from Ubuntu:

```
cd ~
# change {%USER NAME} with your user name
ln -s /mnt/c/Users/{%USER NAME} ms-home
ls -l
```

## Improving the WSL terminal experience

The default terminal is desperately in need of few cosmetic changes to make it more friendly. One of the first things to do is turn off the exceptionally annoying tab-complete beep sound:

To disable the beep on tab-complete, uncomment these 2 lines in /etc/inputrc:

```
set bell-style none
set bell-style visible
```

This doesn't work on every WSL install. If you're still having issues, you can mute the audio output for WSL in the Sound Mixer Options. Hit the Windows home key and search for 'mixer', then mute the console audio:

![Disabling Windows terminal audio](img/wsl-disable-mixer.png)

To improve the look and feel of your terminal, add these lines to the end of your **~./bashrc** file:

```
LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
export LS_COLORS
PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\e:\[\033[1;32m\]\W\[\033[1;31m\]\$\[\033[0m\] '
```

That completes setup of WSL. Make sure that you finish going through the [Getting Started Guide](README.md) to set up your python environment and get access to GCP and the project resources we will use for the course.
### Further Reading
- [WSL Install docs](https://docs.microsoft.com/en-us/windows/wsl/install) (microsoft.com)