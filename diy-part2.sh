#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# --- 1. 强制修改默认 IP 为 192.168.66.1 ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- 2. 下载第三方插件源码 (核心步骤) ---
# [QModem] 下载 FUjr 版本，提供 RM500Q 的图形管理界面
git clone https://github.com/FUjr/luci-app-qmodem.git package/new/luci-app-qmodem

# [Argon] 下载 iStoreOS 同款紫色主题和设置插件
git clone https://github.com/jerrykuku/luci-theme-argon.git package/new/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/new/luci-app-argon-config

# --- 3. 设置默认主题为 Argon ---
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
