```sh
# /etc/profile
if [[ ":$PATH:" != *:"$HOME/.local/bin":* ]] && [[ -d "$HOME/.local/bin" ]];then
	export PATH="$PATH:$HOME/.local/bin"
	#echo "It's not there and directory exist"
fi

#case
```
