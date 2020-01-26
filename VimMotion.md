# [Difference between `word` `WORD`](https://zhidao.baidu.com/question/273479210.html)

word 是字面意义上的单词，比如<go!to!school!>则，go，!，to，school分别都是单词。

而WORD是之间没有空白的一串字符。

w跳到下一个单词，

W相对于当前光标所在字符，下一个非空白连续串的首位置。

同样的e，E，b，B，ge，gE也是一样的道理。

vim 就是处理文本的，所以在控制方面是非常细致的，只要你能想到的控制方面的，都可以。

而且设计也是对称的，比如e和E，b和B。 

* b: begin，跳到本单词的开始（继续按，跳到前一个单词的开始）

* e：end，跳到本单词的结尾（继续按，跳到下一个单词的结尾）

* w：word，跳到下一个单词的开始

* ge：go end 跳到前一个单词的结尾 iskeyword主要是为了针对编程语言中，变量命名规则的不同，所以对于单词定义也不尽相同
