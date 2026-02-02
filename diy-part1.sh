#!/bin/bash
# diy-part1.sh

# --- [核心] 引入 Kiddin9 软件源 ---
# 这是一个非常知名的聚合源，解决了 iStore 和 Tailscale 的依赖问题
echo 'src-git kiddin9 https://github.com/kiddin9/openwrt-packages' >> feeds.conf.default

# --- QModem 5G 驱动 (单独保留，官方源更好用) ---
git clone https://github.com/FUjr/QModem.git package/QModem
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool
