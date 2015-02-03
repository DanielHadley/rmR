#!/bin/sh

#### Created by Daniel Hadley #####
# Automates the creation and posting of new rat maps

# run the script that creates the newest map
Rscript NYCWeekly.R


## Takes last week's post, copies it, and replaces map
today=`date +%Y-%m-%d` # date as variable
lastWeek=$(date -j -v-7d +"%Y-%m-%d")

UStoday=`date +%m-%d-%Y` # US date as variable
USlastWeek=$(date -j -v-7d +"%m-%d-%Y")

# Pull the latest version in case changes were made
cd ../ratmaps/
git pull

cd ./_posts/

# Create a new weekly post as a copy of last week's
cp $lastWeek-NYC-Rats.md ./$today-NYC-Rats.md

# Replace the old date in the link to the map
perl -pi -e "s/$lastWeek/$today/g" ./$today-NYC-Rats.md

# Replace the old date in the link to the title
perl -pi -e "s/$USlastWeek/$UStoday/g" ./$today-NYC-Rats.md


# Commit all changes to the blog
cd ..
git add .
git commit -a -m "NYC Weekly"
git push
