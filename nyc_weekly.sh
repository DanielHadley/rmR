
today=`date +%Y-%m-%d` # or whatever pattern you desire

cd _posts/

cp 2015-01-29-NYC.md ./$today-NYC.md

perl -pi -e 's/X/today/g' ./$today-NYC.md