#!/bin/bash

# GitHub令牌
TOKEN=""

# 仓库拥有者和仓库名称
REPO_OWNER="sub-store-org"
REPO_NAME="Sub-Store"
ASSET_NAME="sub-store.bundle.js"
# 版本号存储文件
ver="version"
# 脚本版本号
script_version="v5"




























WCfind(){
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
        apt-get install coreutils -y >> /dev/null # tail通常是coreutils包的一部分
        echo "\033[1A\033[K[🔎]正在寻找[✓]Wget [✓]Curl [✓]jq [✓]Tail [ ]Tr"
    # 检测并安装tr
        apt-get install coreutils -y >> /dev/null # tr通常也是coreutils包的一部分
        echo "\033[1A\033[K[🔎]正在寻找[✓]Wget [✓]Curl [✓]jq [✓]Tail [✓]Tr"
}
WCfind
echo "\033[1A\033[K[🔎]正在拉取资源"
# 获取最新发行版的API URL
LATEST_RELEASE_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest"

# 尝试获取最新发行版信息
response=$(curl -s $LATEST_RELEASE_URL || curl -s -H "Authorization: token $TOKEN" $LATEST_RELEASE_URL)

# 获取版本号
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
    assets_response=$(curl -s $assets_url || curl -s -H "Authorization: token $TOKEN" $assets_url)
    # 查找并获取其下载URL
    download_url=$(echo $assets_response | jq --arg ASSET_NAME "$ASSET_NAME" '.[] | select(.name == $ASSET_NAME) | .browser_download_url' --raw-output)
# 比较版本号
if [ "$version" != "$old_version" ]; then
    # 输出下载链接并下载
    if [ -n "$download_url" ]; then
        echo "•==========•\n获取 ${ASSET_NAME} 最新版本下载链接\n版本: ${version}\nURL: ${download_url}\n•==========•"
        wget -q --show-progress $download_url -O ${ASSET_NAME}
        echo "•==========•\n[✓][🆕]已更新sub-store为最新版本 [$old_version >> $version]\n•==========•\n"
        # 更新version.txt
        echo $version > ${ver}
        # 写入更新日志到log.txt
        echo "[$(date '+%Y-%m-%d_%H:%M:%S')]更新版本 ${old_version} >> ${version}" >> log.txt
    else
        echo "\033[1A\033[K•==========•\n[×]不存在资源 “$ASSET_NAME”，可能的原因：\n- 你的节点不支持无GitHub Token调用api，请编辑脚本第一行添加你的Token\n- 拉取时间过长，请重新执行脚本\n•=========•"
    fi
else
    echo "•=========•\n[📎]当前版本“($old_version)”已是最新，无需更新。\nURL: ${download_url}\n•=========•"
fi
















online_version=$(curl -s https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/update.sh | tail -n 1)
online_version=$(echo $online_version | grep -oP '#v.*' | tr -d '#')
if [ "$script_version" != "$online_version" ]; then
    echo "[⌛]检测到脚本新版本，正在更新"
    curl -s https://raw.githubusercontent.com/lanyi233/lanyi233/master/script/substore/update.sh -o update.sh
    echo "\033[1A\033[K[🌐]脚本更新完成 [$script_version >> $online_version] ，请重新手动添加Token，也可以手动传参进Token“sh update.sh github_***”"
fi
#v5