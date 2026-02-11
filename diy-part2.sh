#!/bin/bash
# diy-part2.sh

# 1. 设置 IP
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# 2. 🔥【暴力汉化】源码级锁定
# 修改默认语言 auto -> zh_cn
sed -i "s/option lang 'auto'/option lang 'zh_cn'/g" package/base-files/files/bin/config_generate

# 3. 修复 Go 环境
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf package/feeds/packages/golang
./scripts/feeds install -p packages -f golang

# 4. 🔥【依赖欺骗】强行修复 Dockerman
# 确保它依赖我们拉取的库，而不是系统不存在的库
sed -i 's/DEPENDS:=.*/DEPENDS:=+luci-lib-docker +luci-lib-jsonc/g' package/custom/luci-app-dockerman/Makefile

# 5. 🔥【主题锁定】Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 6. 国内源 & 辅助
sed -i 's/downloads.immortalwrt.org/mirrors.pku.edu.cn\/immortalwrt/g' package/base-files/files/bin/config_generate
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<EOF
#!/bin/sh
uci set luci.main.lang=zh_cn
uci set luci.main.mediaurlbase=/luci-static/argon
uci set luci.themes.Argon=/luci-static/argon
uci set system.@system[0].hostname='N3061-Master'
uci commit luci
uci commit system
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings
