#!/bin/bash
# diy-part2.sh

# --- 1. 设置管理 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# =========================================================
# --- [重点修复] 强制升级 Golang (Golang Fix Ultimate) ---
# =========================================================
# 1. 删除旧版 (源码自带的 1.21)
rm -rf feeds/packages/lang/golang

# 2. 拉取新版 (Kenzo 维护的 1.23+)
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# 3. 【新增关键步骤】强制重新安装/索引 Golang ！！！
# 这一步会告诉编译系统：Golang 已经变了，请使用新版本。
./scripts/feeds install -p packages -f golang

# =========================================================

# --- [手动集成] iStore 应用商店 ---
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
