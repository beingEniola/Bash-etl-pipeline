# Bash-etl-pipeline

A Bash scripting project that implements a simple ETL pipeline to extract, transform, and load CSV data in a Linux environment.

## Overview

This project has three sections

- Built a bash script to create an ETL pipeline to extract csv data from the web, transform, and load into a folder
- Scheduled a cron job to run the script daily at 12:00 AM
- 

---

## Project Files

```
project/
│
├── etl_script.sh
├── Gold/
├── Raw/
├── Transformed/
├── setup.log
├── .gitignore
└── README.md

```

---

## ETL Bash Script
The file `etl_script.sh` is the script that creates the pipeline. In this script I created three function for each etl tasks (extract, transform, and load)
- The extract function creates a directory named raw, downloads the csv from the web and saves it into the raw folder.
- transform function also creates a directory named transformed, rename column `Variable_code` to `variable_code`, and selects four columns: `year`, `Value`, `Units`, `variable_code`
- Lastly the load function loads the transformed data into a directory named Gold

Features I but in place while developing this script were
- Environment variables to store the URL. 
- Print out information for each step.
- Colorful terminal messages.

## Scheduling Cron Jobs

After I confirmed that the script ran correctly manually, I scheduled a cron job to run the script daily at 12 AM.

I added this job to crontab
`* 0 * * * /mnt/c/Users/HP/Desktop/CDE/Assignments/Linux/Bash-etl-pipeline/etl_script.sh`

Before the final job above I made sure to cofirm that the schedule ran correctly by setting it to run every 5 mins at first
`5 * * * * /mnt/c/Users/HP/Desktop/CDE/Assignments/Linux/Bash-etl-pipeline/etl_script.sh`

Then I used `journalctl -u cron --since "1 hour ago"` to check the logs of crons that ran 1 hour ago.

---

## Bash Script to move files from one folder to another

---
## Example Output
The output data are in the  Raw/, Transformed/, Gold/, directory

---

## Challenges Faced
- The transform function did not run accurately because of the delimeter specified in awk  


