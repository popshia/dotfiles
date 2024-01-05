Tags: #linux #ubuntu #laptop #setup #administration #cybersecurity

---

# Ubuntu系統工作筆電設定
- __Description:__ 設定Ubuntu系統工作筆電符合資安要求
- __Author:__ Kuan-Hsien Wu
- __Contact:__ jordan@c-link.com.tw
- __Date:__ 2024/01/04

# Table of Contents
- [Context](#context)
    - [0. 帳號權限](#0-帳號權限)
    - [1. 時間同步](#1-時間同步)
    - [2. USB裝置鎖 (usbguard)](#2-usb裝置鎖-usbguard)
    - [3. 螢幕保護程式 (X11)](#3-螢幕保護程式-x11)
    - [4. 自動斷開網路橋接](#4-自動斷開網路橋接)
    - [5. 防毒軟體](#5-防毒軟體)
    - [6. 密碼強度設定 (Ubuntu 22.04)](#6-密碼強度設定-ubuntu-2204)
    - [7. 密碼更新週期](#7-密碼更新週期)
    - [8. 掛載SMB Server](#8-掛載smb-server)
    - [9. 連結Printer](#9-連結printer)

# Context

## 0. 帳號權限
- 設定
    - 新增admin帳號
        ```bash
        sudo useradd admin -m
        ```
    - 設定admin密碼
        ```bash
        sudo passwd admin <admin密碼>
        ```
    - 賦予admin帳號sudo權限，完成後需重新登入使設定生效
        ```bash
        sudo usermod -aG sudo admin
        ```
    - 移除非admin帳號sudo權限，完成後需重新登入使設定生效
        ```bash
        sudo deluser <使用者帳號> sudo
        ```
    - 將非admin帳號移除netdev群組
        ```bash
        sudo delusr <使用者帳號> netdev
        ```
- 使用
    ```bash
    #從一般使用者切換至admin帳號
    su admin
    ```

## 1. 時間同步
- 安裝
    ```bash
    sudo apt install chrony
    sudo systemctl status chronyd
    #如果status沒有顯示active
    sudo systemctl enable chronyd
    sudo systemctl start chronyd
    ```
- 設定
    - 新增以下設定
        ```
        pool CS00.c-link.local iburst
        ```
    - 至`/etc/chrony/chrony.conf`，並註解掉其餘pool，得到以下結果
        ```
        #About using servers from the NTP Pool Project in general see (LP: #104525).
        #Approved by Ubuntu Technical Board on 2011-02-08.
        #See http://www.pool.ntp.org/join.html for more information.
        #pool ntp.ubuntu.com        iburst maxsources 4
        #pool 0.ubuntu.pool.ntp.org iburst maxsources 1
        #pool 1.ubuntu.pool.ntp.org iburst maxsources 1
        #pool 2.ubuntu.pool.ntp.org iburst maxsources 2
        pool CS00.c-link.local iburst
        ```
    - 然後重新啟動
        - `sudo systemctl restart chronyd`
- 使用
    ```bash
    #檢查同步時間用伺服器
    chrony tracking
    ```

## 2. USB裝置鎖 (usbguard)
- 安裝
    ```bash
    sudo apt install usbguard
    systemctl status usbguard
    #如果status沒有顯示active
    sudo systemctl enable usbguard
    sudo systemctl start usbguard
    ```
- 設定
    - 設定檔︰`/etc/usbguard/rules.conf`
    - 第一次安裝時所有已聯接設備會自動以allow狀態加入設定檔後
        - usbguard自動新增時會將設備綁定USB孔，需要移除設定行中`via-port "<USB孔>"`段落解除
    - 新增加設備，請將block狀態設備以allow狀態加入`/etc/usbguard/rules.conf`設定檔後，重新啟動usbguard
    - 重新啟動usbguard
        - `sudo systemctl restart usbguard`
- 使用
    ```bash
    #列出所有連接的USB裝置
    sudo usbguard list-devices
    ```

## 3. 螢幕保護程式 (X11)
- 安裝
    - 使用自帶的`xset`工具
- 使用
    ```bash
    #設定閒置十分鐘後螢幕關閉上鎖
    xset s 600 600 dpms 600 600 600

    #檢查螢幕保護程式設定
    xset q
    ```

## 4. 自動斷開網路橋接
- 設定
    - 將以下腳本
        ```bash
        #!/bin/bash
        case "$2" in
            up)
                #When a new connection is activated
                active_connection="$1"
                nmcli -t -f DEVICE,UUID,FILENAME connection show --active | while IFS=: read -r device uuid filename; do
                    if [ "$device" != "$active_connection" ]; then
                        nmcli connection down uuid "$uuid"
                    fi
                done
                ;;
            down)
                #You can handle any actions when a connection goes down, if needed
                ;;
        esac
        ```
    - 儲存成`98deactivate-other-connections`文件，放到`/etc/NetworkManager/dispatcher.d/`裡
    - 加上可執行權限
        - `sudo chmod +x /etc/NetworkManager/dispatcher.d/98deactivate-other-connections`
    - 然後重新啟動
        - `sudo systemctl restart NetworkManager`

## 5. 防毒軟體
- 安裝
    ```bash
    sudo apt install clamav-daemon
    systemctl status clamav-freshclam
    #如果status沒有顯示active
    sudo systemctl enable clamav-freshclam
    sudo systemctl start clamav-freshclam
    ```
- 使用
    ```bash
    #檢查病毒庫自動更新是否成功運行
    systemctl status clamav-freshclam

    #手動掃描檔案 (含資料夾遞歸)
    clamscan -rv <要掃描的檔案> -l <掃描結果輸出檔案>
    ```

## 6. 密碼強度設定 (Ubuntu 22.04)
- 設定
    - 新增以下設定
        ```
        password	requisite			pam_pwquality.so retry=1 minlen=8 difok=2 lcredit=-1 \ 	 dcredit=-1 ocredit=-1 reject_username
        ```
    - 至`/etc/pam.d/common-password`中`"Primary" block`的最上方，得到以下結果
        ```
        #here are the per-package modules (the "Primary" block)
        password	requisite			pam_pwquality.so dcredit=-1 difok2 lcredit=-1 minlen=8 ocredit=-1 reject_username retry=1
        password	[success=2 default=ignore]	pam_unix.so obscure use_authtok try_first_pass remember=2 sha512
        password	sufficient			pam_sss.so use_authtok
        ```

## 7. 密碼更新週期
- 設定
    - 更改密碼更新週期系統預設值
    - 於`/etc/login.defs`更改設定為
        ```
        #
        #Password aging controls:
        #
        #	PASS_MAX_DAYS	Maximum number of days a password may be used.
        #	PASS_MIN_DAYS	Minimum number of days allowed between password changes.
        #	PASS_WARN_AGE	Number of days warning given before a password expires.
        #
        PASS_MAX_DAYS	90
        PASS_MIN_DAYS	89
        PASS_WARN_AGE	7
        ```
- 使用
    ```bash
    #檢查使用者密碼有效性設定
    chage -l <使用者名稱>

    #設定使用者最快可更新密碼時間為89天、密碼有效時間為90天
    sudo chage <使用者名稱> -m 89 -M 90
    ```

## 8. 掛載SMB Server
- 安裝
    ```bash
    sudo apt install cifs-utils
    ```
- 設定
    - 建立本地端掛載資料夾
        ```bash
        mkdir -p <本地端掛載資料夾>
        ```
    - 新建驗證檔，填入以下資訊
        ```
        username=<使用者名稱>
        domain=c-link.local
        password=<使用者密碼>
        ```
    - 新增以下設定至`/etc/fstab`
        ```
        //192.168.168.15/admin <本地端掛載資料夾> cifs user,uid=<使用者uid>,gid=<使用者gid>,credentials=<驗證檔儲存位置>,iocharset=utf8,file_mode=0777,dir_mode=0777 0 0
        ```
- 使用
    ```bash
    #掛載SMB Server
    mount //192.168.168.15/admin
    ```

## 9. 連結Printer
