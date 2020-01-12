# [Enable the “Universe” repository?](https://askubuntu.com/questions/148638/how-do-i-enable-the-universe-repository)


If you want in one command and not use Software source ticking then in terminal put:

```sh
sudo add-apt-repository universe
```

On older versions of Ubuntu, you might have to use a full source line:

```sh
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
```

To enable all Ubuntu software (main universe restricted multiverse) repositories use

```sh
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
```

you can add also partner repository with different link (see difference is ubuntu to canonical)

```sh
sudo add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"
```

Then update the package list:

```sh
sudo apt-get update
```



If you want in one command and not use Software source ticking then in terminal put:

sudo add-apt-repository universe

On older versions of Ubuntu, you might have to use a full source line:

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"

To enable all Ubuntu software (main universe restricted multiverse) repositories use

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"

you can add also partner repository with different link (see difference is ubuntu to canonical)

sudo add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"

Then update the package list:

sudo apt-get update

p.s.

`$(lsb_release -sc)` checks your Ubuntu version and puts its name in the source link. Since 12.04 is called `precise`, you can test in a terminal that `lsb_release -sc` gives `precise`. That adds the precise name of your Ubuntu release in Software sources. Wrong word and nothing will work.

For all differences in repositories read [https://help.ubuntu.com/community/Repositories/Ubuntu](https://help.ubuntu.com/community/Repositories/Ubuntu)

