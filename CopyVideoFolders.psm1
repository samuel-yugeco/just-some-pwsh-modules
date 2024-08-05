# This module copies video folders to a USB
# Values for folder and USB drive are hard-coded/fixed
# There is a completed folder containing videos of a complete series. This is not to be copied

function Copy-VideoFolders {
    $current_videos_folders = Get-ChildItem C:\path\to\folder -Directory -Recurse # change this to folder of choice

    # E:\ as the default USB drive
    $usb_videos_folders = Get-ChildItem E:\ -Directory

    foreach($current_videos_folder in $current_videos_folders)
    {
        if(!($usb_videos_folders.Name.Contains($current_videos_folder.Name)) -and $current_videos_folder.Name -ne "Completed") # condition to check for folder to copy
        {
            Copy-Item $current_videos_folder E:\ -Recurse
        }
        
    }
}

