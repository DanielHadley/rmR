#!/bin/sh

#### Created by Daniel Hadley #####
# Automates the dail posting of new rat maps
### Pull the latest version in case changes were made

cd /home/pi/Github/ratmaps/
git pull

cd /home/pi/Github/rmR/
git pull

# run the script that downloads the data 
sudo Rscript /home/pi/Github/rmR/DailyMaps.R

# Commit all changes to the blog
cd /home/pi/Github/ratmaps/
git add .
git commit -a -m "Daily Maps"
git push




