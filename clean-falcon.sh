#!/bin/bash

# Function to mount drives and identify Windows root
mount_windows_drive() {
       # Loop through available drives
       for drive in /dev/sd*; do
           mount_point=$(mktemp -d /mnt/windows-XXXX)
           mount $drive $mount_point

           # Check if we have a valid Windows installation
           if [ -d "$mount_point/Windows" ]; then
               # Windows root found
               echo "Windows root found at: $mount_point"
               echo "Removing CrowdStrike files..."
               rm -rf $mount_point/Windows/System32/drivers/CrowdStrike
               umount $mount_point
               reboot
           else
               umount $mount_point
           fi
       done
   }

mount_windows_drive
