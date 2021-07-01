https://qastack.cn/server/278743/ssh-x11-not-working

man sshd

```sh
if read proto cookie && [ -n "$DISPLAY" ]; then
	if [ `echo $DISPLAY | cut -c1-10` = 'localhost:' ]; then
		# X11UseLocalhost=yes
		echo add unix:`echo $DISPLAY |
		    cut -c11-` $proto $cookie
	else
		# X11UseLocalhost=no
		echo add $DISPLAY $proto $cookie
	fi | xauth -q -
fi


if [ "$SSH_CONNECTION" = "" ]; then
    /etc/ssh/my_sshrc &
    trap "echo " INT TERM EXIT
fi
```
