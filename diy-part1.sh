#!/bin/bash
# diy-part1.sh

# 1. 基础源 (Small 还是要的，很多依赖在里面)
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 2. iStore 官方源
echo 'src-git istore https://github.com/linkease/istore;master' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git ui https://github.com/linkease/istore-ui.git;master' >> feeds.conf.default

# 3. 手动植入关键插件
mkdir -p package/custom

# 🔥 Docker (Lisaac 原版，解决红框报错)
# 先移除 feed 里的旧版
rm -rf feeds/luci/applications/luci-app-dockerman
git clone https://github.com/lisaac/luci-app-dockerman.git package/custom/luci-app-dockerman
git clone https://github.com/lisaac/luci-lib-docker.git package/custom/luci-lib-docker

# 🔥 5G & SMS
git clone https://github.com/FUjr/QModem.git package/custom/QModem
git clone https://github.com/4IceG/luci-app-sms-tool.git package/custom/luci-app-sms-tool

# 🔥 网关三剑客 (手动拉取，防止依赖问题)
git clone https://github.com/immortalwrt/homeproxy.git package/custom/homeproxy
git clone https://github.com/asvow/luci-app-tailscale.git package/custom/luci-app-tailscale
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/custom/luci-app-adguardhome

# 主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon
