
[lily](https://www.zhihu.com/people/lilydjwg/answers?page=12)

tar c ... | tar x -C ... 

---
[others](http://blog.lujun9972.win/blog/2016/12/21/%E4%BD%BF%E7%94%A8tar%E4%BB%A3%E6%9B%BFcp%E8%BF%9B%E8%A1%8C%E6%8B%B7%E8%B4%9D/index.html)
tar cvf - * | (cd /dest/dir && tar xvfp -)

tar -cvf - * | ssh remote_host 'cd /dest;tar xvfp -'

