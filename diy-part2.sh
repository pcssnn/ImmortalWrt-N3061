#!/bin/bash
# diy-part2.sh

# --- 1. 管理 IP 设置 ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# =========================================================
# --- [绝杀 1] 物理删除冗余插件 (清理菜单) ---
# =========================================================
# 删除您不想要的“文件传输”和“自动重启”等插件源码
# 这样它们绝对不会出现在菜单里
rm -rf feeds/luci/applications/luci-app-filetransfer
rm -rf feeds/luci/applications/luci-app-autoreboot
rm -rf feeds/luci/applications/luci-app-ramfree
rm -rf feeds/packages/utils/coremark

# =========================================================
# --- [绝杀 2] 强制修复 Go 语言 (sbwml 源) ---
# 解决 AdGuard/Tailscale 编译报错的唯一解
# =========================================================
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# =========================================================
# --- [绝杀 3] 手动集成 iStore (防丢失) ---
# =========================================================
rm -rf package/istore
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# =========================================================
# --- [绝杀 4] 强制注入中文 (UCI 启动脚本) ---
# 不再依赖源码替换，而是开机强制执行命令
# =========================================================
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
# 强制设置语言为简体中文
uci set luci.main.lang=zh_cn
# 强制设置主题为 Argon
uci set luci.main.mediaurlbase=/luci-static/argon
# 提交修改
uci commit luci
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# --- 界面美化 ---
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
