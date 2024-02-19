function bose
	bluetoothctl devices | cut -f2 -d ' ' | while read uuid ; bluetoothctl info $uuid; end | grep -e "Device\|Connected\|Name" | grep "yes"

	if test ! $status -eq 0
		bluetoothctl connect AC:BF:71:CD:2C:11
	else
		bluetoothctl disconnect AC:BF:71:CD:2C:11
	end
end
