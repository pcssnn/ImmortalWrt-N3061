#!/bin/bash
# diy-part2.sh

# --- 1. 强制修改默认 IP 为 192.168.66.1 ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- [重要] 移除了 QModem 下载命令 ---
# 原因：已在 diy-part1.sh 中下载，此处重复会导致报错！

# --- 2. 下载界面美化插件 (Argon) ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/new/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/new/luci-app-argon-config

# --- 3. 设置默认主题为 Argon ---
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
