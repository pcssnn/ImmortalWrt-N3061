#!/bin/bash
# diy-part1.sh

# --- 1. 引入高质量软件源 ---
# 包含 Tailscale, AdGuardHome 等常用插件
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# --- 2. 5G 模组驱动 ---
git clone https://github.com/FUjr/QModem.git package/QModem
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool
