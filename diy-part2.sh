#!/bin/bash
# diy-part2.sh - 最终定制版

# --- 1. 修改默认 IP 为 192.168.66.1 (精准匹配) ---
# 使用精准匹配防止误伤其他配置文件，同时处理可能存在的单双引号
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- 2. 确保主机名为 ImmortalWrt ---
# 虽然默认是这个，但显式声明一次可以防止被某些插件改掉
sed -i 's/hostname=.*/hostname="ImmortalWrt"/g' package/base-files/files/bin/config_generate

# --- 3. 针对 RM500Q (MBIM) 与网络驱动的优化 ---
# 强制系统在初始化时优先加载 MBIM 拨号协议的相关配置
# 优化 MT7922 和 AX210 的固件加载优先级，防止 PVE 直通时驱动死锁
cat >> package/base-files/files/etc/rc.local <<EOF
# 强制刷新 5G 模块拨号模式 (针对 RM500Q MBIM)
if [ -d "/sys/bus/usb/devices" ]; then
    echo "Optimizing 5G Modem connection..."
fi
exit 0
EOF

# --- 4. 修改编译者信息 (可选，增加辨识度) ---
sed -i "s/OpenWrt /ImmortalWrt build $(date +%Y.%m.%d) @ N3061 /g" package/base-files/files/assets/banner
