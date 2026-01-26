#!/bin/bash
# diy-part2.sh - 研凌 N3061 PVE 最终优化版

# --- 1. 基础网络设置 ---
# 修改默认 IP 为 192.168.66.1
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# 保持主机名为 ImmortalWrt (满足你的验证需求)
sed -i 's/hostname=.all/hostname="ImmortalWrt"/g' package/base-files/files/bin/config_generate

# --- 2. PVE 虚拟机稳定性补丁 ---
# 针对 N3061 使用的 i3-10110U 平台，优化 PCIe 直通驱动加载
# 解决你之前提到的 MT7922/AX210 直通可能导致的系统挂起问题
echo "options xhci_hcd quirks=0x8000" >> package/base-files/files/etc/modprobe.d/pve-fix.conf

# --- 3. 增强 QModem 短信兼容性 ---
# 确保短信工具能正确识别移远模块的 AT 端口
sed -i 's/ttyUSB2/ttyUSB3/g' package/base-files/files/bin/config_generate 2>/dev/null || true

# --- 4. 修改 SSH 欢迎横幅 ---
sed -i "s/OpenWrt /ImmortalWrt build $(date +%Y.%m.%d) @ N3061 /g" package/base-files/files/assets/banner
