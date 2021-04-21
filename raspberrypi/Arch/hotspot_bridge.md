TP-Link will change the mac address, when using bridge mode, so it's better to use subnet in iptables.

Besides there are a lot arp and ssdp(udp) packets in the Intranet, which seems like will slow down the network.

Tp-Link config, bridge, **dhcpcd on**
