#!/bin/bash

# GitHub令牌（可手动传参）
TOKEN=""

# 仓库拥有者和仓库名称
REPO_OWNER="sub-store-org"
REPO_NAME="Sub-Store"
ASSET_NAME="sub-store.bundle.js"
# 版本号存储文件
ver="version"
# 脚本版本号
script_version="v9"



























if [ -n "$1" ]; then
    TOKEN="$1"
fi
echo "•=====[Sub-Store 后端更新脚本]=====•"
WCfind(){
    echo "[🌐]正在更新apt-get资源"
        apt-get update -y >> /dev/null
    echo "\033[1A\033[K[🔎]正在寻找[ ]Wget [ ]Curl [ ]jq [ ]Tail [ ]Tr"
    # 检测并安装wget
        apt-get install wget -y >> /dev/null
        echo "\033[1A\033[K[🔎]正在寻找[✓]Wget [ ]Curl [ ]jq [ ]Tail [ ]Tr"
    # 检测并安装curl
        apt-get install curl -y >> /dev/null
        echo "\033[1A\033[K[🔎]正在寻找[✓]Wget [✓]Curl [ ]jq [ ]Tail [ ]Tr"
    # 检测并安装jq
        apt-get install jq -y >> /dev/null
        echo "\033[1A\033[K[🔎]正在寻找[✓]Wget [✓]Curl [✓]jq [ ]Tail [ ]Tr"
    # 检测并安装tail
        apt-get install coreutils -y >> /dev/null
        echo "\033[1A\033[K[🔎]正在寻找[✓]Wget [✓]Curl [✓]jq [✓]Tail [ ]Tr"
    # 检测并安装tr
        apt-get install coreutils -y >> /dev/null
        echo "\033[1A\033[K[🔎]正在寻找[✓]Wget [✓]Curl [✓]jq [✓]Tail [✓]Tr"
        
echo "\033[1A\033[K[✔️]寻找依赖完成[✓]Wget [✓]Curl [✓]jq [✓]Tail [✓]Tr"
}
WCfind

echo "[🔎]正在拉取资源"
# 获取最新发行版的API URL
echo "\033[1A\033[K[🔎]正在拉取资源 [API URL]"
LATEST_RELEASE_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest"

# 尝试获取最新发行版信息
echo "\033[1A\033[K[🔎]正在拉取资源 [GET Info]"
response=$(curl --connect-timeout 10 -s $LATEST_RELEASE_URL || curl -s --connect-timeout 10 -H "Authorization: token $TOKEN" $LATEST_RELEASE_URL)

# 获取版本号
echo "\033[1A\033[K[🔎]正在拉取资源 [Version]"
version=$(echo $response | jq .tag_name --raw-output)
# 检查version.txt是否存在，不存在则创建
if [ ! -f ${ver} ]; then
    echo "New File" > ${ver}
fi

# 读取旧版本号
old_version=$(cat ${ver})
    # 获取资产数组
    assets_url=$(echo $response | jq .assets_url --raw-output)
    # 使用curl获取资产信息
    assets_response=$(curl --connect-timeout 10 -s $assets_url || curl --connect-timeout 10 -s -H "Authorization: token $TOKEN" $assets_url)
    # 查找并获取其下载URL
    echo "\033[1A\033[K[🔎]正在拉取资源 [GET Download URL]"
    download_url=$(echo $assets_response | jq --arg ASSET_NAME "$ASSET_NAME" '.[] | select(.name == $ASSET_NAME) | .browser_download_url' --raw-output)
    echo "\033[1A\033[K[✔️]拉取资源完成"
# 比较版本号
if [ "$version" != "$old_version" ]; then
    # 输出下载链接并下载
    if [ -n "$download_url" ]; then
        echo "•==========•
[🌐]获取 ${ASSET_NAME} 最新版本下载链接
[📎]版本: ${version}
[🔗]URL: ${download_url}
•==========•"
        wget -q --show-progress $download_url -O ${ASSET_NAME}
        # curl -L $download_url -o ${ASSET_NAME} -#
        echo "•==========•\n[📎]已更新sub-store为最新版本 [$old_version >> $version]\n•==========•"
        # 更新version.txt
        echo $version > ${ver}
        # 写入更新日志到log.txt
        echo "[$(date '+%Y-%m-%d_%H:%M:%S')]更新版本 ${old_version} >> ${version}" >> log.txt
    else
        reason="" # 无法拉取原因
        # 无法拉取原因-GitHub速率
        if echo "$response" | grep -q "API rate limit exceeded"; then
        access_IP=$(echo "$response" | grep -oP '(?<=for ).*(?=. \(But here)')
        reason="${reason}
- Github速率限制 （IP: $access_IP）
  → 更换网络[切换节点 && WiFi丨移动网络切换]
  → 使用GitHub Token访问
    → 将Token作为参数传入脚本 (sh update.sh \"github_***\")
    → 编辑脚本开头，为TOKEN变量添加Token"
        # 无法拉取原因-无法访问GitHub
        elif ! curl -s --head -m 10 --request GET https://api.github.com | grep "200 OK" > /dev/null; then
        reason="${reason}
- 当前网络无法访问GitHub
  → 挂代理执行此脚本
  → 对运营商指指点点"
        fi
        echo "\033[1A\033[K•==========•\n[×]不存在资源 “$ASSET_NAME”，可能的原因：${reason}\n\n详细信息：\n$(echo "$response" | jq)\n\n•=========•"
        
    fi
else
    echo "•=========•\n[📎]当前版本“($old_version)”已是最新，无需更新。\nURL: ${download_url}\n•=========•"
fi



NOTICE="$(curl -s https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/notice.txt | shuf -n 1{})"
echo -e "Tips: ${NOTICE}
•==========•"











echo "[⏳]正在检测脚本版本"
online_version=$(curl -s https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/update.sh | tail -n 1)
online_version=$(echo $online_version | grep -oP '#v.*' | tr -d '#')
if [ "$script_version" != "$online_version" ]; then
    if curl -s --connect-timeout 5 https://raw.githubusercontent.com > /dev/null; then
        echo "\033[1A\033[K[⌛]检测到脚本新版本，正在更新"
        curl -s https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/update.sh -o update.sh
        echo "\033[1A\033[K[🌐]脚本更新完成 [$script_version >> $online_version] ，请重新手动添加Token，也可以手动传参进Token“sh update.sh github_***”\n•==========•"
    fi
else
    echo "\033[1A\033[K"
fi
#v9