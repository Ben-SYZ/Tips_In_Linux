https://zhuanlan.zhihu.com/p/250493093

https://learnku.com/articles/9377/git-log-is-not-very-good-lets-merge-commit
git rebase -i HEAD~3

---
git rebase -i <commit>

修改 pick 为 edit wq

git commit --amend 修改当前的commit

git rebase --edit-todo 就是之前的 interactive 那个文件
git rebase --continue 继续下一个动作(到下一个 edit)

这个时候查看 status,发现它是重新分支重新commit了，然后你修改这个commit


---
第一个分支

git rebase --root -i
