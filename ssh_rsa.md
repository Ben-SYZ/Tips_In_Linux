# ssh login with rsa

## 文件信息
rsa 密钥位置：`~/.ssh`
ssh 配置文件：`/etc/ssh/ssh_config`

## 操作

1. **client** 生成密钥对：rsa 和 rsa.pub

`ssh-keygen -t rsa`

2. 将rsa.pub附加到**server** ~/.ssh/authorized_keys的文件内。 [link](https://www.ruanyifeng.com/blog/2011/12/ssh_remote_login.html)

	Following 2 codes are excuted on client
	1. `ssh-copy-id [-i ~/.ssh/rsa.pub] user@host`
	2. `ssh user@host 'mkdir -p .ssh && cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub`
	
	result:
	```sh
	# Now try logging into the machine, with:   "ssh 'usr@host'" and check to make sure that only the key(s) you wanted were added.
	```

3. **client** 可以直接连接**server**

### [Termux](http://blog.lujun9972.win/blog/2018/01/24/%E4%BD%BF%E7%94%A8termux%E6%8A%8Aandroid%E6%89%8B%E6%9C%BA%E5%8F%98%E6%88%90ssh%E6%9C%8D%E5%8A%A1%E5%99%A8/)

```sh
pkg install openssh #install
sshd #start
ssh localhost -p 8022 #termux ssh 8022 port
ssh user@host "cat ~/.ssh/id_rsa.pub" >> ~/.ssh/authorized_keys
```

 为了方便，我们可以配置一下ssh client的配置文件,将下面内容加入到 ~/.ssh/config 文件中

```sh
Host termux
     HostName 192.4.4.9
     Port 8022
```
