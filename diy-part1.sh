#!/bin/bash
# diy-part1.sh

# --- [修复] 移除不稳定的巨型源，使用 Kenzo/Small (速度快，包含 Tailscale/AGH) ---
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# --- QModem 5G 驱动 (保持不变) ---
git clone https://github.com/FUjr/QModem.git package/QModem
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool
