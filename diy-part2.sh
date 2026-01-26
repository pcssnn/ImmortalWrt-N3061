#!/bin/bash
# diy-part2.sh

# --- 1. 修改默认 IP 为 192.168.66.1 ---
# 这行命令会强制把系统里的默认 IP 替换掉
sed -i 's/192.168.1.1/192.168.66.1/g' package/base-files/files/bin/config_generate

# --- 2. (可选) 设置主机名 ---
sed -i 's/ImmortalWrt/N3061-Router/g' package/base-files/files/bin/config_generate
