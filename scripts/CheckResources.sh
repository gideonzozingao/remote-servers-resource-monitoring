#!/bin/bash

# Ensure jq is installed
if ! command -v jq &>/dev/null; then
    echo "jq command not found. Please install jq."
    exit 1
fi

# Get disk space information
get_disk_info() {
    df -h --output=source,fstype,size,used,avail,pcent,target | tail -n +2 | while read line; do
        echo "$line" | awk '{print "{\"Filesystem\":\""$1"\",\"Type\":\""$2"\",\"Size\":\""$3"\",\"Used\":\""$4"\",\"Available\":\""$5"\",\"Use%\":\""$6"\",\"Mounted\":\""$7"\"},"}'
    done | sed '$ s/,$//'
}

# Get memory usage information
get_memory_info() {
    free -h | awk 'NR==2{printf "{\"Total\":\"%s\",\"Used\":\"%s\",\"Free\":\"%s\"}", $2, $3, $4}'
}

# Get CPU information
get_cpu_info() {
    cpu_name=$(lscpu | grep 'Model name' | awk -F: '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')
    cpu_cores=$(lscpu | grep '^CPU(s):' | awk -F: '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')
    cpu_load=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

    echo "{\"Name\":\"$cpu_name\",\"Cores\":\"$cpu_cores\",\"Load\":\"$cpu_load\"}"
}

# Get OS information
get_os_info() {
    os_name=$(uname -s)
    os_version=$(uname -r)
    last_boot=$(who -b | awk '{print $3, $4}')
    distro_name=$(lsb_release -d | awk -F"\t" '{print $2}')

    echo "{\"Name\":\"$os_name\",\"Version\":\"$os_version\",\"Distro\":\"$distro_name\",\"LastBoot\":\"$last_boot\"}"
}

# Main function to gather all information
main() {
    disk_info=$(get_disk_info)
    memory_info=$(get_memory_info)
    cpu_info=$(get_cpu_info)
    os_info=$(get_os_info)

    echo "{\"Disk\":[$disk_info],\"Memory\":$memory_info,\"CPU\":$cpu_info,\"OS\":$os_info}" | jq .
}

# Execute the main function
main
