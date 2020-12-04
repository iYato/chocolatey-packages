$releases = 'https://github.com/HMBSbige/ShadowsocksR-Windows/releases'

function global:au_BeforeUpdate() {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	
    $regex32 = 'Win32.+(zip|7z)$'
    $regex64 = 'Win64.+(zip|7z)$'
    $url64 = -Join ('https://github.com', ($download_page.links | Where-Object href -match $regex64 | Select-Object -First 1 -expand href))
    $url32 = -Join ('https://github.com', ($download_page.links | Where-Object href -match $regex32 | Select-Object -First 1 -expand href))
	
    $url64 -match 'releases/download/([\d.]+)'
    $version = $Matches[1]

    return @{ Version = $version; URL64 = $url64; URL32 = $url32 }
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