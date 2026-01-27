#!/bin/bash
# diy-part1.sh

# --- [修复] 使用正确的 QModem 仓库地址 ---
git clone https://github.com/FUjr/QModem.git package/QModem

# --- 补充：短信工具 ---
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool
