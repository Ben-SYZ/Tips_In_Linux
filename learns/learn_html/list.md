https://www.w3school.com.cn/html/html_lists.asp
* 无序列表
`<ul>`
```html
<ul>
<li>Coffee</li>
<li>Milk</li>
</ul>
```
列表项内部可以使用段落、换行符、图片、链接以及其他列表等等。

* 有序列表
`<ol>`
```html
<ol>
<li>Coffee</li>
<li>Milk</li>
</ol>
```
* 定义列表

自定义列表不仅仅是一列项目，而是项目及其注释的组合。

自定义列表以 `<dl>` 标签开始。每个自定义列表项以 `<dt>` 开始。每个自定义列表项的定义以 `<dd>` 开始。

```html
<dl>
<dt>Coffee</dt>
  <dd>Black hot drink</dd>
<dt>Milk</dt>
  <dd>White cold drink</dd>
</dl>
```

### 实例
* 无序
  + 圆 `<ul type="disc">`
  + 圈 `<ul type="circle">`
  + 框 `<ul type="square">`
* 有序
  + 数字列表： `<ol>`
  + 字母列表： `<ol type="A">`
  + 小写字母列表： `<ol type="a">`
  + 罗马字母列表： `<ol type="I">`
  + 小写罗马字母列表： `<ol type="i">`


有序表其他属性 `reversed` `start="5"`

提示：请使用 CSS 来定义列表和列表项目的类型。
