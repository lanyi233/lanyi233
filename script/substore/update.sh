# 你的GitHub令牌
TOKEN="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"

# 仓库拥有者和仓库名称
REPO_OWNER="sub-store-org"
REPO_NAME="Sub-Store"
ASSET_NAME="sub-store.bundle.js"

# 获取最新发行版的API URL
LATEST_RELEASE_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest"

# 首先尝试无Token获取最新发行版信息
response=$(curl $LATEST_RELEASE_URL)

# 如果无Token失败，则使用Token重试
if [ -z "$(echo $response | jq '.')" ]; then
  response=$(curl -H "Authorization: token $TOKEN" $LATEST_RELEASE_URL)
fi

# 获取版本号
version=$(echo $response | jq '.tag_name' --raw-output)

# 获取资产数组
assets_url=$(echo $response | jq '.assets_url' --raw-output)

# 使用curl获取资产信息
assets_response=$(curl -H "Authorization: token $TOKEN" $assets_url)

# 查找名为"sub-store.bundle.js"的资产并获取其下载URL
download_url=$(echo $assets_response | jq --arg ASSET_NAME "$ASSET_NAME" '.[] | select(.name == $ASSET_NAME) | .browser_download_url' --raw-output)

# 输出下载链接
if [ -n "$download_url" ]; then
  echo "\n•==========•\n获取 ${ASSET_NAME} 最新版本下载链接\n版本: ${version}\nURL: ${download_url}\n•==========•"
  echo "[↓]正在下载资源"
  wget -q --show-progress "$download_url" -O "${ASSET_NAME}"
  echo "•==========•"
    if [ -f "${ASSET_NAME}" ]; then
    echo "[✓][🆕]已更新sub-store为最新版本\n•==========•\n"
  else
    echo "[✓][📥]已下载sub-store最新版本\n•==========•\n"
  fi
else
  echo "[×]不存在资源 $ASSET_NAME 或你的节点不支持无GitHub Token调用api，\n请编辑脚本第一行添加你的Token\n•=========•\n"
fi