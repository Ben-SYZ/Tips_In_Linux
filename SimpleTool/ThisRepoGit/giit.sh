git checkout master
git add ${@:2}
git commit -m "$1"
git checkout arch
git merge master
