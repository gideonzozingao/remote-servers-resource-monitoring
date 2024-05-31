# Function to get disk space information for logical disks
function Get-LogicalDiskSpace {
    try {
        $disks = Get-WmiObject Win32_LogicalDisk -Filter "DriveType = 3"
        $diskInfoArray = @()
        foreach ($disk in $disks) {
            $diskInfo = [PSCustomObject]@{
                DriveLetter = $disk.DeviceID
                VolumeName  = $disk.VolumeName
                TotalSizeGB = [math]::Round($disk.Size / 1GB, 2)
                FreeSpaceGB = [math]::Round($disk.FreeSpace / 1GB, 2)
                UsedSpaceGB = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB, 2)
            }
            $diskInfoArray += $diskInfo
        }
        return $diskInfoArray
    } catch {
        Write-Warning "Failed to retrieve logical disk space: $_"
        return @()
    }
}

# Function to get disk space information for physical disks
function Get-PhysicalDiskSpace {
    try {
        $physicalDisks = Get-PhysicalDisk
        $diskInfoArray = @()
        foreach ($disk in $physicalDisks) {
            $partition = Get-Partition -DiskNumber $disk.DeviceID | Get-Volume
            foreach ($vol in $partition) {
                $diskInfo = [PSCustomObject]@{
                    DiskNumber   = $disk.DeviceID
                    DriveLetter  = $vol.DriveLetter
                    VolumeName   = $vol.FileSystemLabel
                    TotalSizeGB  = [math]::Round($vol.Size / 1GB, 2)
                    FreeSpaceGB  = [math]::Round($vol.SizeRemaining / 1GB, 2)
                    UsedSpaceGB  = [math]::Round(($vol.Size - $vol.SizeRemaining) / 1GB, 2)
                }
                $diskInfoArray += $diskInfo
            }
        }
        return $diskInfoArray
    } catch {
        Write-Warning "Failed to retrieve physical disk space: $_"
        return @()
    }
}

# Function to get memory usage information
function Get-MemoryUsage {
    try {
        $memory = Get-WmiObject Win32_OperatingSystem
        $totalMemoryGB = [math]::Round($memory.TotalVisibleMemorySize / 1MB, 2)
        $freeMemoryGB = [math]::Round($memory.FreePhysicalMemory / 1MB, 2)
        $usedMemoryGB = $totalMemoryGB - $freeMemoryGB
        $memoryInfo = [PSCustomObject]@{
            TotalMemoryGB = $totalMemoryGB
            FreeMemoryGB  = $freeMemoryGB
            UsedMemoryGB  = $usedMemoryGB
        }
        return $memoryInfo
    } catch {
        Write-Warning "Failed to retrieve memory usage: $_"
        return [PSCustomObject]@{
            TotalMemoryGB = 0
            FreeMemoryGB  = 0
            UsedMemoryGB  = 0
        }
    }
}

# Function to get CPU usage information
function Get-CPUUsage {
    try {
        $cpu = Get-WmiObject Win32_Processor
        $cpuInfoArray = @()
        foreach ($processor in $cpu) {
            $cpuInfo = [PSCustomObject]@{
                Name               = $processor.Name
                LoadPercentage     = $processor.LoadPercentage
                NumberOfCores      = $processor.NumberOfCores
                NumberOfLogicalProcessors = $processor.NumberOfLogicalProcessors
            }
            $cpuInfoArray += $cpuInfo
        }
        return $cpuInfoArray
    } catch {
        Write-Warning "Failed to retrieve CPU usage: $_"
        return @()
    }
}

function Get-OSInfo {
    try {
        $os = Get-WmiObject Win32_OperatingSystem
        $osInfo = [PSCustomObject]@{
            Caption            = $os.Caption
            Version            = $os.Version
            BuildNumber        = $os.BuildNumber
            LastBootUpTime     = $os.LastBootUpTime
        }
        return $osInfo
    } catch {
        Write-Warning "Failed to retrieve OS information: $_"
        return [PSCustomObject]@{
            Caption            = "Unknown"
            Version            = "Unknown"
            BuildNumber        = "Unknown"
            LastBootUpTime     = "Unknown"
        }
    }
}

# Main function to get all system information
function Get-SystemInfo {
    $logicalDiskInfo = Get-LogicalDiskSpace
    $physicalDiskInfo = Get-PhysicalDiskSpace
    $memoryInfo = Get-MemoryUsage
    $cpuInfo = Get-CPUUsage
    # $networkInfo = Get-NetworkUsage
    $osInfo = Get-OSInfo

    $systemInfo = [PSCustomObject]@{
        LogicalDisks  = $logicalDiskInfo
        PhysicalDisks = $physicalDiskInfo
        Memory        = $memoryInfo
        CPU           = $cpuInfo
        # Network       = $networkInfo
        OS            = $osInfo
    }
    return $systemInfo
}

# Run the main function and display the information
$systemInfo = Get-SystemInfo

# Convert the system information to JSON and print it
$jsonSystemInfo = $systemInfo | ConvertTo-Json -Depth 4
Write-Host $jsonSystemInfo
