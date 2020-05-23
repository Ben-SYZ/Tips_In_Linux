The other answers are correct, in that chmod -R 755 will set these permissions to all files and subfolders in the tree. But why on earth would you want to? It might make sense for the directories, but why set the execute bit on all the files?

I suspect what you really want to do is set the directories to 755 and either leave the files alone or set them to 644. For this, you can use the find command. For example:

To change all the directories to 755 (drwxr-xr-x):


```sh
find /opt/lampp/htdocs -type d -exec chmod 755 {} \;
```
To change all the files to 644 (-rw-r--r--):

```sh
find /opt/lampp/htdocs -type f -exec chmod 644 {} \;
```
