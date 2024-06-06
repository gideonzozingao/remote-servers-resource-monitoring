# Remote Servers Resource Monitoring

This project is designed to build a utility tool for monitoring resource usage in remote Windows and Linux server environments.

## Languages Used:
- **Node.js and Express.js**: HTTP server
- **Shell Scripts for Windows**: Written in PowerShell
- **Shell Scripts for Linux**: Written in Bash

The utility can be deployed as a web API service on any environment and can be interfaced with an external web application. By calling the API endpoint `/systeminfo`, the service will respond with all the resource usage information.

## Project Overview

The Remote Servers Resource Monitoring tool aims to provide a comprehensive solution for monitoring various system metrics on remote servers. The main functionalities include:

- CPU usage monitoring
- Memory usage monitoring
- Disk space usage monitoring
- Network usage monitoring

## Features

- **Cross-Platform Compatibility**: Supports both Windows and Linux servers.
- **Real-Time Monitoring**: Provides real-time data on system resource usage.
- **RESTful API**: Exposes a RESTful API for easy integration with other applications.
- **Customizable**: Can be extended to include additional metrics or monitoring features.

## API Endpoints

### GET /systeminfo

#### Description
Returns detailed information about the resource usage on the remote server.

#### Response on Linux and WSL
```json
{
  "Disk": [
    {
      "Filesystem": "none",
      "Type": "tmpfs",
      "Size": "7.8G",
      "Used": "4.0K",
      "Available": "7.8G",
      "Use%": "1%",
      "Mounted": "/mnt/wsl"
    },
    {
      "Filesystem": "none",
      "Type": "9p",
      "Size": "952G",
      "Used": "851G",
      "Available": "101G",
      "Use%": "90%",
      "Mounted": "/usr/lib/wsl/drivers"
    },
    {
      "Filesystem": "/dev/sdc",
      "Type": "ext4",
      "Size": "251G",
      "Used": "62G",
      "Available": "177G",
      "Use%": "26%",
      "Mounted": "/"
    },
    {
      "Filesystem": "none",
      "Type": "tmpfs",
      "Size": "7.8G",
      "Used": "88K",
      "Available": "7.8G",
      "Use%": "1%",
      "Mounted": "/mnt/wslg"
    },
    ....
  ],
  "Memory": {
    "Total": "15Gi",
    "Used": "6.3Gi",
    "Free": "2.0Gi"
  },
  "CPU": {
    "Name": "13th Gen Intel(R) Core(TM) i7-1360P",
    "Cores": "16",
    "Load": "0"
  },
  "OS": {
    "Name": "Linux",
    "Distro": "Ubuntu 20.04.6 LTS",
    "Version": "5.15.133.1-microsoft-standard-WSL2",
    "LastBoot": "2024-05-31 19:13"
  }
}
```

### Respose on Windows environment
```json
{
    "LogicalDisks":  {
                         "DriveLetter":  "C:",
                         "VolumeName":  "OS",
                         "TotalSizeGB":  951.05,
                         "FreeSpaceGB":  100.56,
                         "UsedSpaceGB":  850.49
                     },
    "PhysicalDisks":  [
                          {
                              "DiskNumber":  "0",
                              "DriveLetter":  "C",
                              "VolumeName":  "OS",
                              "TotalSizeGB":  951.05,
                              "FreeSpaceGB":  100.56,
                              "UsedSpaceGB":  850.49
                          },
                          {
                              "DiskNumber":  "0",
                              "DriveLetter":  null,
                              "VolumeName":  "DELLSUPPORT",
                              "TotalSizeGB":  1.46,
                              "FreeSpaceGB":  0.44,
                              "UsedSpaceGB":  1.02
                          },
                          {
                              "DiskNumber":  "0",
                              "DriveLetter":  null,
                              "VolumeName":  "WINRETOOLS",
                              "TotalSizeGB":  0.97,
                              "FreeSpaceGB":  0.19,
                              "UsedSpaceGB":  0.78
                          }
                      ],
    "Memory":  {
                   "TotalMemoryGB":  31.69,
                   "FreeMemoryGB":  6.58,
                   "UsedMemoryGB":  25.11
               },
    "CPU":  {
                "Name":  "13th Gen Intel(R) Core(TM) i7-1360P",
                "LoadPercentage":  23,
                "NumberOfCores":  12,
                "NumberOfLogicalProcessors":  16
            },
    "OS":  {
               "Caption":  "Microsoft Windows 11 Pro",
               "Version":  "10.0.22631",
               "BuildNumber":  "22631",
               "LastBootUpTime":  "20240530195326.500000+600"
           }
}


```
## Setup and Installation

### Prerequisites
- Node.js installed on your machine
- npm (Node package manager)
- pm2 (node process manager)
- Powershell (for Windows)
- Bash (for Linux)
- SSH access to the remote servers
  

### Installation Steps

1. **Clone the repository**:
    ```bash
    git clone https://github.com/gideonzozingao/remote-servers-resource-monitoring.git
    cd remote-servers-resource-monitoring
    ```

2. **Install dependencies**:
    ```bash
    npm install
    ```

3. **Configure the servers**:
   - **Windows Servers**: Ensure PowerShell scripts are accessible and executable.
   - **Linux Servers**: Ensure Bash scripts are accessible and executable.

4. **Run the server**:
    ```bash
    npm install -g pm2
    npm run deploy
    ```

5. **Access the API**:
   - The API will be available at `http://localhost:3000/systeminfo`.

## Usage

To use the API, send a GET request to the `/systeminfo` endpoint. This can be done using tools like `curl`, Postman, or directly from your web application.

Example using `curl`:
```bash
curl http://localhost:3000/systeminfo
```

## Deployment

The utility can be deployed on any server environment that supports Node.js. Common deployment options include:

- **Cloud Providers**: AWS, Azure, Google Cloud
- **On-Premises Servers**
- **Containerized Environments**: Docker, Kubernetes

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Make your changes.
4. Submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Contact

For any questions or support, please contact:

- Email: gideongzozingao@gmail.com
- GitHub Issues: [Repository Issues](https://github.com/gideonzozingao/remote-servers-resource-monitoring/issues)

---

This detailed markdown description provides an extensive overview of the Remote Servers Resource Monitoring project, covering its purpose, features, setup, usage, deployment, and contribution guidelines.
