| 环境变量    | 描述                                                                   | 值示例                                                                                                   |
|-------------|------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| http_proxy  | 为http变量设置代理；默认不填开头以http协议传输                         | 10.0.0.51:8080 <br> user:pass@10.0.0.10:8080 <br> socks4://10.0.0.51:1080 <br> socks5://192.168.1.1:1080 |
| https_proxy | 为https变量设置代理；                                                  | 同上                                                                                                     |
| ftp_proxy   | 为ftp变量设置代理；                                                    | 同上                                                                                                     |
| all_proxy   | 全部变量设置代理，设置了这个时候上面的不用设置                         | 同上                                                                                                     |
| no_proxy    | 无需代理的主机或域名；<br> 可以使用通配符； <br> 多个时使用“,”号分隔； | *.aiezu.com,10.*.*.*,192.168.*.*, <br> *.local,localhost,127.0.0.1&nbsp;                                 |

```sh
export proxy="http://127.0.0.1:8080"
export http_proxy=$proxy
export https_proxy=$proxy
export ftp_proxy=$proxy
export no_proxy="localhost, 127.0.0.1, ::1"
```

而对于要取消设置可以使用如下命令，其实也就是取消环境变量的设置：

```sh
unset http_proxy
unset https_proxy
unset ftp_proxy
unset no_proxy
```

Own use:

* sslocal: `localport` (8080)    ---socks5---> server:port
* privoxy: `listen-address 8118` ---http-----> `forward-socks5t .zzux.com 127.0.0.1:8080 .` (8080)

Share:
* server:  add one more listen address `listen-address 192.168.1.102:8111`
* others:
	privoxy: `listen-address 8118` ---http---> `forward 030buy.com 192.168.1.102:8111`

in short:
	own:    browser ---------http-------------> privoxy --socks5--> sslocal --socks5--> server
	others: browser --http--> privoxy --http--> privoxy --socks5--> sslocal --socks5--> server
	
others: browser --8118--> privoxy --8111--> privoxy --8080--> sslocal --xxxxxx--> server
others: browser --http--> privoxy --http--> Me[privoxy --socks5--> sslocal] --socks5--> server





