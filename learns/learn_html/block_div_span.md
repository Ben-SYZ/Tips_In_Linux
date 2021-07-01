


可以通过 `<div>` 和 `<span>` 将 HTML 元素组合起来。

## HTML 块元素

大多数 HTML 元素被定义为块级元素或内联元素。

编者注：“块级元素”译为 block level element，“内联元素”译为 inline element。

块级元素在浏览器显示时，通常会以新行来开始（和结束）。

例子：`<h1>`, `<p>`, `<ul>`, `<table>`

## HTML 内联元素

内联元素在显示时通常不会以新行开始。

例子：`<b>`, `<td>`, `<a>`, `<img>`


## HTML `<div>` 元素

HTML `<div>` 元素是块级元素，它是可用于组合其他 HTML 元素的容器。

`<div>` 元素没有特定的含义。除此之外，由于它属于块级元素，浏览器会在其前后显示折行。

如果与 CSS 一同使用，`<div>` 元素可用于对大的内容块设置样式属性。

`<div>` 元素的另一个常见的用途是文档布局。它取代了使用表格定义布局的老式方法。使用 `<table>` 元素进行文档布局不是表格的正确用法。`<table>` 元素的作用是显示表格化的数据。


## HTML `<span>` 元素

HTML `<span>` 元素是内联元素，可用作文本的容器。

`<span>` 元素也没有特定的含义。

当与 CSS 一同使用时，`<span>` 元素可用于为部分文本设置样式属性。

## div
可以对同一个 `<div>` 元素应用 class 或 id 属性，但是更常见的情况是只应用其中一种。这两者的主要差异是，class 用于元素组（类似的元素，或者可以理解为某一类元素），而 id 用于标识单独的唯一的元素。

### 例子
```html
<body>

 <h1>NEWS WEBSITE</h1>
  <p>some text. some text. some text...</p>
  ...

 <div class="news">
  <h2>News headline 1</h2>
  <p>some text. some text. some text...</p>
  ...
 </div>

 <div class="news">
  <h2>News headline 2</h2>
  <p>some text. some text. some text...</p>
  ...
 </div>

 ...
</body>
```

## span
可以为 span 应用 id 或 class 属性，这样既可以增加适当的语义，又便于对 span 应用样式。
```html
<p class="tip"><span>提示：</span>... ... ...</p>
```

```css
p.tip span {
	font-weight:bold;
	color:#ff9955;
	}
```
