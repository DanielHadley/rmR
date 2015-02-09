#!/bin/sh

#### Created by Daniel Hadley #####
# Automates the creation and posting of new rat maps

### Pull the latest version in case changes were made

cd /Users/dphnrome/Documents/Git/ratmaps/
git pull

# run the script that creates the newest map
Rscript /Users/dphnrome/Documents/Git/rmR/ChicagoWeekly.R


cd ./_posts/

# Commit all changes to the blog
cd ..
git add .
git commit -a -m "Chicago Weekly"
git push




