#!/bin/bash
# diy-part1.sh

# --- 1. 软件源配置 ---
# 使用 Kenzo 和 Small 源，它们包含了 AdGuardHome 和 Tailscale，且下载稳定
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# --- 2. 5G 模组驱动与工具 ---
# 移远 RM500Q 专用管理面板
git clone https://github.com/FUjr/QModem.git package/QModem
# 短信收发工具
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool
