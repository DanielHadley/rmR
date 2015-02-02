#### Created by Daniel Hadley #####
# Automates the creation and posting of new rat maps


# Takes last week's post, copies it, and replaces info
today=`date +%Y-%m-%d` # date as variable
lastWeek=$(date -j -v-7d +"%Y-%m-%d")

cd ../ratmaps/_posts/

# Create a new weekly post as a copy of last week's
cp $lastWeek.md ./$today-NYC.md

# Replace the old date in both the title and link to the map
perl -pi -e "s/$lastWeek/$today/g" ./$today-NYC.md