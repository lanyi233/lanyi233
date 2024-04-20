
#!/bin/bash

echo "${BRED}此脚本不保证可用性，如想停止执行请 Ctrl+C${COLOR_OFF}"

# 询问用户是否安装
read -p "是否安装 sub-store? (y/n) " install_confirm
if [ "$install_confirm" != "y" ]; then
    exit 0
fi

# 安装依赖
echo "正在安装 sub-store、zip、node、Nginx(前端服务)"
apt update -y && apt install zip nodejs nginx -y

# 创建 substore 目录并下载资源
mkdir -p "$HOME/substore" && cd "$HOME/substore"
wget -q --show-progress https://lanyi233.xyz/script/substore/update.sh
wget -q --show-progress https://lanyi233.xyz/script/substore/update_end.sh
wget -q --show-progress https://lanyi233.xyz/script/substore/nginx.zip
wget -q --show-progress https://lanyi233.xyz/script/substore/sub

# 解压 nginx.zip 并设置权限
unzip nginx.zip
chmod +x sub update.sh update_end.sh
mv "./sub" "$HOME/../usr/bin"

# 更新 sub
sub -u

echo "安装完成，在终端运行 ${UYELLOW}sub${COLOR_OFF} 命令以运行"

# 清理临时文件
rm ./install.sh $HOME/substore/nginx.zip $HOME/substore/substore_install.txt