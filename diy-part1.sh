#!/bin/bash
# diy-part1.sh

# --- [修复] 移除 Kiddin9 (太大导致下载失败)，改用 Kenzo/Small ---
# Kenzo 源包含 AdGuardHome 和 Tailscale，下载速度快，不报错
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# --- QModem 5G 驱动 (保持不变) ---
git clone https://github.com/FUjr/QModem.git package/QModem
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool
