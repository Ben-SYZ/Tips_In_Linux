cat /proc/meminfo |grep MemTotal

known from `free`

```sh
Mem=$(free -h |awk 'NR==2{print $4}' )
Swap=$(free -h |awk 'NR==3{print $4}' )
echo ${Mem%i}'|'${Swap%i}
```
