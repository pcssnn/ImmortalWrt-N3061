#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# --- 1. 修改默认 IP 为 192.168.66.1 ---
# (既然写在这里了，YAML 里那行自动注入的命令虽然重复但不会报错，可以放心保留)
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- 2. 引入外部插件源码 (进货) ---
# 下载 FUjr 版 QModem 管理界面 (解决你找不到菜单的问题)
git clone https://github.com/FUjr/luci-app-qmodem.git package/new/luci-app-qmodem

# 下载 iStoreOS 同款 Argon 主题 & 设置插件
git clone https://github.com/jerrykuku/luci-theme-argon.git package/new/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/new/luci-app-argon-config

# --- 3. 设置默认主题为 Argon ---
# 这一步确保你刷机后看到的直接就是紫色的 Argon 界面，而不是默认的 Bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
