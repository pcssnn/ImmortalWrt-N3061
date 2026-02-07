#!/bin/bash
# diy-part1.sh

# --- 1. 核心插件源 (Kenzo) ---
# 包含 KMS, Tailscale, AdGuardHome 等
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# --- 2. 5G 模组驱动 ---
git clone https://github.com/FUjr/QModem.git package/QModem
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool

# --- 3. Argon 主题 ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
