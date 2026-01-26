#!/bin/bash
# diy-part2.sh - 研凌 N3061 PVE 专项定制版

# --- 1. 基础网络设置 ---
# 修改默认 IP 为 192.168.66.1
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# 保持主机名为原生的 ImmortalWrt (满足你的验证需求)
sed -i 's/hostname=.*/hostname="ImmortalWrt"/g' package/base-files/files/bin/config_generate

# --- 2. 针对 RM500Q-GL 的 MBIM 模式优化 ---
# 强制系统在启动时尝试拉起 MBIM 协议，并增加短信工具的稳定性
# 修正部分固件下 QModem 识别延迟的问题
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-custom-modem <<EOF
#!/bin/sh
# 自动配置 MBIM 接口
uci set network.wwan=interface
uci set network.wwan.proto='mbim'
uci set network.wwan.device='/dev/cdc-wdm0'
uci set network.wwan.apn='ctnet' # 请根据你的卡修改 APN (ctnet/3gnet/cmnet)
uci commit network
exit 0
EOF

# --- 3. 针对 PVE 直通 MT7922/AX210 的修复 ---
# 防止虚拟机关机时未正常释放 PCIe 导致宿主机死机 (PVE 常见病)
# 禁用无线网卡的 ASPM 电源管理，提升直通后的稳定性
sed -i 's/exit 0/pcie_aspm=off exit 0/g' package/base-files/files/etc/rc.local

# --- 4. 修改 SSH 欢迎横幅 (Banner) ---
echo "-----------------------------------------------------" > package/base-files/files/etc/banner
echo " Device: Yanling N3061 (PVE VM)                      " >> package/base-files/files/etc/banner
echo " Build:  $(date +%Y-%m-%d) with MBIM & HomeProxy      " >> package/base-files/files/etc/banner
echo "-----------------------------------------------------" >> package/base-files/files/etc/banner
