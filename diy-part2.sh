#!/bin/bash
# diy-part2.sh

# --- 1. 设置管理 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# =========================================================
# --- [编译修复] 升级 Go 语言环境 ---
# Master 分支必须使用 sbwml 的 Go，否则 AdGuardHome 必挂
# =========================================================
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# =========================================================
# --- [功能集成] 手动拉取 iStore ---
# =========================================================
rm -rf package/istore
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# =========================================================
# --- [体验优化] 强制中文 & 移除冗余 ---
# =========================================================
# 移除文件传输和自动重启插件
rm -rf feeds/luci/applications/luci-app-filetransfer
rm -rf feeds/luci/applications/luci-app-autoreboot

# 强制注入中文设置 (UCI)
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
uci set luci.main.lang=zh_cn
uci set luci.main.mediaurlbase=/luci-static/argon
uci set system.@system[0].hostname='N3061-Weekly'
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# --- 主题美化 ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
