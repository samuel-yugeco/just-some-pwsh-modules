# This module resyncs SRT files
# Module is to be executed on the folder having SRT file so change folder to the directory

function Retime-SRT {

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [int] $interval,

        [Parameter(Mandatory=$true)]
        [string] $file
    )


    $content = Get-Content $file

    for($i=0; $i -le $content.Length; ++$i)
    {
        if($content[$i] | Select-String -Pattern "^\d+:")
        {
            $timestart = $content[$i].Split(" --> ")[0]
            $timeend = $content[$i].Split(" --> ")[1]

            $timestart_timespan = ([datetime] $timestart).TimeOfDay
            $timeend_timespan = ([datetime] $timeend).TimeOfDay

            $diff = New-TimeSpan -Seconds $interval # convert to timespan

            $new_timestart = "{0:hh\:mm\:ss\.fff}" -f ($timestart_timespan + $diff)
            $new_timeend = "{0:hh\:mm\:ss\.fff}" -f ($timeend_timespan + $diff)

            $timestart = $new_timestart
            $timeend = $new_timeend

            $content[$i] = $timestart.ToString() + " --> " + $timeend.ToString()
            $content[$i] = $content[$i] -replace "\.",","
        }
    }

    $content | Set-Content $file
    
}


# Retime-SRT -interval (New-TimeSpan -Seconds 52) -file '.\Episode 14.srt'
