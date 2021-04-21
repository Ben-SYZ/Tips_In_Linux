syn, syn/ack, ack

* SYN表示建立连接，
* FIN表示关闭连接，
* ACK表示响应，
* PSH表示有 DATA数据传输，
* RST表示连接重置。


 但SYN与FIN是不会同时为1的，因为前者表示的是建立连接，而后者表示的是断开连接。

1. 第一次握手：主机A发送位码为syn＝1，随机产生seq number=1234567的数据包到服务器，主机B由SYN=1知道，A要求建立联机；
2. 第二次握手：主机B收到请求后要确认联机信息，向A发送ack number=(主机A的seq+1)，syn=1，ack=1，随机产生seq=7654321的包；
3. 第三次握手：主机A收到后检查ack number是否正确，即第一次发送的seq number+1，以及位码ack是否为1，若正确，主机A会再发送ack number=(主机B的seq+1)，ack=1，主机B收到后确认seq值与ack=1则连接建立成功。
