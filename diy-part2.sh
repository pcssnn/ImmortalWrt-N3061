#!/bin/bash
# diy-part2.sh

# --- 1. 管理 IP 设置 ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# =========================================================
# --- [优化] 物理删除不想要的插件 (文件传输/自动重启) ---
# =========================================================
rm -rf feeds/luci/applications/luci-app-filetransfer
rm -rf feeds/luci/applications/luci-app-autoreboot
rm -rf feeds/luci/applications/luci-app-ramfree

# =========================================================
# --- [修复] 强制升级 Go 语言 (sbwml 源) ---
# 解决 AdGuard/Tailscale 编译报错
# =========================================================
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# =========================================================
# --- [功能] 手动集成 iStore ---
# =========================================================
rm -rf package/istore
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# =========================================================
# --- [中文] 强制 UCI 注入 (绝杀方案) ---
# 不改源码，直接注入开机脚本，必现中文
# =========================================================
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
# 1. 强制中文
uci set luci.main.lang=zh_cn
# 2. 强制 Argon 主题
uci set luci.main.mediaurlbase=/luci-static/argon
# 3. 设置主机名
uci set system.@system[0].hostname='N3061-ImmortalWrt'
# 提交
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# --- 界面美化 ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
