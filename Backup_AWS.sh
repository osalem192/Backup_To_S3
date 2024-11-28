#! /bin/bash

time=$(date +%m-%d-%y_%H_%M_%S)				#time to use to name the backup file
backup_file=Bash/					#file to backup
dest=Backup/						#local destination for backup
filename=file-backup-$time.tar.gz			#filename after backup
log_file="Backup/logfile.log"				#logfile 
S3_Bucket="s3-new-bash-courseproj192"			#S3 Bucket name
file_to_upload=$dest/$filename				#File to upload to S3 Bucket

if ! command -v aws &> /dev/null			#checking if AWS CLI is installed 
then 
	echo "AWS CLI is not installed"
	exit 2
fi

if [ $? -ne 2 ] 
then
	if [ -f $filename ]			#check if backup already exists 
	then
		echo "Error: file \"$filename\"  already exists" | awk '{ print strftime("%m-%d-%Y %H:%M:%S: "), $0 }' | tee -a $log_file
	else
		tar -czvf "$dest/$filename" "$backup_file"		#compressing the backup
		echo
		echo "successfuly completed Backup of: $dest/$filename" |  awk '{ print strftime("%m-%d-%Y %H:%M:%S: "), $0 }' | tee -a $log_file
		aws s3 cp "$file_to_upload" "s3://$S3_Bucket"	#uploading backup to AWS S3 Bucket
		echo
		if [ $? -eq 0 ]
		then
			echo "Successfuly Uploaded Backup to AWS S3 Bucket. $filename"
		else
			echo "Failed to upload Backup Uploaded to AWS S3 Bucket. $filename"
		fi
	fi
fi
	
