
### `find -delete`
check `../find.md`
delete belongs to find

`-delete` will perform better because it doesn\'t have to spawn an
external process for each and every matched file.

It is possible that you may see `-exec rm {} \;` often recommended
because `-delete` does not exist in all versions of `find`. I can\'t
check right now but I\'m pretty sure I\'ve used a `find` without it.

Both methods should be \"safe\".

**EDIT** per comment from \@doitmyway: make sure you match on the name
and *then* delete, not the other way around (delete, then match).
Otherwise *every file will be deleted, whether it matches or not*. I.e.,
**DO NOT** do this: `find / -delete -name .DS_Store`.

A common method for avoiding the overhead of spawning an external
process for each matched file is:

    find / -name .DS_Store -print0 | xargs -0 rm

(but note that there is a portability problem here too: not all versions
of find have `-print0`!)


https://unix.stackexchange.com/questions/167823/find-exec-rm-vs-delete



### hook
```sh
yay -S kernel-modules-hook
```

https://bbs.archlinux.org/viewtopic.php?id=244767

```config
#/usr/share/libalpm/hooks/
#save-running-kernel-modules-pre.hook

[Trigger]
Operation = Upgrade
Operation = Remove
Type = Package
Target = linux

[Action]
Depends = bash
Depends = find
Depends = mkdir
Depends = cp
When = PreTransaction
Exec = /usr/bin/bash -c "/usr/bin/find . -type l -exec test ! -e {} \; -delete; /usr/bin/mkdir -p /tmp/save-running-kernel-modules && /usr/bin/cp -a /usr/lib/modules/$(uname -r) /tmp/save-running-kernel-modules"
```

```config

# save-running-kernel-modules-post.hook:
[Trigger]
Operation = Upgrade
Operation = Remove
Type = Package
Target = linux

[Action]
Depends = bash
Depends = ln
When = PostTransaction
Exec = /usr/bin/bash -c "/usr/bin/ln -s /tmp/save-running-kernel-modules/$(uname -r) /usr/lib/modules/$(uname -r)"
```


