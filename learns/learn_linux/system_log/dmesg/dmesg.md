## what is `dmesg`
dmesg (diagnostic message[1]) is a command on most Unix-like operating systems that prints the message buffer of the kernel.[2] The output includes messages produced by the device drivers.

## What are the concepts of “kernel ring buffer”, “user level”, “log level”?
Yes, all of this has to do with logging. No, none of it has to do with runlevel or "protection ring".

The kernel keeps its logs in a ring buffer. The main reason for this is so that the logs from the system startup get saved until the syslog daemon gets a chance to start up and collect them. Otherwise there would be no record of any logs prior to the startup of the syslog daemon. The contents of that ring buffer can be seen at any time using the dmesg command, and its contents are also saved to /var/log/dmesg just as the syslog daemon is starting up.

https://unix.stackexchange.com/questions/198178/what-are-the-concepts-of-kernel-ring-buffer-user-level-log-level

总的来说就是记录内核日志的，syslog还没启动时内核日志来自dmesg



