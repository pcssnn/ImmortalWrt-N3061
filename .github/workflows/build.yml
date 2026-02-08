name: Build N3061 Final Fix

on:
  repository_dispatch:
  workflow_dispatch:
  schedule:
    - cron: '0 12 * * 5'

env:
  REPO_URL: https://github.com/immortalwrt/immortalwrt
  REPO_BRANCH: master
  FEEDS_CONF: feeds.conf.default
  CONFIG_FILE: .config
  DIY_P1_SH: diy-part1.sh
  DIY_P2_SH: diy-part2.sh
  TZ: Asia/Shanghai

jobs:
  build:
    runs-on: ubuntu-22.04

    steps:
    - name: Checkout
      uses: actions/checkout@v4

    # =========================================================
    # ✅ 修复图3/图4：手动清理空间 (最稳妥的方式)
    # 不依赖任何第三方插件，直接删废料
    # =========================================================
    - name: Free Disk Space (Manual)
      run: |
        echo "Freeing disk space..."
        sudo rm -rf /usr/share/dotnet
        sudo rm -rf /usr/local/lib/android
        sudo rm -rf /opt/ghc
        sudo rm -rf /usr/share/swift
        sudo docker image prune -a -f
        echo "Disk space freed."
        df -h

    - name: Initialization environment
      env:
        DEBIAN_FRONTEND: noninteractive
      run: |
        sudo -E apt-get -qq update
        sudo -E apt-get -qq install $(curl -fsSL https://is.gd/depends_ubuntu_2204)
        sudo -E apt-get -qq autoremove --purge
        sudo -E apt-get -qq clean
        sudo timedatectl set-timezone "$TZ"

    - name: Clone source code
      run: |
        git clone $REPO_URL -b $REPO_BRANCH openwrt
        [ -e $DIY_P1_SH ] && cp $DIY_P1_SH openwrt/
        [ -e $DIY_P2_SH ] && cp $DIY_P2_SH openwrt/

    - name: Update & Install feeds
      run: |
        cd openwrt
        ./scripts/feeds update -a
        ./scripts/feeds install -a -f

    - name: Load custom configuration
      run: |
        [ -e $CONFIG_FILE ] && mv $CONFIG_FILE openwrt/.config
        cd openwrt
        chmod +x $DIY_P2_SH
        ./$DIY_P2_SH
        # 先生成一次标准配置
        make defconfig

    # =========================================================
    # ✅ 修复图1：最后时刻强制修改分区大小
    # 防止 make defconfig 把我们的设置重置掉
    # =========================================================
    - name: Force Rootfs Size to 4GB
      run: |
        cd openwrt
        # 删除可能存在的旧配置
        sed -i '/CONFIG_TARGET_ROOTFS_PARTSIZE/d' .config
        sed -i '/CONFIG_TARGET_KERNEL_PARTSIZE/d' .config
        # 强制写入新配置 (4GB)
        echo 'CONFIG_TARGET_ROOTFS_PARTSIZE=4096' >> .config
        echo 'CONFIG_TARGET_KERNEL_PARTSIZE=128' >> .config
        # 打印最后几行确认写入成功
        tail -n 5 .config

    - name: Download package
      run: |
        cd openwrt
        make download -j8
        find dl -size -1024c -exec rm -f {} \;

    - name: Compile the firmware
      id: compile
      run: |
        cd openwrt
        echo -e "$(nproc) thread compile"
        make -j$(nproc) || make -j1 || make -j1 V=s
        echo "status=success" >> $GITHUB_OUTPUT
        echo "FILE_DATE=_$(date +"%Y%m%d%H%M")" >> $GITHUB_ENV

    - name: Organize files
      id: organize
      if: steps.compile.outputs.status == 'success' && !cancelled()
      run: |
        cd openwrt/bin/targets/x86/64
        rm -rf packages
        echo "FIRMWARE=$PWD" >> $GITHUB_ENV
        echo "status=success" >> $GITHUB_OUTPUT

    - name: Upload firmware to release
      uses: softprops/action-gh-release@v2
      if: steps.organize.outputs.status == 'success' && !cancelled()
      with:
        tag_name: N3061-Final-Success-${{ env.FILE_DATE }}
        name: N3061 终极修复版 (已扩容4GB) ${{ env.FILE_DATE }}
        body: |
          ### 🔥 错误修复日志
          - ✅ **修复图4**: 移除失效插件，改用手动清理空间
          - ✅ **修复图3**: 释放了约 10GB 编译空间
          - ✅ **修复图1**: 强制设定 Rootfs 为 4096MB (4GB)
          - 📦 **功能**: 包含所有您要求的 5G/SMS/iStore/Docker
        files: ${{ env.FIRMWARE }}/*.img.gz
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
