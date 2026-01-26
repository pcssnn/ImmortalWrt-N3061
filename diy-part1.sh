#!/bin/bash
# diy-part1.sh

# --- 重点：下载您指定的 FUjr 版 QModem ---
# 这行代码会去下载 FUjr 的项目代码
git clone https://github.com/FUjr/luci-app-qmodem package/luci-app-qmodem

# --- 补充：短信工具 ---
# QModem 自带短信管理，但为了防止不兼容，添加一个通用的 SMS 工具作为备份
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool

# 添加其他可能需要的依赖
# echo 'src-git packages https://github.com/immortalwrt/packages.git' >>feeds.conf.default
