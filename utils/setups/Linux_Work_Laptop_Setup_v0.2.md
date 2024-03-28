Tags: #linux #ubuntu #PAM #laptop #setup #administration #cybersecurity

---

# Linux系統工作筆電設定
- __Description:__ 設定Linux系統工作筆電符合資安要求
- __Author:__ Kuan-Hsien Wu, Guan-Liang Lin
- __Contact:__ jordan@c-link.com.tw, noah@c-link.com.tw
- __Date:__ 2024/01/04

## Changelog
| Version | Author          | Action           | Description        | Note         |
|---------|-----------------|------------------|--------------------|--------------|
| v.0.1   | K-H Wu, G-L Lin | Create this file | Add Session 0-9    | First upload |
| v.0.2   | K-H Wu          | Add Session 10   | Add faillock usage |              |

# Table of Contents
- [Context](#context)
    - [0. 帳號權限](#0-帳號權限)
    - [1. 時間同步](#1-時間同步)
    - [2. USB裝置鎖](#2-usb裝置鎖)
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
    - 將非admin帳號移除netdev群組，完成後需重新登入使設定生效
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
    #如果Active列沒有顯示active (running)
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
    sudo chronyc tracking
    ```

## 2. USB裝置鎖
- 安裝
    ```bash
    sudo apt install usbguard
    systemctl status usbguard
    #如果Active列沒有顯示active (running)
    sudo systemctl enable usbguard
    sudo systemctl start usbguard
    ```
- 設定
    - 設定檔︰`/etc/usbguard/rules.conf`
    - 第一次安裝時所有已聯接設備會自動以allow狀態加入設定檔
        - usbguard自動新增時會將設備綁定USB孔，需要移除設定行中`via-port "<USB孔>"`段落解除
    - 欲新增加設備，請將block狀態設備以allow狀態加入`/etc/usbguard/rules.conf`設定檔後，重新啟動usbguard
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

    #clamav 主程式
    systemctl status clamav-daemon
    #如果Active列沒有顯示active (running)
    sudo systemctl enable clamav-daemon
    sudo systemctl start clamav-daemon

    #clamav 定時自動更新病毒庫程式
    systemctl status clamav-freshclam
    #如果Active列沒有顯示active (running)
    sudo systemctl enable clamav-freshclam
    sudo systemctl start clamav-freshclam
    ```
- 使用
    ```bash
    #檢查病毒庫自動更新是否成功運行
    sudo systemctl status clamav-freshclam

    #手動掃描檔案 (含資料夾遞歸)
    clamscan -rv <要掃描的檔案> -l <掃描結果輸出檔案>
    ```

## 6. 密碼強度設定 (Ubuntu 22.04)
- 安裝
    ```bash
    sudo apt install libpam-modules
    ```
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
    - 建立文字檔，填入以下驗證資訊
        ```
        username=<使用者名稱>
        domain=c-link.local
        password=<使用者密碼>
        ```
    - 新增以下設定至`/etc/fstab`
        ```
        //192.168.168.15/admin <本地端掛載資料夾絕對路徑> cifs user,uid=<使用者uid>,gid=<使用者gid>,credentials=<驗證文字檔儲存位置絕對路徑>,iocharset=utf8,file_mode=0777,dir_mode=0777 0 0
        ```
- 使用
    ```bash
    #掛載SMB Server
    mount //192.168.168.15/admin

    #掛載所有在/etc/fstab中的路徑
    mount -a

    #卸載所有在/etc/fstab中的路徑（需要sudo權限）
    sudo umount -a
    ```
- 注意事項
    - SMB Server密碼有效期限三個月，過期後無法直接在Linux系統上更改，__需要找MIS設定新密碼__

## 9. 連結印表機
- 注意事項
    - 目前 __沒有開放Linux系統主機__ 連結公司印表機，若需列印要在印表機上直接操作

## 10. 設定登錄失敗5次後上鎖
- 事前準備
    - 請先準備已登入root帳號(`sudo -i`)的終端機視窗以防設定失敗無法登入
    - 如果有會嘗試使用sudo指令的模組請先關閉，否則會權限不足嘗試多次登入失敗後帳號被鎖定
        - e.g. starship 中的 sudo block
- 安裝
    ```bash
    sudo apt install libpam-modules
    ```
- 設定
    - `/etc/pam.d/common-account`
        - 新增以下設定
            ```
            account    required pam_faillock.so
            ```
        - 至`/etc/pam.d/common-account`中的`end of pam-auth-update config`下方，得到以下結果
            ```
            ...
            #end of pam-auth-update config
            account    required pam_faillock.so
            ```
    - `/etc/pam.d/common-auth`
        - 新增以下設定
            ```
            auth    required pam_faillock.so preauth audit silent deny=5 unlock_time=60000000
            ```
        - 至`/etc/pam.d/common-auth`中的`Primary block`最上方，得到以下結果
            ```
            #here are the per-package modules (the "Primary" block)
            auth    required pam_faillock.so preauth audit silent deny=5 unlock_time=60000000
            ...
            ```
        - 新增以下設定
            ```
            auth    [default=die] pam_faillock.so authfail audit deny=5 unlock_time=60000000
            auth    sufficient pam_faillock.so authsucc audit deny=5 unlock_time=60000000
            ```
        - 至`/etc/pam.d/common-auth`中的`Fallback block`最上方，得到以下結果
            ```
            #here's the fallback if no module succeeds
            auth    [default=die] pam_faillock.so authfail audit deny=5 unlock_time=60000000
            auth    sufficient pam_faillock.so authsucc audit deny=5 unlock_time=60000000
            ...
            ```
- 使用
    ```bash
    #顯示登入錯誤狀況(需要root權限)
    faillock

    #重製使用者USER的登入錯誤紀錄 (需要root權限)
    faillock --user <USER> --reset
    ```
## 11. ISO related packages and commands
- Disk Health: Install package `smartmontools`.
    ```bash
    # check disk
    sudo smartctl -i {DISK_MOUNT_PATH}

    # run disk test
    sudo smartctl -t short {DISK_MOUNT_PATH}

    # check test report and log to txt file
    sudo smartctl -a {DISK_MOUNT_PATH} > {TXT_PATH}.txt
    ```
