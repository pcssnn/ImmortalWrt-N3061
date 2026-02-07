#!/bin/bash
# diy-part2.sh

# --- 1. 设置管理 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# =========================================================
# --- [✅ 关键] 替换为国内镜像源 (北大源) ---
# 刷机后 opkg 下载速度飞快
# =========================================================
sed -i 's/downloads.immortalwrt.org/mirrors.pku.edu.cn\/immortalwrt/g' package/base-files/files/bin/config_generate

# =========================================================
# --- [核心修复] Go 语言环境 (Master必须) ---
# AdGuardHome 编译依赖
# =========================================================
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# =========================================================
# --- [核心集成] iStore 商店 ---
# =========================================================
rm -rf package/istore
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# =========================================================
# --- [系统定制] 强制中文、皮肤 ---
# =========================================================
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
# 1. 强制中文
uci set luci.main.lang=zh_cn
# 2. 强制 Argon 皮肤
uci set luci.main.mediaurlbase=/luci-static/argon
uci set luci.themes.Argon=/luci-static/argon
# 3. 设置主机名
uci set system.@system[0].hostname='N3061-Master'
# 4. 提交
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# =========================================================
# --- [✅ 零删减] ---
# 严格执行您的要求：不删除任何系统默认插件
# 备份、升级、重启、文件传输... 全部保留
# =========================================================
