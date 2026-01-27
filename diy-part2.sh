#!/bin/bash
# diy-part2.sh

# --- 1. 强制修改默认 IP 为 192.168.66.1 ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- [iStore 应用商店] ---
git clone https://github.com/linkease/istore.git package/new/luci-app-store
git clone https://github.com/linkease/istore-ui.git package/new/luci-app-store-ui

# --- 2. 下载界面美化插件 (Argon) ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/new/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/new/luci-app-argon-config

# --- 3. 设置默认主题为 Argon ---
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
