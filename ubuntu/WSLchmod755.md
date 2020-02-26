# [子系统（WSL）中无法修改挂载盘的文件权限？](https://www.lolimay.cn/2019/09/07/wsl-cannot-modify-file-permission/) 
## Step1 创建wsl.conf文件
在 /etc 目录下创建一个 wsl.conf 文件，添加以下配置：
```
[automount]
enabled = true
options = "metadata,umask=22,fmask=11"
```

## Step2 在.bashrc中添加以下配置
```
if [ "$(umask)" = "0000" ]; then
  umask 0022
fi
```
