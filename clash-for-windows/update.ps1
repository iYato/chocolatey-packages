$releases = 'https://github.com/Fndroid/clash_for_windows_pkg/releases'

function global:au_BeforeUpdate() {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	
    $regex = '.exe$'
    $url = $download_page.links | Where-Object href -match $regex | Select-Object -First 1 -expand href
	
    $url = -Join ('https://github.com', $url)
    $url -match 'Setup\.([\d.]+)\.exe' | Out-Null
    $version = $matches[1]
	
    return @{ Version = $version; URL32 = $url }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]fileName32\s*=\s*)('.*')" = "`$1'$($Latest.FileName32)'"
        }

        "tools\verification.txt" = @{
            "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
        }
    }
}

if ($MyInvocation.InvocationName -ne '.') { update -ChecksumFor none }