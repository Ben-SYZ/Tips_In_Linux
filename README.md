# Here are some tips when I using linux.

## branch

* master: all the tips

* arch: tips I used now, I remove the unimportant parts from this branch.

* others

## how to manage this repository

Add the new tips in `master`,checkout to `arch` branch and merge from `master`.

Remove the unused tips in `arch`.

## Easy tool for this repository

prepare

```sh
ln -s ~/Tips/SimpleTool/ThisRepoGit/gitadd.sh ~/.local/bin/gadd
ln -s ~/Tips/SimpleTool/ThisRepoGit/gitmerge.sh ~/.local/bin/gmerge
```

steps:

when you are at `arch` branch:

```sh
gadd files
git commit -m ''
gmerge
```
