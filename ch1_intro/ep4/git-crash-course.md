# Git and GitHub

Git is an open source software used for version control. [GitHub](https://github.com/) is the industry standard for using Git to collaborate on development projects, and to store a portfolio of your own projects (projects on GitHub are called repositories, or repos). 

When collaborating with a team, good communication can save you a lot of trouble. Scrum meetings are a great time for each person on a development team to say what they'll be working on that day, so people aren't simultaneously changing the same file. Writing useful commit messages will also help communicate your intentions to your peers.

If you're looking for some code inspiration, [explore public repositories by topic](https://github.com/topics), or follow your friends and see what kinds of projects they're making.


## Key Terms

### Remote Repositories and Local Repositories
In the [course-overview section](https://github.com/datastackacademy/data-engineering-bootcamp/blob/main/getting-started/course-overview.md) you saw how to fork a copy of the remote data engineering bootcamp repo. You can think of a local repo as the version of a project you have on your own computer, where you can make changes to share later, and a remote repository as the one on GitHub, seen by everyone. 

### Forking and Cloning
You can also create a local repo from a remote by cloning it. A forked repository is a completely independent copy, while a cloned one is sychronized with the remote.

### Pushing and Pulling
Push changes from local -> remote. Pull changes remote -> local.

### Branches, Pull Requests, and Merging
On both the remote and local, the `main` branch is the official version of the project. Creating a branch makes a copy of the project where you can play around and make changes without affecting the `main` branch. 

If you like the changes you made on your local branch, you can push them to a corresponding remote branch and create a pull request. A pull request is a way of asking your collaborators to merge your changes with the remote `main` branch, making them part of the shared, official version of the project.

## The .gitignore File

There will often be files or directories in your local repository that you don't want to include in the remote, like data, secret keys, configuration files, or virtual environments. Files and directories that should be ignored by Git can be added to a file called `.gitignore` in the main directory of your local repo. Each line in the `.gitignore` is a pattern for the types of files or directories that should be excluded from Git. For instance, `*.csv` will exclude all CSV files, and `venv/` will exclude the virtual environment. For more info on `.gitignore` and how to use patterns to indicate types of files, [read the docs](https://git-scm.com/docs/gitignore). Also, check out the [`.gitignore` file for the data-engineering-bootcamp repository](https://github.com/datastackacademy/data-engineering-bootcamp/blob/main/.gitignore) for a thorough example. For most of the projects in this bootcamp, your `.gitignore` will only need to include your virtual environment and data files.

It's best practice, when adding files to be committed, to use
```bash
git add <FILE_NAMES>
```
...listing each file. Do NOT add files with `git add *`, which can accidentally include files that ought to be excluded.

## Exercise: Project Setup
Every week, you'll use GitHub to share a repository for your code review project. Nearly all of these will include
    - A `requirements.txt` file: you've already seen and used these in this course! It's just a list of the packages that the project in the repository needs to install before it can run. If you include a `requirements.txt` file your user can just run
    `pip install -r requirements.txt`
    then start running the code in the repo.
    - A `README.md` file: you've already seen this, too! It's what shows up on the main page of a GitHub repo. In the Data Stack Academy repository, we use the README to orient you to the content of the each episode. For your code review projects, you'll usually want to include a description of the project, a list of the technologies used, a list of the known bugs, and a diagram of how the pieces in your project fit together.
    - A `.gitignore` file: this is discussed above. If you like, you can find a thorough boilerplate `.gitignore` and use the same one every time.

This short exercise will just practice setting up a weekly code review repository. Start a new repo; you can call it whatever you want, and delete it later. Include:
    - A `REAME.md` with whatever you'd like
    - A `requirements.txt` file with `jupyterlab` version 3.3.2 (just like the one in this episode)
    - A `.gitignore` file that will ignore your Python virtual environment
    - A `practice.ipynb` notebook file, with at least one markdown cell and one code cell. Put whatever you'd like in each of the cells
    - A `main.py` file, containing some Python code. In many Python repositories, the code is all contained in `.py` files, rather than notebooks. It's convention to name the file that ties all the other pieces of the project together `main.py`

## Exercise: Solo Project with Branches

You already know how to share your weekly code review projects on GitHub. Let's practice the same process, but with branches.

Start a new project called "local-trees", initialize a Git repository, and open it in VS Code:
```bash
mkdir local-trees
cd local-trees/
git init
code .
```
Give it a file called `trees.py`:
```bash
touch trees.py
```
In `trees.py`, make a list of trees:
```python
trees = ["dogwood", "apple", "cedar"]
```
Don't forget to save the file.
Tell Git to track changes in this file, and commit what you have so far, including a commit message:
```bash
git add trees.py
git commit -m "initial commit"
```

Log into your GitHub account, and create a new repository called "remote-trees"
After you click the green "Create repository" button, follow the instructions under "…or push an existing repository from the command line".
You now have a local and a matching remote!
On your local, create a branch called `more-trees` and switch to it:
```bash
git checkout -b more-trees
```
In your `more-trees` branch, add a few of your favorite trees to your tree list, i.e.
```python
# trees.py
trees = ["dogwood", "apple", "cedar", "cyprus", "oak"]
```
Just like we did above, add the changes and commit them:
```bash
git add trees.py
git commit -m "add a few more trees"
```
Sync your local branch to a corresponding remote branch, and then push the changes branch to branch:
```bash
git branch --set-upstream-to more-trees
git push origin more-trees
```
GitHub will alert you that your remote `more-trees` branch is now different than your remote `main` branch. Follow the prompts to "Compare and pull request", "Create pull request", and "Merge pull request". Now your `main` branch has your new changes.

But wait! Now your remote `main` has changes that your local `main` doesn't. Switch back to your local `main` branch and pull down the changes:
```bash
git checkout main
git pull origin main
```
...and we're back where we started: a local `main` that matches the remote `main`.

Practice this flow a few more times:
make local branch >> commit changes >> push to remote branch >> open pull request >> merge remote branch with remote main >> pull changes from remote main to local main

## Collaborating With GitHub

Now that you know the flow of pushing, merging, and pulling, let see where GitHub really shines: working on projects with other people.

Pair up with a classmate. One person in the pair should clone their partner's "remote-trees" repository, and name their local version of it `trees-collab`:
```bash
git clone https://github.com/<PARTNER-GITHUB-PROFILE>/remote-trees.git trees-collab
```
Go to that directory, and open the project:
```bash
cd trees-collab
code .
```
Check that the local project is still synched with the remote:
```bash
git remote -v
```
Meanwhile, the person in the pair who owns the GitHub repo should give their partner permissions to push changes to it:
- In the top navigation bar of the GitHub page for the project, click "settings"
- Select "Collaborators" from the left sidebar
- In the "Manage Access" section, click the green "Add people" button
- Search for your partner by name, username, or email, and add them as a collaborator

At this point, both people in the pair have matching local versions of the "remote-trees" repository.
Each person, in your local repo: 
- Make a branch off `main` called `<YOUR-NAME>-edits`.
- Switch to that branch.
- Make a new file called `<YOUR-NAME>-trees.py`
- Add some Python code to your file! Here's and example:
```python
# alma-trees.py
tree-fact = "Dendrochronology is the study of tree rings"
```
- Save your code, commit it, and push your local branch to a corresponding remote branch:
```bash
git push origin `<YOUR-NAME>-edits`
 ```
 - Open a pull request, and ask your partner to review the new code before merging your branch into `main`.
 - Once it's merged, you can delete the branch. You can then both pull the changes from the remote `main` to your local `main`

 ## Merge Conflicts

 When two people are editing the same code simultaneously, you can get a merge conflict. Git doesn't know which version of the code should be used, so you have to comb through the changes and manually select the ones you want. With your pair, let's create a merge conflict and resolve it.

 - Start where you left off from the previous exercise: you and your pair should have matching local repositories, each synched to the same remote, and this repo should have the original `trees.py` file in it.

 Each person in the pair, on your own local repository:
 - Create and switch to a new branch off `main` called `<YOUR-NAME>-conflict`
 - Make some changes to the code that's already in there: remove some trees from the list, and add some different ones. Add whatever other code you'd like to the file.
 - Save and commit your changes.
 - Push your local branch to a corresponding remote branch:
 ```bash
 git push origin `<YOUR-NAME>-conflict`
 ```
 - On GitHub, create a pull request to merge your branch into `main`. Have your partner review it before merging.

 The first person to create a pull request and merge should have no trouble. The second person, however, will run into a merge conflict. This person should share their screen, so you can resolve the conflict together.
 - On GitHub, on the page for the pull request, click the "Resolve conflicts" button
- You'll be directed to a page that looks something like this:
```python
 <<<<<<< alma-conflict
trees = ["pomegranate", "apple", "cedar", "Christmas"]
=======
trees = ["baobob", "apple", "cedar", "poplar"]
>>>>>>> main
```
- Delete the conflict markers (`<<<<<<< alma-conflict`, `=======`, and `>>>>>>> main`)
- From the remaining code, keep the version you want, and delete the other
- Click the "Resolve conflict" button at the top right of the GitHub page
- Click the green "Commit merge" button

## Other Useful Git Commands

- See what changes have been staged for commit, and which haven't been added yet:
```bash
git status
```
It's useful to look at `git status` before committing, to make sure you're adding only what you want to. It can save you the trouble of trying to remove files from Git later.

- Show changes between the last commit and what you have that isn't commited:
```bash
git diff
```
Actually, you can use `git diff` to compare any two states of your project, like two different commits. See the [Git docs](https://git-scm.com/docs/git-diff) for more options.

- View a history of commits, with the time, commit message, and commit number:
```bash
git log
```

- Show a history of everything you've done in Git on this project, across all branches:
```bash
git reflog
```

- If your project has become a mess and you want to revert it to an earlier state, use `git reflog` to find the `HEAD@{index}` tag for the point in your project's history you want to go back to. Then use that with this command:
```bash
git reset HEAD@{index}
```

- Get rid of all the changes you made since your last commit on a file:
```bash
git restore <file>
```