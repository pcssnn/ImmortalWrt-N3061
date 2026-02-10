#!/bin/bash
# diy-part1.sh

# 1. 基础源 (Kenzo 包含 HomeProxy 依赖)
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 2. iStore (⚠️强力措施：强制使用 master 分支源，适配 APK)
echo 'src-git istore https://github.com/linkease/istore;master' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git ui https://github.com/linkease/istore-ui.git;master' >> feeds.conf.default

# 3. 核心源码植入 (⚠️强力措施：git clone 暴力覆盖)
mkdir -p package/custom

# 5G 拨号 (FUjr 源码 - 您指定的)
git clone https://github.com/FUjr/QModem.git package/custom/QModem

# 短信工具 (4IceG 源码 - 您指定的)
git clone https://github.com/4IceG/luci-app-sms-tool.git package/custom/luci-app-sms-tool

# Tailscale (内网穿透 - asvow版最稳)
git clone https://github.com/asvow/luci-app-tailscale.git package/custom/luci-app-tailscale

# HomeProxy (家庭代理 - 确保源码存在)
git clone https://github.com/immortalwrt/homeproxy.git package/custom/homeproxy

# AdGuardHome (源码版)
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/custom/luci-app-adguardhome

# Argon 主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon
