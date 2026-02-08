#!/bin/bash
# diy-part2.sh

# --- 1. 设置 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# =========================================================
# --- [✅ 核心修复] 强制升级 Go 语言环境 ---
# AdGuardHome, Tailscale, Mosdns 编译失败都是因为 Go 版本太低
# 这里使用 sbwml 的高性能 Go 包替换系统默认版本
# =========================================================
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# --- 3. 替换为北大源 (提升刷机后速度) ---
sed -i 's/downloads.immortalwrt.org/mirrors.pku.edu.cn\/immortalwrt/g' package/base-files/files/bin/config_generate

# --- 4. 强制中文 & 皮肤 ---
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
# 强制系统语言
uci set luci.main.lang=zh_cn
# 强制界面主题
uci set luci.main.mediaurlbase=/luci-static/argon
uci set luci.themes.Argon=/luci-static/argon
# 强制主机名
uci set system.@system[0].hostname='ImmortalWrt'
# 提交
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# =========================================================
# --- [⚠️ 强制扩容 4GB] ---
# 解决 "failed to allocate blocks, out of space" 错误
# =========================================================
sed -i '/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo 'CONFIG_TARGET_ROOTFS_PARTSIZE=4096' >> .config
echo 'CONFIG_TARGET_KERNEL_PARTSIZE=128' >> .config
