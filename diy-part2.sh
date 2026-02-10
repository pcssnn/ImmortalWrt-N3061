#!/bin/bash
# diy-part2.sh

# 1. 设置 IP: 192.168.66.1
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# 2. 修复 Go 环境 (ADG 编译必备)
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# 3. 替换为国内源
sed -i 's/downloads.immortalwrt.org/mirrors.pku.edu.cn\/immortalwrt/g' package/base-files/files/bin/config_generate

# 4. 🔥【核心修复】暴力强制中文
# 直接修改源码，让系统出厂就是中文，不再是 auto
sed -i "s/option lang 'auto'/option lang 'zh_cn'/g" package/base-files/files/bin/config_generate

# 5. 双重保险 & 主题设置
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
# 再次强制设置中文，确保万无一失
uci set luci.main.lang=zh_cn
uci set luci.main.mediaurlbase=/luci-static/argon
uci set luci.themes.Argon=/luci-static/argon
uci set system.@system[0].hostname='immortalwrt'
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings
