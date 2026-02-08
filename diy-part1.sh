#!/bin/bash
# diy-part1.sh

# --- 1. 引入 Kenzo 源 (解决依赖问题) ---
# Tailscale, AdGuardHome, HomeProxy 及其依赖 (如 iptables-mod-nat-extra) 都在这里
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# --- 2. 引入 iStore 官方源 (正规安装) ---
echo 'src-git istore https://github.com/linkease/istore;master' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git ui https://github.com/linkease/istore-ui.git;master' >> feeds.conf.default

# --- 3. 手动拉取 5G/SMS (这两个用源码最稳) ---
# 放到 package/custom 目录下，确保高优先级，解决“消失”的问题
mkdir -p package/custom
git clone https://github.com/FUjr/QModem.git package/custom/QModem
git clone https://github.com/4IceG/luci-app-sms-tool.git package/custom/luci-app-sms-tool

# --- 4. Argon 主题 ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon
