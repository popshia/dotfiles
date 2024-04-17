function airpods
	bluetoothctl devices | cut -f2 -d ' ' | while read uuid ; bluetoothctl info $uuid; end | grep -e "Device\|Connected\|Name" | grep "yes"

	if test ! $status -eq 0
		bluetoothctl connect 10:B5:88:84:1C:BF
	else
		bluetoothctl disconnect 10:B5:88:84:1C:BF
	end
end
