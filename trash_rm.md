```sh
➜  pacman -Ql trash-cli|grep bin
trash-cli /usr/bin/
trash-cli /usr/bin/trash
trash-cli /usr/bin/trash-empty
trash-cli /usr/bin/trash-list
trash-cli /usr/bin/trash-put
trash-cli /usr/bin/trash-restore
trash-cli /usr/bin/trash-rm
```

* `trash`(`trash-put`):
	put files in trash
* `trash-empty`:
	clean trash
* `trash-list`:
	List trashed files
* `trash-restore`:
	restore trashed file

`trash-put`          //将文件或目录移入回收站
`trash-empty`        //清空回收站
`trash-list`        // 列出回收站中的文件
`restore-trash`     //还原回收站中的文件
`trash-rm`          // 删除回首站中的单个文件

~/.local/share/Trash/

---
```sh
#~/.zshrc
alias sudo='sudo '
alias rm='trash-put'
```

```sh
# at /
sudo mkdir .Trash-$UID && sudo chown $USER:$USER .Trash-$UID
```

```sh
crontab monitor ~/.local/share/Trash/
```

trash_restore multi ./trash_multi.sh
