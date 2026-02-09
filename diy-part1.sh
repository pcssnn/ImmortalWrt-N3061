#!/bin/bash
# diy-part1.sh

# 1. 还原：Kenzo 核心源 (当时 AdGuard 等就是靠它)
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 2. 还原：iStore 官方源
echo 'src-git istore https://github.com/linkease/istore;master' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git ui https://github.com/linkease/istore-ui.git;master' >> feeds.conf.default

# 3. 还原：源码植入 (这是当时成功的关键)
mkdir -p package/custom

# 5G & 短信
git clone https://github.com/FUjr/QModem.git package/custom/QModem
git clone https://github.com/4IceG/luci-app-sms-tool.git package/custom/luci-app-sms-tool

# AdGuardHome (源码版最稳)
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/custom/luci-app-adguardhome

# Tailscale
git clone https://github.com/asvow/luci-app-tailscale.git package/custom/luci-app-tailscale

# 主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon
