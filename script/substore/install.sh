#!/bin/bash
echo "此脚本不保证可用性，如想停止执行请 Ctrl+C"
if [ ! -d "$HOME/substore" ]; then
echo "正在安装sub-store,zip,node,Nginx(前端服务)"

  apt update -y && apt install zip nodejs nginx -y
(
  mkdir -p "$HOME/substore" && cd "$HOME/substore"

echo "https://lanyi233.xyz/script/substore/update.sh
https://lanyi233.xyz/script/substore/update_end.sh
https://lanyi233.xyz/script/substore/nginx.zip
https://lanyi233.xyz/script/substore/sub" > substore_install.txt
wget -i substore_install.txt -q --show-progress
unzip nginx.zip
chmod +x sub update.sh update_end.sh
mv "./sub" "$HOME/../usr/bin" 

    sub -u
)
echo "\n\n安装完成，在终端运行 sub 以运行"

rm ./install.sh $HOME/substore/nginx.zip $HOME/substore/substore_install.txt
else
    echo "你已安装sub-store，请在终端运行 sub"
    rm install.sh
fi