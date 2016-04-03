#!/bin/sh

#### Created by Daniel Hadley #####
# Automates the creation and posting of new rat maps

### Pull the latest version in case changes were made

cd /home/pi/Github/ratmaps/
git pull

# run the script that creates the newest map and .md file
# The xvfb makes a virtual monitor for the pngs 
xvfb-run --server-args="-screen 0 1024x768x24" sudo Rscript /home/pi/Github/rmR/NYCWeekly.R

# Commit all changes to the blog
git add .
git commit -a -m "NYC Weekly"
git push




