## Setup Checklist

### Copy the episode files into workspace dir
This example shows copying ch1_intro/ep1 files. Please change to path to match your daily episode (for example: ch1_intro/ep2, ch1_intro/ep3, etc...)

```bash
mkdir -p workspace/ch1_intro/ep1

cp -r chapters/ch1_intro/ep1/* workspace/ch1_intro/ep1
```

### Navigate to your episode
Please change to path to match your daily episode (for example: workspace/ch1_intro/ep2, workspace/ch1_intro/ep3, ...)

```bash
cd workspace/ch1_intro/ep1
```

### Create a virtual environment:
```bash
python3.7 -m venv venv
```
### Activate it:
```bash
source venv/bin/activate
```

### Install the required packages:
```bash
pip install -r requirements.txt
```

### Pull down any changes from the remote repository:
```bash
git fetch upstream

git checkout main

git merge upstream/main
```

### Resolve merge conflicts
If you encounter a _merge conflict_ error, run this command and _repeat_ the commands above:

```bash
git reset --hard upstream main
```

Merge conflicts happen when you work directly on files inside `deb/` folder. Be sure to copy daily episodes to `workspace/`. 

### Open the episode in VS Code:
```bash
code .
```

### Select your Python interpreter:
- From within VS Code : `Ctrl + Shift + p`
- A search bar will open at the top. Type 'python', then choose the option 'Python: Select Interpreter'
- From the dropdown, choose the path to your venv