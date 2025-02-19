#!/bin/bash

set -e
mkdir /mnt/smb-share

mount \
 -t cifs //$SMB_ADDRESS/$SMB_SHARE /mnt/smb-share \
 -o username=$SMB_USERNAME,password=$SMB_PASSWORD,vers=3.0,file_mode=0555,dir_mode=0555

rclone config create remote $RCLONE_TYPE \
 username=$RCLONE_USERNAME \
 password=$RCLONE_PASSWORD \
 --obscure

touch /opt/hashes/test

cd /mnt/smb-share

echo "Finding hashes of files."
TIME_TAKEN=$( { /usr/bin/time -f "%E" find . -type f -exec md5sum "{}" \; > /tmp/hashes_unsorted.txt; } 2>&1 | awk '{print $2}' )
echo "Took: $TIME_TAKEN"

cat /tmp/hashes_unsorted.txt | sort > /tmp/hashes.txt
touch /opt/hashes/hashes.txt


# escape files with space in awk
# Do some time tracing to get how long each task takes
diff /opt/hashes/hashes.txt /tmp/hashes.txt | awk '{print $1}' > /tmp/diff.txt
echo "$(cat /tmp/diff.txt | wc -l) files to sync"


rclone sync /mnt/smb-share remote:$SMB_SHARE/ \
 --include /tmp/diff.txt \
 --checksum \
 -vv

cp /tmp/hashes.txt /opt/hashes/hashes.txt
