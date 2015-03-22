#! /bin/bash 
#### Created by Daniel Hadley #####
# Automates the creation and posting of new rat news

### Pull the latest version in case changes were made

cd /home/pi/Github/ratmaps/
git pull

# run the script that creates the newest blog post
# but first activate     
cd /home/pi/Python_Home/2015_Rat_News/env/
source bin/activate

# http://stackoverflow.com/questions/4150671/python-how-to-set-virtualenv-for-a-crontab
# virtualenv is now active, which means your PATH has been modified.
# Don't try to run python from /usr/bin/python, just run "python" and
# let the PATH figure out which version to run (based on what your
# virtualenv has configured).

python /home/pi/Github/rmR/ratBlogScripts/RatBlog.py

deactivate

# Commit all changes to the blog
cd /home/pi/Github/ratmaps/
git add .
git commit -a -m "Weekly News"
git push
