#!/bin/bash
# diy-part2.sh

# --- 1. 网络设置 (管理 IP: 192.168.66.1) ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# =========================================================
# --- [核心修复] 强制升级 Golang (使用 sbwml 源) ---
# 这是解决图 3333.jpg 报错 "go 1.21.11 < 1.22.5" 的终极方案
# =========================================================

# 1. 彻底删除源码自带的旧版 Go
rm -rf feeds/packages/lang/golang

# 2. 拉取 sbwml 维护的高版本 Go (专治各种版本过低)
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

# 3. 清理旧的编译缓存 (防止系统记住了旧版本)
rm -rf package/feeds/packages/golang

# 4. 强制重新安装并注册 Golang
./scripts/feeds install -p packages -f golang

# =========================================================

# --- [手动集成] iStore 应用商店 ---
# 手动拉取源码，确保 100% 安装成功
rm -rf package/istore
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# --- 2. 暴力锁定简体中文 ---
# 修改 LuCI 配置文件默认语言
sed -i 's/default "en"/default "zh_cn"/' feeds/luci/modules/luci-base/root/etc/config/luci
# 修改固件生成脚本默认语言
sed -i 's/luci-i18n-base-en/luci-i18n-base-zh-cn/g' package/base-files/files/bin/config_generate

# --- 3. 界面美化 (Argon) ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
