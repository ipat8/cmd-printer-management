# CMD-Printer-Management
Manage WSD Printers via CMD scripts

CMD Elevation by: [sudhindrasarto](https://social.technet.microsoft.com/profile/sudhindrasarto/?ws=usercard-mini) [Original post on Technet](https://social.technet.microsoft.com/Forums/windows/en-US/bc8a4561-d97e-4339-9b1c-9b90e54a7f92/request-elevation-inside-cmdbatch-file?forum=w7itprosecurity)

You can use this script to manage WSD printers on your network. Deploying this via GPO is also possible.

Description:
This script first removes all printers, and all unused drivers. This ensures a clean slate when adding printers to a Windows system. If you don't want to remove your existing printers, please remove it from the script before running it.

## YOU MUST EDIT THIS SCRIPT BEFORE RUNNING IT. THE SCRIPT WILL NOT MAKE ANY CHANGES UNTILL YOU MANUALLY ENABLE IT.
