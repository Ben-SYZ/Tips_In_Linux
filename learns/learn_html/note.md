


```html
<html> 与 </html> 之间的文本描述网页
<body> 与 </body> 之间的文本是可见的页面内容
<h1> 与 </h1> 之间的文本被显示为标题
<p> 与 </p> 之间的文本被显示为段落
```

---
```
标题
<h1> - <h6>
段落
<p>
链接: 超链接（hyper text），或者按照标准叫法称为锚（anchor）
<a href="http://www.w3school.com.cn">This is a link</a>
图像
<img src="w3school.jpg" width="104" height="142" />
<br /> 是关闭空元素的正确方法
```

开放标签（opening tag），结束标签常称为闭合标签（closing tag）

---
属性
```
<h1> 定义标题的开始。
<h1 align="center">

<body> 定义 HTML 文档的主体。
<body bgcolor="yellow"> 拥有关于背景颜色的附加信息。

<table> 定义 HTML 表格。（您将在稍后的章节学习到更多有关 HTML 表格的内容）
<table border="1"> 拥有关于表格边框的附加信息。
```

属性值应该始终被包括在引号内。双引号是最常用的，不过使用单引号也没有问题。

[完整的 HTML 参考手册](https://www.w3school.com.cn/tags/index.asp)
| 属性  | 值               | 描述                                     |
|-------|------------------|------------------------------------------|
| class | classname        | 规定元素的类名（classname）              |
| id    | id               | 规定元素的唯一 id                        |
| style | style_definition | 规定元素的行内样式（inline style）       |
| title | text             | 规定元素的额外信息（可在工具提示中显示） |

---
标题
```
<hr /> 标签在 HTML 页面中创建水平线。

hr 元素可用于分隔内容。
```
提示：使用水平线 (`<hr>` 标签) 来分隔文章中的小节是一个办法（但并不是唯一的办法）。

----
段落

* 注释：浏览器会自动地在段落的前后添加空行。（`<p>` 是块级元素）

* 提示：使用空的段落标记 `<p></p>` 去插入一个空行是个坏习惯。用 `<br />` 标签代替它！（但是不要用 `<br />` 标签去创建列表。不要着急，您将在稍后的篇幅学习到 HTML 列表。）

如果您希望在不产生一个新段落的情况下进行换行（新行），请使用 `<br />` 标签：

```html
<p>This is<br />a para<br />graph with line breaks</p>
```

---
样式 style

|align |	定义文本的对齐方式|
|bgcolor |	定义背景颜色|
|color |	定义文本颜色|

```html
background-color 属性为元素定义了背景颜色：
<body style="background-color:yellow">

font-family、color 以及 font-size 属性分别定义元素中文本的字体系列、颜色和字体尺寸：
<p style="font-family:arial;color:red;font-size:20px;">A paragraph.</p>

text-align 属性规定了元素中文本的水平对齐方式：
<h1 style="text-align:center">This is a heading</h1>
```


* 文本格式化
```html
<b>This text is bold</b>
<strong>This text is strong</strong>
<big>This text is big</big>
<em>This text is emphasized</em>
<i>This text is italic</i>
<small>This text is small</small>
<sub>subscript</sub>
<sup>superscript</sup>
```

* 预格式文本
```html
<pre>
这是
预格式文本。
它保留了      空格
和换行。
</pre>
```
* “计算机输出”标签
https://www.w3school.com.cn/tiy/t.asp?f=eg_html_computeroutput

* 地址
```html
<address>
Written by <a href="mailto:webmaster@example.com">Donald Duck</a>.<br>
Visit us at:<br>
Example.com<br>
Box 564, Disneyland<br>
USA
</address>
```

* 缩写和首字母缩写
```html
<abbr title="etcetera">etc.</abbr>
<acronym title="World Wide Web">WWW</acronym>
```

* 文字方向
```html
如果您的浏览器支持 bi-directional override (bdo)，下一行会从右向左输出 (rtl)；

<bdo dir="rtl">
Here is some Hebrew text
</bdo>
```

* 块引用
```html
块
<blockquote>
这是长的引用。这是长的引用。这是长的引用。这是长的引用。这是长的引用。这是长的引用。这是长的引用。这是长的引用。这是长的引用。这是长的引用。这是长的引用。
</blockquote>

行内
<q>
这是短的引用。
</q>
```

* 删除字效果和插入字效果

```html
<p>一打有 <del>二十</del> <ins>十二</ins> 件。</p>
```

---
引用

```html
<q />
<blockquote />
<abbr />
<address />

HTML <dfn> 元素定义项目或缩写的定义。
<p><dfn title="World Health Organization">WHO</dfn> 成立于 1948 年。</p>

用于著作标题的 HTML <cite>
<p><cite>The Scream</cite> by Edward Munch. Painted in 1893.</p>

```

---
颜色
Color HEX

提示：仅仅有 16 种颜色名被 W3C 的 HTML4.0 标准所支持。它们是：aqua, black, blue, fuchsia, gray, green, lime, maroon, navy, olive, purple, red, silver, teal, white, yellow。

---
CSS 样式
格式化文档

* 外部样式表
```html
<head>
<link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
```
* 内部样式表
```html
<head>

<style type="text/css">
body {background-color: red}
p {margin-left: 20px}
</style>
</head>
```

* 内联样式

当特殊的样式需要应用到个别元素时，就可以使用内联样式。 使用内联样式的方法是在相关的标签中使用样式属性。样式属性可以包含任何 CSS 属性。以下实例显示出如何改变段落的颜色和左外边距。

<p style="color: red; margin-left: 20px">
This is a paragraph
</p>

```
<style> 	定义样式定义。
<link> 	定义资源引用。
<div> 	定义文档中的节或区域（块级）。
<span> 	定义文档中的行内的小块或区域。
```

---
HTML 链接
使用 Target 属性，你可以定义被链接的文档在何处显示。

下面的这行会在新窗口打开文档：

* target 属性
```html
<a href="http://www.w3school.com.cn/" target="_blank">Visit W3School!</a>
```
* name 属性
您可以使用 name 属性创建 HTML 页面中的书签。
```html
<a name="tips">Tips: 有用的提示：</a>
<a href="#tips">有用的提示</a>
<a href="http://www.w3school.com.cn/html/html_links.asp#tips">有用的提示</a>
假如浏览器找不到已定义的命名锚，那么就会定位到文档的顶端。不会有错误发生。
```
Tips: 请始终将正斜杠添加到子文件夹避免两次请求。1. ../http 2. ../http/

* 邮件：
%20 替换 空格
```html
这是邮件链接：
<a href="mailto:someone@microsoft.com?subject=Hello%20again">发送邮件</a>

这是另一个 mailto 链接：
bcc 密送
cc 第二个人
<a href="mailto:someone@microsoft.com?cc=someoneelse@microsoft.com&bcc=andsomeoneelse2@microsoft.com&subject=Summer%20Party&body=You%20are%20invited%20to%20a%20big%20summer%20party!">发送邮件！</a>
```

[跳出框架](https://www.w3school.com.cn/tiy/t.asp?f=eg_html_frame_getfree)

---
HTML 图像

`<img>` 是空标签，意思是说，它只包含属性，并且没有闭合标签。
定义语法 `<img src="url" />`

* 替换文本属性（Alt）
alt 属性用来为图像定义一串预备的可替换的文本。替换文本属性的值是用户定义的。

* 实例
#### 图像背景
```html
<body background="/i/eg_background.jpg">
<!--
https://www.w3school.com.cn/i/eg_background.jpg
-->
<p>gif 和 jpg 文件均可用作 HTML 背景。</p>
<p>如果图像小于页面，图像会进行重复。</p>
</body>
```

（文字的background-color: style="background-color:yellow">）

#### 排列图像
```html
https://www.w3school.com.cn/tiy/t.asp?f=eg_html_image_align
<p>图像 <img src="/i/eg_cute.gif" align="bottom"> 在文本中</p>
<p>图像 <img src ="/i/eg_cute.gif" align="middle"> 在文本中</p>
<p>图像 <img src ="/i/eg_cute.gif" align="top"> 在文本中</p>
```
（文字的align: style="text-align:center"）

#### [浮动图像](https://www.w3school.com.cn/tiy/t.asp?f=eg_html_image_float)
```html
<p>
<img src ="/i/eg_cute.gif" align ="left"> 
带有图像的一个段落。图像的 align 属性设置为 "left"。图像将浮动到文本的左侧。
</p>

<p>
<img src ="/i/eg_cute.gif" align ="right"> 
带有图像的一个段落。图像的 align 属性设置为 "right"。图像将浮动到文本的右侧。
</p>
```

#### [调整图像尺寸](https://www.w3school.com.cn/tiy/t.asp?f=eg_html_image_size)
```html
<img src="/i/eg_mouse.jpg" width="50" height="50">
```

#### [为图片显示替换文本](https://www.w3school.com.cn/tiy/t.asp?f=eg_html_image_alt)
alt="向左转"
在浏览器无法载入图像时，替换文本属性告诉读者们失去的信息。

#### [制作图像链接](https://www.w3school.com.cn/tiy/t.asp?f=eg_html_image_link)
套一个`<a>`
```html
<p>
您也可以把图像作为链接来使用：
<a href="/example/html/lastpage.html">
<img border="0" src="/i/eg_buttonnext.gif" />
</a>
</p>
```

#### [把图像转换为图像映射](https://www.w3school.com.cn/tiy/t.asp?f=eg_html_ismap) 加上坐标
<a href="/example/html/html_ismap.html">
<img src="/i/eg_planets.jpg" ismap />
</a>

#### [把图像转换为图像映射](https://www.w3school.com.cn/tiy/t.asp?f=eg_html_ismap)
点击不同位置有不同的反应

```html
<html>
<body>

<p>请点击图像上的星球，把它们放大。</p>

<img
src="/i/eg_planets.jpg"
border="0" usemap="#planetmap"
alt="Planets" />

<map name="planetmap" id="planetmap">
<area
shape="circle"
coords="180,139,14"
href ="/example/html/venus.html"
target ="_blank"
alt="Venus" />
<area
shape="circle"
coords="129,161,10"
href ="/example/html/mercur.html"
target ="_blank"
alt="Mercury" />
<area
shape="rect"
coords="0,0,110,260"
href ="/example/html/sun.html"
target ="_blank"
alt="Sun" />
</map>

<p><b>注释：</b>img 元素中的 "usemap" 属性引用 map 元素中的 "id" 或 "name" 属性（根据浏览器），所以我们同时向 map 元素添加了 "id" 和 "name" 属性。</p>

</body>
</html>
```







