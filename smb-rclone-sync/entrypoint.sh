#!/bin/bash

set -e
mkdir /mnt/smb-share

mount \
 -t cifs //$SMB_ADDRESS/$SMB_SHARE /mnt/smb-share \
 -o username=$SMB_USERNAME,password=$SMB_PASSWORD,vers=3.0

rclone config create remote $RCLONE_TYPE \
 username=$RCLONE_USERNAME \
 password=$RCLONE_PASSWORD \
 --obscure

rclone copy /mnt/smb-share remote:$SMB_SHARE/
