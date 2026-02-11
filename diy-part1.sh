#!/bin/bash
# diy-part1.sh

# 1. ??【复刻关键】使用 Kenzo 聚合源
# 这是 2月3日 版本功能齐全的核心原因，它包含大量兼容性补丁
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 2. iStore (官方源)
echo 'src-git istore https://github.com/linkease/istore;master' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git ui https://github.com/linkease/istore-ui.git;master' >> feeds.conf.default

# 3. 手动修正与补充
mkdir -p package/custom

# ??【Docker 修正】
# Kenzo 源里的 Docker 可能与最新 Master 有冲突，我们用 lisaac 原版覆盖它
rm -rf feeds/luci/applications/luci-app-dockerman
git clone https://github.com/lisaac/luci-app-dockerman.git package/custom/luci-app-dockerman
git clone https://github.com/lisaac/luci-lib-docker.git package/custom/luci-lib-docker

# ??【皮肤锁定】Argon
# 您强调皮肤不能变，我们手动拉取最新版
git clone https://github.com/jerrykuku/luci-theme-argon.git package/custom/luci-theme-argon

# ??【5G & SMS】
git clone https://github.com/FUjr/QModem.git package/custom/QModem
git clone https://github.com/4IceG/luci-app-sms-tool.git package/custom/luci-app-sms-tool

# 注意：HomeProxy, AdGuard, KMS, Tailscale 等现在直接从 Kenzo 源获取
# 这样兼容性最好，复刻了之前的成功环境。
