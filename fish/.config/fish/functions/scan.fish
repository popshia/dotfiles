function scan
    set DATE (date +%Y%m%d)
    set LOG_FILE "/home/noah/Documents/clamscan_$DATE.log"
    nohup clamscan -rv ~/ -l $LOG_FILE &>~/Documents/scan.log &
end
