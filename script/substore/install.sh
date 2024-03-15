#!/bin/bash

if [ ! -d "$HOME/substore" ]; then
echo "正在安装sub-store"
  mkdir -p "$HOME/substore" && cd "$HOME/substore"

  curl -s -o update.sh "https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/update.sh" && chmod +x update.sh

  curl -s -o sub "https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/sub" && chmod +x sub && mv "./sub" "$HOME/../usr/bin" 
  
    sub -u

echo "\n\n安装完成，使用 sub 运行(-h 可隐藏token日志，-u可更新sub-store)"

rm install.sh
else
    echo "你已安装sub-store，请使用 sub 运行(-h 可隐藏token日志，-u可更新sub-store)"
    rm install.sh
fi