#! /bin/bash    
cd my/virtual/env/root/dir
source bin/activate

# http://stackoverflow.com/questions/4150671/python-how-to-set-virtualenv-for-a-crontab
# virtualenv is now active, which means your PATH has been modified.
# Don't try to run python from /usr/bin/python, just run "python" and
# let the PATH figure out which version to run (based on what your
# virtualenv has configured).

python myScript.py
