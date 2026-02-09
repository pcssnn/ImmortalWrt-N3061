#!/bin/bash
# diy-part1.sh

# 1. 基础源 (Kenzo 在 v23.05 下非常稳)
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 2. iStore (仅引入商店核心，不预装 NAS APP)
echo 'src-git istore https://github.com/linkease/istore' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git' >> feeds.conf.default
echo 'src-git ui https://github.com/linkease/istore-ui.git' >> feeds.conf.default

# 3. 核心功能源码植入 (package/custom)
mkdir -p package/custom

# 5G 拨号 (指定 FUjr 源码)
git clone https://github.com/FUjr/QModem.git package/custom/QModem

# 短信工具 (指定 4IceG 源码)
git clone https://github.com/4IceG/luci-app-sms-tool.git package/custom/luci-app-sms-tool

# AdGuardHome (源码版)
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/custom/luci-app-adguardhome

# Tailscale (内网穿透)
git clone https://github.com/asvow/luci-app-tailscale.git package/custom/luci-app-tailscale

# Argon 主题 (iStore 风格)
git clone https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon
