
HTML 表格
https://www.w3school.com.cn/html/html_tables.asp

TD: table data
th: 表头
```html
<table border="1">

<caption>我的标题</caption>

<tr>
<th>Heading 表头</th>
<th>Another Heading</th>
</tr>

<tr>
<td>row 1, cell 1</td>
<td>row 1, cell 2</td>
</tr>
<tr>
<td>row 2, cell 1</td>
<td>row 2, cell 2</td>
</tr>
</table>
```
没有数据的单元格可以添加一个 *空格占位符* `<td>&nbsp;</td>`

垂直表头：
```html
<h4>垂直的表头：</h4>
<table border="1">
<tr>
  <th>姓名</th>
  <td>Bill Gates</td>
</tr>
<tr>
  <th>电话</th>
  <td>555 77 854</td>
</tr>
<tr>
  <th>电话</th>
  <td>555 77 855</td>
</tr>
</table>
```

### 合并单元格
* 横跨两列的单元格
`colspan="2"`
```html
<table border="1">
<tr>
  <th>姓名</th>
  <th colspan="2">电话</th>
</tr>
<tr>
  <td>Bill Gates</td>
  <td>555 77 854</td>
  <td>555 77 855</td>
</tr>
</table>
```

* 横跨两行的单元格：
`rowspan="2"`
```html
<table border="1">
<tr>
  <th>姓名</th>
  <td>Bill Gates</td>
</tr>
<tr>
  <th rowspan="2">电话</th>
  <td>555 77 854</td>
</tr>
<tr>
  <td>555 77 855</td>
</tr>
</table>
```
###  单元格边距和间距
padding 里面填充，spacing cell之间的距离
```html
<table border="1" cellpadding="100" cellspacing="10"> </table>
```

### 表格/单元格颜色和图片
```html
<table bgcolor="red"></table>
<table background="/i/eg_bg_07.gif"></table>
<td bgcolor="red">First</td>
<td background="/i/eg_bg_07.gif"> Second</td>
```

### 对齐方式

```html
<th align="left">消费项目....</th>
<td align="right">$241.10</td>
```

### frame属性
边框属性
```html
<table frame="box">
<table frame="above">
<table frame="below">
<table frame="hsides">
<table frame="vsides">
```

### `<thead>`, `<tbody>`, `<tfoot>`
```html

<html>
<head>
<style type="text/css">
thead {color:green}
tbody {color:blue;height:50px}
tfoot {color:red}
</style>
</head>
<body>

<table border="1">
  <thead>
    <tr>
      <th>Month</th>
      <th>Savings</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>January</td>
      <td>$100</td>
    </tr>
    <tr>
      <td>February</td>
      <td>$80</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td>Sum</td>
      <td>$180</td>
    </tr>
  </tfoot>
</table>

</body>
</html>
```

#### 他们的属性
```html
<thead align="left"> <tr><th></th></tr> </thead>
<!-- left right center(default) justify(等宽) char(对齐一个符号,少)--> 

<thead valign="left"> <tr><th></th></tr> </thead>
<!-- top middle bottom baseline

bottom p底对别的，baseline p的圈对别的
https://www.w3school.com.cn/tags/att_thead_valign.asp
-->
```
* 全局属性
类似class等
https://www.w3school.com.cn/tags/html_ref_standardattributes.asp

* 事件属性：
HTML 有能力让事件触发浏览器中的动作，例如当用户单击元素时启动 JavaScript。
https://www.w3school.com.cn/tags/html_ref_eventattributes.asp




