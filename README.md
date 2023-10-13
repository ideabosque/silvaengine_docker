
## Introduction

The primary objective behind configuring Docker Compose is to streamline the deployment of SilvaEngine and streamline the debugging process for projects built upon the SilvaEngine framework.

## Installation

To commence, kindly adhere to the following steps:

1. Generate two folders named `logs` and `projects` within the `www` directory situated at the root of the Docker Compose directory. You can utilize the subsequent commands for this purpose:
    
    ```bash
    $ mkdir www/logs
    $ mkdir www/projects
    
    ```
    
2. Position both the SSH private key and SSH public key files within the `python/.ssh` directory.
3. Establish a `.env` file in the root directory and populate it with the essential environment variables. You can employ the provided `.env.example` as a reference. Below is a sample of how your `.env` file should be configured:
    
    ```
    LC_ALL=C.UTF-8
    LANG=C.UTF-8
    TZ=Asia/Chongqing
    PROJECTS_FOLDER={path to the projects folder}
    DEBUGPY={path to the debug Python file}
    
    ```
    
    **Example:**
    
    - PROJECTS_FOLDER: "C:/Users/developer/GitHubRepos/silvaengine"
    - DEBUGPY: /var/www/projects/project_xyz/project_xyz/tests/test_project_xyz.py
4. Initiate the Docker image build process by executing the subsequent command:
    
    ```bash
    $ docker compose build
    
    ```
    
5. Lastly, launch the Docker container by employing the ensuing command:
    
    ```bash
    $ docker compose up -d
    
    ```
    

## Configure requirements.txt

In addition to the aforementioned steps, it's crucial to configure the `python/requirements.txt` file to manage the necessary packages for both deployment and development purposes. It is imperative that the contents of `python/requirements.txt` are synchronized with the corresponding file in the SilvaEngine framework. Ensure that this file accurately represents the dependencies required for your project to run smoothly.

## Debugging in Visual Studio Code

To set up debugging in Visual Studio Code, adhere to these steps:

1. Initiate Visual Studio Code and load your project. Subsequently, navigate to **Run** → **Configuration**.
2. Opt for "debugger: choose 'python'".
3. Select "Debug Configuration: opt for 'Remote Attach'".
4. In the **launch.json** file, modify the "remoteRoot" to "/var/www/project/{project_name}" as illustrated in the example below:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: Remote Attach",
      "type": "python",
      "request": "attach",
      "connect": {
        "host": "localhost",
        "port": 5678
      },
      "pathMappings": [
        {
          "localRoot": "${workspaceFolder}",
          "remoteRoot": "/var/www/projects/project_xyz"
        }
      ],
      "justMyCode": true
    }
  ]
}

```