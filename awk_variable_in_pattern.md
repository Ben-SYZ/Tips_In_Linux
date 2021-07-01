```sh
awk -v dormitory=$dormitory -v today_y="$today_y" -v three_days_ago_y="$three_days_ago_y" '($0~dormitory),($0~today_y||$0~three_days_ago_y){print $0}')
```
