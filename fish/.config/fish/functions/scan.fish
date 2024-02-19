function scan
	set DATE (date +%Y%m%d)
	set LOG_FILE "~/Documents/clamscan_$DATE.log"
	clamscan -rv ~/ -l $LOG_FILE
end
