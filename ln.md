
```sh
$ ll sym*
lrwxrwxrwx 1 ben ben    5 Jun 27 00:42 sym -> symbo

symbo:
total 8.0K
drwxr-xr-x  2 ben ben 4.0K Jun 27 00:40 .
drwxr-xr-x 26 ben ben 4.0K Jun 27 00:42 ..
-rw-r--r--  1 ben ben    0 Jun 27 00:40 abc
```




```sh
ln -s symbol sym
/bin/rm -r sym/
/bin/rm: cannot remove 'sym/': Not a directory
# And it REMOVE the all the files in ./symbol/*
# keep sym
```

```sh
/bin/rm -r sym
# Only remove the sym
```

```sh
/bin/rm sym/
# All keep because sym/ is a directory
```


```sh
rm sym
# Only remove the sym
```
