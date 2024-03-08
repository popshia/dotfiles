function backup
    set DATE (date +%Y%m%d)
    set PROJ_DIR /home/noah/projects
    set REPO_DIR /home/noah/repos
    set NOTE_DIR /home/noah/notes
    set TODO_DIR "/home/noah/.todo-txt"
    set DEST_DIR "/mnt/clink/C-LINK AI@CORE/個人區/Noah/backup/"
    set LOG_FILE "/mnt/clink/C-LINK AI@CORE/共用區/資訊安全管理系統/2024_ISO/4_紀錄文件/每周備份專案資料紀錄/Noah/$DATE.log"
    nohup rsync -avhiL --progress --log-file=$LOG_FILE --info=progress2 --no-i-r $PROJ_DIR $REPO_DIR $NOTE_DIR $TODO_DIR $DEST_DIR &>~/Documents/backup.log &
end
