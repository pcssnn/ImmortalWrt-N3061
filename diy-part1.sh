#!/bin/bash
# diy-part1.sh

# --- [修复] 引入高质量第三方源 (Kenzo & Small) ---
# 这是解决 AdGuard Home 和 Tailscale 缺失的关键
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# --- QModem 驱动 (5G 模组) ---
git clone https://github.com/FUjr/QModem.git package/QModem

# --- 短信工具 ---
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool
