#!/bin/bash
echo "此脚本不保证可用性，如想停止执行请 Ctrl+C"
if [ ! -d "$HOME/substore" ]; then
echo "正在安装sub-store，node,Nginx(前端服务)"

  apt update -y && apt install nodejs nginx -y

  mkdir -p "$HOME/substore" && cd "$HOME/substore"

  curl -o update.sh "https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/update.sh" && chmod +x update.sh
  
  curl -o update.sh "https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/update.sh" && chmod +x update_end.sh

  curl -o sub "https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/sub" && chmod +x sub && mv "./sub" "$HOME/../usr/bin" 

    sub -u

echo "\n\n安装完成，在终端运行 sub 以运行"

rm install.sh
else
    echo "你已安装sub-store，请在终端运行 sub"
    rm install.sh
fi