#!/bin/bash
# diy-part1.sh

# 1. 基础源
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 2. iStore (Master 分支适配)
echo 'src-git istore https://github.com/linkease/istore;master' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git ui https://github.com/linkease/istore-ui.git;master' >> feeds.conf.default

# 3. 核心源码植入 (package/custom 下优先级最高)
mkdir -p package/custom

# 🔥【Docker 修复】(解决红框报错的关键)
# 先删除 feed 里可能有问题的版本
rm -rf feeds/luci/applications/luci-app-dockerman
# 拉取 lisaac 原作者的修复代码
git clone https://github.com/lisaac/luci-app-dockerman.git package/custom/luci-app-dockerman
git clone https://github.com/lisaac/luci-lib-docker.git package/custom/luci-lib-docker

# 🔥【5G & SMS】
git clone https://github.com/FUjr/QModem.git package/custom/QModem
git clone https://github.com/4IceG/luci-app-sms-tool.git package/custom/luci-app-sms-tool

# 【网络工具】
git clone https://github.com/immortalwrt/homeproxy.git package/custom/homeproxy
git clone https://github.com/asvow/luci-app-tailscale.git package/custom/luci-app-tailscale
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/custom/luci-app-adguardhome

# 【主题】
git clone https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon
