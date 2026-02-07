#!/bin/bash
# diy-part2.sh

# --- 1. 设置 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- 2. 替换为北大源 ---
sed -i 's/downloads.immortalwrt.org/mirrors.pku.edu.cn\/immortalwrt/g' package/base-files/files/bin/config_generate

# --- 3. 核心修复：Go 语言环境 ---
# AdGuardHome 和 Tailscale 都需要这个
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# --- 4. 强制中文 & 皮肤 ---
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
# 强制中文
uci set luci.main.lang=zh_cn
# 强制皮肤
uci set luci.main.mediaurlbase=/luci-static/argon
uci set luci.themes.Argon=/luci-static/argon
# 强制主机名
uci set system.@system[0].hostname='N3061-Violent'
# 提交
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# --- [注意] ---
# 这里不删除任何系统默认文件，确保零删减
