#!/bin/bash
# diy-part2.sh

# --- 1. 设置管理 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- [暴力修复] 强制锁定简体中文 ---
# 直接修改 LuCI 的配置文件，把 fallback 语言设为中文
sed -i 's/default "en"/default "zh_cn"/' feeds/luci/modules/luci-base/root/etc/config/luci
# 强制修改编译生成的默认语言包设置
sed -i 's/luci-i18n-base-en/luci-i18n-base-zh-cn/g' package/base-files/files/bin/config_generate

# --- 2. 界面美化 (Argon) ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# --- 3. [修正] 移除可能存在的冲突文件 ---
# 为了防止 iStore 安装失败，清理一下可能冲突的 golang 依赖（如果存在）
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
