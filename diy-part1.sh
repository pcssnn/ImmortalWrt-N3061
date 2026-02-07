#!/bin/bash
# diy-part1.sh

# --- 1. 基础依赖库 (Kenzo) ---
# 注意：虽然我们暴力拉取了插件，但底层的依赖库（如 go, nodejs 等）还需要源
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# =========================================================
# --- [⚠️ 全员暴力植入区] ---
# =========================================================

# 1. iStore 应用商店 (您点名的)
echo "Violent clone: iStore"
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui

# 2. Docker 可视化面板 (Dockerman)
echo "Violent clone: Dockerman"
git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman

# 3. Tailscale 面板
echo "Violent clone: Tailscale"
git clone https://github.com/asvow/luci-app-tailscale.git package/luci-app-tailscale

# 4. FUjr/QModem (5G管理)
echo "Violent clone: QModem"
git clone https://github.com/FUjr/QModem.git package/QModem

# 5. 4IceG/sms-tool (短信)
echo "Violent clone: SMS Tool"
git clone https://github.com/4IceG/luci-app-sms-tool.git package/luci-app-sms-tool

# 6. AdGuardHome (A开头去广告)
echo "Violent clone: AdGuardHome"
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

# 7. Argon 主题
echo "Violent clone: Argon Theme"
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
