#!/bin/sh

#### Created by Daniel Hadley #####
# Automates the creation and posting of new rat maps

### Pull the latest version in case changes were made

cd /home/pi/Github/ratmaps/
git pull

# run the script that creates the newest map and .md file
Rscript /home/pi/Github/rmR/NYCWeekly.R


cd ./_posts/


# Commit all changes to the blog
cd ..
git add .
git commit -a -m "NYC Weekly"
git push




