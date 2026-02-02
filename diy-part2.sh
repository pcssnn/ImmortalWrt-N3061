#!/bin/bash
# diy-part2.sh

# --- 1. 设置 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- [关键修复] 强制升级 Golang (Go 语言编译器) ---
# Tailscale 和 AdGuardHome 需要新版 Go 才能编译成功，否则会静默失败
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# --- [关键修复] iStore 应用商店 (手动集成) ---
# 手动拉取 iStore 核心库，确保不依赖外部源，100% 成功
# 注意：先删除可能存在的冲突目录
rm -rf package/istore
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# --- 2. 暴力锁定简体中文 ---
# 强制修改 LuCI 默认配置，不再依赖菜单选择
sed -i 's/default "en"/default "zh_cn"/' feeds/luci/modules/luci-base/root/etc/config/luci
sed -i 's/luci-i18n-base-en/luci-i18n-base-zh-cn/g' package/base-files/files/bin/config_generate

# --- 3. 界面美化 (Argon) ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
