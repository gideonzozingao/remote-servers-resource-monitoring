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

#### Response
```json
{
  "cpu": {
    "usage": "percentage"
  },
  "memory": {
    "total": "total_memory_in_bytes",
    "used": "used_memory_in_bytes",
    "free": "free_memory_in_bytes"
  },
  "disk": {
    "total": "total_disk_space_in_bytes",
    "used": "used_disk_space_in_bytes",
    "free": "free_disk_space_in_bytes"
  },
  "network": {
    "sent": "bytes_sent",
    "received": "bytes_received"
  }
}
```

## Setup and Installation

### Prerequisites
- Node.js installed on your machine
- npm (Node package manager)
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
    npm start
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