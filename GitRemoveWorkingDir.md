# Git 清空工作区和暂存区
[https://blog.csdn.net/qq929371786/article/details/80014532](https://blog.csdn.net/qq929371786/article/details/80014532)
## 1. 还没有进行 add . 和 commit 操作:
清空全部已修改的问题件

```sh
git checkout .
```

### 对于*新建*的文件和文件夹无法清空, 必须组合下面命令

```sh
git clean -d
```

## 2. 已经 add . 了, 用如下命令重置

```sh
git reset .
```
