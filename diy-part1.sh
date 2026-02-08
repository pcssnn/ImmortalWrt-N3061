#!/bin/bash
# diy-part1.sh

# 1. 基础依赖源
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 2. iStore 商店 (Master源)
echo 'src-git istore https://github.com/linkease/istore;master' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git ui https://github.com/linkease/istore-ui.git;master' >> feeds.conf.default

# 3. 核心功能源码植入 (package/custom)
mkdir -p package/custom

# 5G拨号 & 短信
git clone https://github.com/FUjr/QModem.git package/custom/QModem
git clone https://github.com/4IceG/luci-app-sms-tool.git package/custom/luci-app-sms-tool

# 去广告 (源码版)
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/custom/luci-app-adguardhome

# Tailscale (源码版)
git clone https://github.com/asvow/luci-app-tailscale.git package/custom/luci-app-tailscale

# Argon 主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon
