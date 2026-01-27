#!/bin/bash
# diy-part1.sh

# --- 重点：下载您指定的 FUjr 版 QModem ---
# 用于 5G 模组图形化管理
git clone https://github.com/FUjr/luci-app-qmodem package/luci-app-qmodem

# --- 补充：短信工具 ---
# 作为 QModem 的备份工具
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool

# 添加其他可能需要的依赖
# echo 'src-git packages https://github.com/immortalwrt/packages.git' >>feeds.conf.default
