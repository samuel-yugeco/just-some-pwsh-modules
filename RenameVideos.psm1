# This module renames videos to epsiode number
# Note that this has to be run on the folder having videos to be renamed so change to the directory

function Rename-Videos {
    Get-ChildItem | ForEach-Object {
        if ($_.name -match "episode \d+") {
            $number = $Matches[0]
            $oldname = $_.Name
            
            $extension = $_.Extension
            
            $rename = $number + $extension
            $rename
            Rename-Item -Path $oldname -NewName $rename
            }
    }
}

