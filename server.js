const express = require('express');
const bodyParser = require('body-parser');
const { exec } = require('child_process');
const dotenv = require('dotenv');
const os = require('os');
const { exit } = require('process');

// Load environment variables from .env file
dotenv.config();

const app = express();
const port = process.env.SERVER_PORT;
const powershell = process.env.POWERSHELL_PATH;

app.use(bodyParser.json());

// Function to execute a script and return the result
const executeScript = (command, res) => {
    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error(`Exec error: ${error}`);
            return res.status(500).send(`Error executing script: ${error.message}`);
        }
        if (stderr) {
            console.log(`Stderr: ${stderr}`);
            return res.status(500).json(`Error in script: ${stderr}`);
        }
        try {
            const data = JSON.parse(stdout);
            res.status(200).json(data);
        } catch (parseError) {
            console.log(`Parse error: ${parseError.message}`);
            res.status(500).send(`Error parsing JSON output: ${parseError.message}`);
        }
    });
};

// Endpoint to get system information
app.get('/systeminfo', async (req, res) => {
    try {
        const scriptPathWindows = './src/scripts/CheckResources.ps1';
        const scriptPathLinux = './CheckResources.sh';

        if (os.platform() === 'win32') {
            if (powershell) {
                const command = `${powershell} -File ${scriptPathWindows}`;
                executeScript(command, res);
            } else {
                res.status(500).send('PowerShell path not configured');
            }
        } else {
            const command = `bash ${scriptPathLinux}`;
            executeScript(command, res);
        }
    } catch (error) {
        console.log(error.message);
        res.status(500).send(`Server error: ${error.message}`);
    }
});

// Start the server
if (port) {
    app.listen(port, () => {
        console.log(`Server running at http://localhost:${port}/`);
    });
} else {
    console.log("Application server cannot start");
    console.log("Environmental variables not configured properly");
    exit(1);
}
