#!/bin/sh

#### Created by Daniel Hadley #####
# Automates the dail downloading of new rat data

### Pull the latest version in case changes were made

cd /home/pi/Github/rmR/
git pull

# run the script that downloads the data 
sudo Rscript /home/pi/Github/rmR/DailyDataGrabber.R

# Commit all changes to the blog
git add .
git commit -a -m "Daily Data"
git push




