page 516

范例四:我想要删除最后面那个目录,亦即从 : 到 bin 为止的字串
[dmtsai@study ~]$ echo ${path%:*bin}
/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/dmtsai/.local/bin
# 注意啊!最后面一个目录不见去!
# 这个 % 符号代表由最后面开始向前删除!所以上面得到的结果其实是来自如下:
# /usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/dmtsai/.local/bin:/home/dmtsai/bin
范例五:那如果我只想要保留第一个目录呢?
[dmtsai@study ~]$ echo ${path%%:*bin}
/usr/local/bin
# 同样的, %% 代表的则是最长的符合字串,所以结果其实是来自如下:
# /usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/dmtsai/.local/bin:/home/dmtsai/bin
