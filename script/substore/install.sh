
#!/bin/bash
#		•==========•		#
#SHELL颜色
#	•====[重置]====•	#
COLOR_OFF='\033[0m'			# 重置
#	•====[常规]====•	#
BLACK='\033[0;30m'			# 黑色
RED='\033[0;31m'			# 红色
GREEN='\033[0;32m'			# 绿色
YELLOW='\033[0;33m'			# 黄色
BLUE='\033[0;34m'			# 蓝色
PURPLE='\033[0;35m'			# 紫色
CYAN='\033[0;36m'			# 青色
WHITE='\033[0;37m'			# 白色
#	•====[粗体]====•	#
BBLACK='\033[1;30m'			# 黑色
BRED='\033[1;31m'			# 红色
BGREEN='\033[1;32m'			# 绿色
BYELLOW='\033[1;33m'		# 黄色
BBLUE='\033[1;34m'			# 蓝色
BPURPLE='\033[1;35m'		# 紫色
BCYAN='\033[1;36m'			# 青色
BWHITE='\033[1;37m'			# 白色
#	•====[下划线]====•	#
UBLACK='\033[4;30m'			# 黑色
URED='\033[4;31m'			# 红色
UGREEN='\033[4;32m'			# 绿色
UYELLOW='\033[4;33m'		# 黄色
UBLUE='\033[4;34m'			# 蓝色
UPURPLE='\033[4;35m'		# 紫色
UCYAN='\033[4;36m'			# 青色
UWHITE='\033[4;37m'			# 白色
#	•====[背景]====•	#
ON_BLACK='\033[40m'			# 黑色
ON_RED='\033[41m'			# 红色
ON_GREEN='\033[42m'			# 绿色
ON_YELLOW='\033[43m'		# 黄色
ON_BLUE='\033[44m'			# 蓝色
ON_PURPLE='\033[45m'		# 紫色
ON_CYAN='\033[46m'			# 青色
ON_WHITE='\033[47m'			# 白色
#		•==========•		#

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