#!/bin/bash
# diy-part2.sh

# --- 1. 网络与 IP 设置 ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- [重点修复] 强制修改默认语言为 简体中文 ---
# 修改 LuCI 配置文件，从源码层面把 'en' 改为 'zh_cn'
sed -i 's/default "en"/default "zh_cn"/' feeds/luci/modules/luci-base/root/etc/config/luci
# 确保回滚时也是中文
sed -i 's/luci-i18n-base-en/luci-i18n-base-zh-cn/g' package/base-files/files/bin/config_generate

# --- [重点修复] iStore 应用商店 ---
# 使用标准路径安装，确保依赖被正确识别
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# --- 主题与美化 ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
