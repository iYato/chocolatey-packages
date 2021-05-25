$releases = 'https://github.com/YerongAI/Office-Tool/releases'

function global:au_BeforeUpdate() {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	
    $regex = '.+.zip$'
    $url32 = $download_page.links | ? href -match $regex | select -First 1 -expand href
    $url32 = -Join ('https://github.com', $url32)

    $url32 -match 'releases/download/([\d.]+)/'
    $version = $matches[1]
	
    return @{ Version = $version; URL32 = $url32 }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]fileName32\s*=\s*)('.*')" = "`$1'$($Latest.FileName32)'"
        }

        "tools\verification.txt"      = @{
            "(?i)(32-Bit.+)\<.*\>"   = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
        }
    }
}

if ($MyInvocation.InvocationName -ne '.') { update -ChecksumFor none }