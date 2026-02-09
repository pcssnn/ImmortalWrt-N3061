#!/bin/bash
# diy-part2.sh

# 1. 设置 IP: 192.168.66.1
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# 2. 修复 Go 环境 (v23.05 必须升级 Go 才能编译 ADG)
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# 3. 替换为国内源 (北大源)
sed -i 's/downloads.immortalwrt.org/mirrors.pku.edu.cn\/immortalwrt/g' package/base-files/files/bin/config_generate

# 4. 强制中文 & 主题设置
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
uci set luci.main.lang=zh_cn
uci set luci.main.mediaurlbase=/luci-static/argon
uci set luci.themes.Argon=/luci-static/argon
uci set system.@system[0].hostname='N3061-Gateway'
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings
