#!/bin/bash
# diy-part2.sh

# --- 1. 设置 IP ---
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# =========================================================
# --- [✅ 修复 2：APK 规则丢失问题] ---
# 强制移除可能导致冲突的 feed 缓存，确保使用系统原生的 APK 定义
# =========================================================
./scripts/feeds update -a
./scripts/feeds install -a

# =========================================================
# --- [✅ 修复环境：Go 语言升级] ---
# 解决 AdGuard 编译失败问题
# =========================================================
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# --- 3. 替换源 ---
sed -i 's/downloads.immortalwrt.org/mirrors.pku.edu.cn\/immortalwrt/g' package/base-files/files/bin/config_generate

# --- 4. 强制中文 ---
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
uci set luci.main.lang=zh_cn
uci set luci.main.mediaurlbase=/luci-static/argon
uci set luci.themes.Argon=/luci-static/argon
uci set system.@system[0].hostname='N3061-MasterFix'
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# =========================================================
# --- [✅ 修复 1：Out of Space 空间不足] ---
# 强制将分区大小改为 4096MB (4GB)
# 这行命令会直接修改最终的配置文件，确保绝对生效
# =========================================================
sed -i '/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
echo 'CONFIG_TARGET_ROOTFS_PARTSIZE=4096' >> .config
echo 'CONFIG_TARGET_KERNEL_PARTSIZE=128' >> .config
