#!/bin/bash
# 这就是“进货单”，专门去下载官方源里没有的插件

# 1. 下载 FUjr 修改版的 QModem (支持 RM500Q 等模组管理)
git clone https://github.com/FUjr/luci-app-qmodem package/luci-app-qmodem

# 2. 短信功能 (QModem通常自带简易短信，这是更强大的专用工具，作为备份)
git clone https://github.com/4IceG/luci-app-sms-tool package/luci-app-sms-tool
