function bose
    bluetoothctl devices | cut -f2 -d ' ' | while read uuid
        bluetoothctl info $uuid
    end | grep -e "Device\|Connected\|Name" | grep yes

    if test ! $status -eq 0
        bluetoothctl connect BC:87:FA:26:F3:8B
    else
        bluetoothctl disconnect BC:87:FA:26:F3:8B
    end
end
