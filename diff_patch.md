Compare Documents Documents_manjaro

```sh
diff -r Documents* > doc0.patch

cat doc0.patch |grep -n '^Only'
sed -i -e '/^Only in Documents\/.*/d' doc0.patch

cat doc0.patch|grep -n  '[>]'

#%<     lines from FILE1
#%>     lines from FILE2

# others
diff -x '*.png' -x '*.mkv' -x '*.pdf' -x '*.html' -x '*.pptx' -x '*.ppt' -x '*.docx' -x '*.doc' -x '*.zip' -Naur Documents* > doc0.txt
diff -x '*.png' -x '*.mkv' -x '*.pdf' -x '*.html' -x '*.pptx' -x '*.ppt' -x '*.docx' -x '*.doc' -x '*.zip' -r Documents* > doc0.patch
```

