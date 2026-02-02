#!/bin/bash
# diy-part2.sh

# --- 1. 设置 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- [核心修复] 强制升级 Golang 编译器 ---
# 解决图2报错："requires go >= 1.22.5"
# 强制删除旧版 Go，拉取最新版 Go，确保 AdGuardHome 和 Tailscale 能编译成功
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# --- [核心修复] 手动集成 iStore ---
# 确保 iStore 100% 安装成功，不依赖外部源
rm -rf package/istore
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# --- 2. 暴力锁定简体中文 ---
sed -i 's/default "en"/default "zh_cn"/' feeds/luci/modules/luci-base/root/etc/config/luci
sed -i 's/luci-i18n-base-en/luci-i18n-base-zh-cn/g' package/base-files/files/bin/config_generate

# --- 3. 界面美化 ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
