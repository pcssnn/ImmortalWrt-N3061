#!/bin/bash
# diy-part1.sh

# --- 1. 基础依赖 (Kenzo) ---
# Kenzo 源依然需要，但我们在 diy-part2 会做清理，防止它覆盖系统核心
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# --- 2. iStore (Master源) ---
echo 'src-git istore https://github.com/linkease/istore;master' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git ui https://github.com/linkease/istore-ui.git;master' >> feeds.conf.default

# --- 3. 源码植入 5G/SMS (最稳方案) ---
mkdir -p package/custom
git clone https://github.com/FUjr/QModem.git package/custom/QModem
git clone https://github.com/4IceG/luci-app-sms-tool.git package/custom/luci-app-sms-tool

# --- 4. Argon 主题 ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon

# --- 5. AdGuardHome & Tailscale 源码植入 ---
# 为了防止依赖报错，这次我们也直接拉取源码
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/custom/luci-app-adguardhome
git clone https://github.com/asvow/luci-app-tailscale.git package/custom/luci-app-tailscale
