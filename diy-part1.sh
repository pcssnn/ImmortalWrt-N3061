#!/bin/bash
# diy-part1.sh

# --- 1. 清理潜在的干扰源 ---
# 如果默认源里有重复的，先注释掉，防止冲突
# (通常不需要，但为了保险起见)

# --- 2. 引入 Kenzo/Small 源 (稳健、快速) ---
# 只有这两个源，没有 Kiddin9
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# --- 3. 5G 驱动与工具 ---
git clone https://github.com/FUjr/QModem.git package/QModem
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool
