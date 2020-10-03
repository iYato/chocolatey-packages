$releases = 'https://github.com/namazso/openhashtab/releases'

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
    $regex = '.exe$'
    $url = -Join ('https://github.com', ($download_page.links | ? href -match $regex | select -First 1 -expand href))

    $url -match '/download/v([\d.]+)/OpenHashTab_setup.exe$'
    $version = $matches[1]
	
    return @{ Version = $version; URL32 = $url }
}

function global:au_SearchReplace {
    @{
        ".\tools\VERIFICATION.txt" = @{
            "(?i)(32-Bit.+)\<.*\>"     = "`${1}<$($Latest.URL32)>"
        }
    }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix 
}

update -ChecksumFor none