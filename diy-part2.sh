#!/bin/bash
# diy-part2.sh

# 1. 设置 IP: 192.168.66.1
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# 2. 修复 Go 环境 (ADG 编译必备)
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# 3. 🔥【核心】强制锁定中文
# 直接修改 config_generate 脚本，让出厂默认就是 zh_cn
sed -i "s/option lang 'auto'/option lang 'zh_cn'/g" package/base-files/files/bin/config_generate

# 4. 🔥【核心】强制锁定 Argon 皮肤
# 确保 Argon 成为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 5. 国内源 & 辅助设置
sed -i 's/downloads.immortalwrt.org/mirrors.pku.edu.cn\/immortalwrt/g' package/base-files/files/bin/config_generate
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
uci set luci.main.lang=zh_cn
uci set luci.main.mediaurlbase=/luci-static/argon
uci set luci.themes.Argon=/luci-static/argon
uci set system.@system[0].hostname='N3061'
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings
