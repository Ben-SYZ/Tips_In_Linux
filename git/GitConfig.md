# git config

## my ~/.gitconfig file

```config
[user]
	email = bensongsyz@gmail.com
	name = Ben
[core]
	editor = /usr/bin/nvim
[alias]
	llog = log --graph --oneline --decorate --all
```

## add SSH keys to github

1. 创建SSH Keys
```sh
ssh-keygen -t rsa -C "bensongsyz@gmail.com"
```
2. 查看SSH公钥于 ~/.ssh/复制到github上
	It's ssh key, but not for repository

## add alias.llog

git config --global alias.llog "log --graph --oneline --decorate --all"

*Do NOT forget the '--global'*

## editor

git config --global core.editor /usr/bin/nvim
