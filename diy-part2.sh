#!/bin/bash
# diy-part2.sh

# --- 1. 设置管理 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- [核心修复] 强制升级 Golang 编译器 ---
# 解决 "requires go >= 1.22.5" 报错
# 删除源码自带的旧版 Go，拉取 Kenzo 维护的最新版 Go
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# --- [手动集成] iStore 应用商店 ---
# 手动拉取源码，防止因软件源问题导致安装失败
rm -rf package/istore
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# --- 2. 暴力锁定简体中文 ---
sed -i 's/default "en"/default "zh_cn"/' feeds/luci/modules/luci-base/root/etc/config/luci
sed -i 's/luci-i18n-base-en/luci-i18n-base-zh-cn/g' package/base-files/files/bin/config_generate

# --- 3. 界面美化 (Argon) ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
