
1、修改用户、组和密码（涉及/etc/passwd  /etc/group/  /etc/shadow）


usermod   -g  修改用户所在的基本组

usermod  -a -G  把用户添加到一个新的附加组中

gpasswd  -a   给用户添加附加组或删除附加组,是对一个用户的附加组的操作，即把一个用户添加到附加组或者把一个用户的的附加组删除，用户的基本组保持不变。

