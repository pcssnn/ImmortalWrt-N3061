#!/bin/bash
# diy-part2.sh

# --- 1. 强制修改默认 IP 为 192.168.66.1 ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- 2. 下载 Argon 皮肤 (iStoreOS 风格) ---
# 仅美化界面，不包含商店
git clone https://github.com/jerrykuku/luci-theme-argon.git package/new/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/new/luci-app-argon-config

# --- 3. 设置默认主题为 Argon ---
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
