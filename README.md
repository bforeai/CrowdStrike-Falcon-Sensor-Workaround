# CrowdStrike Falcon Sensor Workaround Automation

## Overview

In response to the widespread issues arising from the latest update of the CrowdStrike Falcon Sensor, this repository serves to facilitate the creation of a bootable USB key that automates the process of removing the problematic driver files. The aim is to eliminate the need for manual intervention while accommodating both UEFI and legacy boot modes.

## Important Notice

Please note that this automation workflow removes critical endpoint security components of the CrowdStrike Falcon Sensor. While it may resolve immediate stability problems, this action increases your systems' vulnerability to potential threats. Monitor your systems closely and prioritize restoring security measures as soon as an official resolution is available.

## Workaround Instructions

### Manual Workaround (For Reference)

If you're unable to use the automated process, here are the manual steps:

1. **Boot into Safe Mode or Windows Recovery Environment (WRE)**:
   - Restart your Windows server and press `F8` (or the appropriate key for your system) before Windows loads.
   - Select "Safe Mode" or "Repair Your Computer" to access WRE.

2. **Navigate to the CrowdStrike Driver Directory**:
   - Open File Explorer and go to:

     ```
     C:\Windows\System32\drivers\CrowdStrike
     ```
     
3. **Delete the Affected Driver File**:
   - Locate and delete the file matching:

     ```
     C-00000291*.sys
     ```

4. **Reboot Normally**.

### Automated Bootable USB Key Instructions

#### From Microsoft :
  this is the procedure to create your own bootable USB key and apply the workaround, from Microsoft website:
  https://techcommunity.microsoft.com/t5/intune-customer-success/new-recovery-tool-to-help-with-crowdstrike-issue-impacting/ba-p/4196959

### Develop your Own Bootable USB Key

This repository is focused on developing a bootable USB key that utilizes a minimal Linux environment to automate the removal of the affected driver files. Follow these steps to create the bootable USB key:

1. **Creating the Bootable USB Key**: 
   This script can be loaded onto a linux based system
   - Use a suitable tool like Rufus or dd (on Linux) to create a bootable USB with a minimalist Linux distribution that supports UEFI and legacy booting (e.g., Alpine Linux or a custom lightweight Ubuntu image).

2. **Script Functionality**:
   - Develop a script that will:
     - Mount all available drives (in UEFI and legacy modes).
     - Identify the Windows root directory; the script should target the folder `C:\Windows\System32\drivers\CrowdStrike`.
     - Delete the problematic files or directory.
     - Reboot the system.

   Here’s a high-level outline of what the script should do (in pseudo-code):

   ```bash
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
   ```

## Collaboration and Contributions

This repository welcomes contributions, insights, and collaboration from the global community. If you have alternative workarounds, solutions, or improvements to share, please consider:

- Adding detailed documentation in the `docs/` directory.
- Opening issues to discuss ongoing challenges and resolutions.
- Creating pull requests with code snippets or scripts that can help automate the workaround process.

## Security Disclaimer

Please remember that following this workaround involves deleting a crucial security driver and may temporarily disable the Falcon Sensor. This puts your systems at risk, and it is highly advisable to monitor them closely. Re-establish the Falcon Sensor as soon as an official resolution or patch is available.

Maintain open lines of communication with CrowdStrike support and regularly check for updates to facilitate a swift transition back to a secure state.

## Stay Informed

Stay connected with the community by following this repository. Updates regarding the situation or developments in an official patch from CrowdStrike will be announced here. Feel free to open discussions or share your experiences in the issues section.

Thank you for your collaboration, and stay safe!

## License

This repository is licensed under the MIT License - see the file for details.
