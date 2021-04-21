wttr

https://weather.cma.cn/web/weather/58468.html
	- echo $(curl -s "https://weather.cma.cn/api/now/58468" |jq -r '.data.now.temperature') °C

http://www.nmc.cn/publish/forecast/AZJ/yuyao.html
	- curl -s http://www.nmc.cn/rest/weather\?stationid\=58468\&_\=$(date +%s) |jq -r '.data.real.weather | "\(.temperature) \(.info)"'
		+ https://stackoverflow.com/questions/28164849/using-jq-to-parse-and-display-multiple-fields-in-a-json-serially


```sh
#!/bin/zsh
#curl -s http://www.nmc.cn/rest/weather\?stationid\=58468\&_\=$(date +%s) -o weather.json
cat weather.json |jq -r '.data.real.weather | "\(.temperature) \(.info)"' | awk '{ printf $1 "°C "}
	{if ($2=="晴") print "☀ ";} 
	{if ($2~".云") print "⛅";}
	{if ($2=="阴") print "☁ ";}
	{if ($2~".雨") print "🌧 ";}
	{if ($2~".雪") print "❄ ";}
	'
# https://www.google.com/get/noto/help/emoji/travel-places/
```
