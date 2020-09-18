![APEX ENGINEERING](img/logo.png "logo")

# Purpose
The purpose of this repo is to store our project for the KSU Hackathon 2020 HPCC challenge. The goal of the challenge is to investigate the impact of COVID-19 on the aviation industry.

# Installation
1. Download HPCC Client tools from: https://hpccsystems.com/download/archive.
2. Add `$INSTALL_PATH/clienttools/bin` to your system path.
3. Put your server information into `settings.json`.

Example:

    {
        
        "username": "user",

        "password": "pw",

        "cluster": "thor",

        "target": "40.76.26.67:8010"
    
    }



# Run
To run, call `python app.py`. It will build the command and send it to the target server.
