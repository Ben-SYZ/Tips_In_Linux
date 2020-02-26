# snippets 

## plug : 'SirVer/ultisnips'

## document

```vim
:help ultisnips
```

## make snippets for the type of this file

```vim
:ultisnipsedit
```

# document

## python

```python
a='hello world'
print((75-2*len(a))*" "+a.upper())
                                                 HELLO WORLD

```


## reg
```vim
snippet "be(gin)?( (\S+))?" "begin{} / end{}" br
\begin{${1:`!p
snip.rv = match.group(3) if match.group(2) is not None else "something"`}}
    ${2:${VISUAL}}
\end{$1}$0
endsnippet

# ------
# beg hello<C-n>
# ---
# \begin{hello}
#     
# \end{hello}
# 
# ------
# beg<C-n>
# ---
# \begin{something}
#     
# \end{something}
# 

```

```vim
------------------- SNIP -------------------
snippet "([^\s].*)\.return" "Return (postfix)" r
return `!p snip.rv = match.group(1)`$0
endsnippet
------------------- SNAP -------------------
value.return<tab> ->
return value
```

\s: space
^:  not, used in []
.:  single char


page 1030
