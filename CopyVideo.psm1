# This module copies new videos to a USB drive
# Values for folder path and USB drive are hard-coded/fixed


function Copy-Videos {
	$current_videos_folders = Get-ChildItem C:\folder\to\videos -Directory -Recurse # change this to folder of choice

    # Using E:\ as default USB drive to copy to
	$usb_videos_folders = Get-ChildItem E:\ -Directory

	foreach($current_videos_folder in $current_videos_folders)
	{
    		foreach($usb_videos_folder in $usb_videos_folders)
    		{
        		if($usb_videos_folder.Name -eq $current_videos_folder.Name)
        		{
            			$current_videos = Get-ChildItem $current_videos_folder
            			$usb_videos = Get-ChildItem $usb_videos_folder
            
            		foreach($current_video in $current_videos)
            		{
                		if($usb_videos.Name.Contains($current_video.Name) -eq $false) # condition to check if video is not in USB
                		{
                    			Copy-Item $current_video $usb_videos_folder
                		}
            		}
        		}
    		}
	}
}

