[ref](https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow)
```vim
:profile start profile.log
:profile func *
:profile file *
" At this point do slow actions
:profile pause
:noautocmd qall!
```
