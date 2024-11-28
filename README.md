# Objective

This is a basic bash script that backs up files, compresses them, and uploads them to an Amazon S3 Bucket.

# Manual Execution
This script is **manual**, meaning you need to run it whenever you want to back up a specific folder.

  to run the script use:
  ```bash
  ./backup_AWS.sh 
  ```
  (you shoud be in the same directory as the script)

# Automation with Crontab
To automate the script, you can schedule it to run at specific times using **crontab**. 

## Steps to Automate:
1. Open the crontab file: 
   ```bash
   sudo vim /etc/crontab
   ```
    (You can use any text editor, e.g., nano or vim.)

2. Add your script at the end of the file:

   a- Adjust the time.

   b- Specify the privilege.

### Example:
  ```bash
  */30 * * * *	root	/home/Ubuntu/Desktop/Backup_project/backup_AWS.sh 
  ```
(in this example the script will run every 30 mins)

# Notes
1. Replace /home/Ubuntu/Desktop/Backup_project/backup_AWS.sh with the actual path to your script.
2. Ensure that AWS CLI is installed and user data is Configured. 
3. Ensure the script has execution permissions and is properly configured to interact with your S3 bucket.
