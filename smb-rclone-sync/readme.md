## smb-rclone-sync

This container sets up a mounts a network share (SMB) and sync its content to a cloud storage service using rclone. 

### Set Up Environment Variables
Before running the container, make sure to configure the environment variables.

SMB Configuration:

SMB_ADDRESS: The IP address or hostname of the SMB server.
SMB_SHARE: The name of the shared folder on the SMB server.
SMB_USERNAME: The username for accessing the SMB share.
SMB_PASSWORD: The password for accessing the SMB share.

rclone Configuration:

RCLONE_USERNAME: Your username for the cloud storage service.
RCLONE_PASSWORD: Your password for the cloud storage service.
RCLONE_TYPE: The type of cloud storage service (e.g., protondrive). Make sure you use the correct rclone backend type supported by rclone for your service.