# This module creates a folder for videos
# switch parameter to create a folder for a completed series
# value for folder paths are fixed

function New-VideosFolder {
	
	[CmdletBinding()]
	param (
		[switch] $Completed 
	)

	$series = "C:\path\to\video\series\"

	Get-ChildItem 'C:\path\to\video\episodes'
	$folder = Read-Host "Enter name of folder" # prompt to enter folder name

	$videos = Get-ChildItem 'C:\path\to\video\episodes' 
	
	if($Completed)
	{
		$completed_folder = "C:\path\to\Completed\folder"

		$videos = Get-ChildItem 'C:\path\to\video\episodes' 

		foreach($video in $videos)
		{
			if($video.Name -Match $folder)
				{
					mv $video $completed_folder
					$new_folder_name = $video.BaseName.Replace("Episode 1", "") # Removing episode 1 from the text
					New-Item -ItemType Directory "$completed_folder\$new_folder_name"
				}
		}

		$new_folder = Get-ChildItem $completed_folder | Sort-Object LastWriteTime -Descending | Select-Object -First 1
		$videofile = Get-ChildItem $completed_folder -File
		mv $videofile $new_folder
	} else {
		foreach($video in $videos)
		{
			if($video.Name -Match $folder)
				{
					mv $video $series
					$base_video_name = $video.BaseName.Replace("Episode 1", "") # Removing episode 1 from the text
					$base_video_name -match "\(\d+\)"
					$year_portion = $Matches[0]
					$new_folder_name = $base_video_name.Replace($year_portion,'')
					New-Item -ItemType Directory "$series\$new_folder_name"
				}
		}

		$new_folder = Get-ChildItem $series | Sort-Object LastWriteTime -Descending | Select-Object -First 1
		$videofile = Get-ChildItem $series -File
		mv $videofile $new_folder
	}

}


