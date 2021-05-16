$releases = 'https://github.com/zhongyang219/TrafficMonitor/releases'

function global:au_BeforeUpdate() {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	
    $regex = 'x86.(7z|zip)$'
    $regex64 = 'x64.(7z|zip)$'
    $url = -Join ('https://github.com', ($download_page.links | ? href -match $regex | select -First 1 -expand href))
    $url64 = -Join ('https://github.com', ($download_page.links | ? href -match $regex64 | select -First 1 -expand href))
	
    $url -match 'TrafficMonitor_V([\d.]+)_' | Out-Null
    $version = $matches[1]
	
    return @{ Version = $version; URL32 = $url; URL64 = $url64 }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]fileName32\s*=\s*)('.*')" = "`$1'$($Latest.FileName32)'"
            "(^[$]fileName64\s*=\s*)('.*')" = "`$1'$($Latest.FileName64)'"
        }

        "tools\verification.txt"      = @{
            "(?i)(32-Bit.+)\<.*\>"   = "`${1}<$($Latest.URL32)>"
            "(?i)(64-Bit.+)\<.*\>"   = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
        }
    }
}

if ($MyInvocation.InvocationName -ne '.') { update -ChecksumFor none }