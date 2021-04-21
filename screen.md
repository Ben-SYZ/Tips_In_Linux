【原创】linux下Screen的用法
　　在linux开发中，我们经常用终端软件连入linux服务器进行一些操作，或者编辑代码。当需要编辑多个文件，并且经常要执行一些系统命令时，不得已要开多个终端窗口连入服务器或者来回进行文件切换或者退出文件编辑来执行系统命令，造成效率低下而且繁琐。
　　如果经常遇到这样的问题，那就应该尝试使用以下linux的Screen工具了。Screen是一个可以在多个进程之间多路复用一个物理终端的窗口管理器。Screen中有会话的概念，用户可以在一个screen会话中创建多个screen窗口，在每一个screen窗口中就像操作一个真实的telnet/SSH连接窗口那样。在使用过程中可以退出screen，甚至可以关掉登录窗口，下次再进去重新挂上screen会话，所有工作全部都会恢复。
　　
　　第一步工作，肯定是先启动screen了。很简单，在linux命令行中输入：screen即可，就进入了screen环境。进入了就要退出，退出有两种方式，一个是完全退出，输入exit就是完全退出。另一个是Detached，CTRL-a+d（先按CTRL-a，然后按d字母），就可以Detached了。Detached是一种术语叫法。这两种退出的区别就是exit是完全退出，不会进行session保存了。而第二种仍然保持会话，用screen -r就可恢复到原来的工作状态了！

　　刚刚说过，Screen是一个可以在多个进程之间多路复用一个物理终端的窗口管理器，现在要体会他的强大之处了。执行screen命令后就自动创建了一个window，我们可以执行各种命令，进行文件编辑。这是后我突然需要另外一个窗口来执行其他要工作很长时间的脚本、程序或者命令，就可以创建新的窗口来执行，不会影响到当前工作环境了。输入CTRL-a+c（先按CTRL-a，然后按d字母），会出现一个新的页面命令行提示符，可以开始干自己的工作了！开始后，怎么切换回原来的window呢？有两种方法，一是CTRL-a CTRL-a（按两遍CTRL-a），就可以顺序在多个window中切换。或者CTRL-a+0-9（按CTRL-a后按0到9任意数字）就会出现对应的window了。比如说我们第一次用screen进入的window编号是为0，然后我们需要新的window来执行命令，就创建了一个新的window，编号为1。现在我要切换回去了，直接按CTRL-a+0，就回到原先那个window啦。

　　除了一个screen可以包含多个window，也可以在创建多个screen。创建多个screen也很简单，退出screen（Detached退出模式），然后再执行screen命令，就创建了2个screen。用screen -ls可以查看有多少个screen被创建。执行screen -ls后，每个列出的screen有个pid编号，当我们要恢复某个screen的窗口时，只需输入screen -r pid 就可以恢复到指定screen了！

　　上文都是screen常用的功能，其实还包含其他很多功能，有待大家去挖掘了：man screen，就可以认真研究啦！
分类: linux
