$releases = 'https://tableplus.com/release/windows/tableplus_latest'

function global:au_BeforeUpdate() {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest{
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing -MaximumRedirection 0 -ErrorAction SilentlyContinue

	$url = $download_page.links.href
    $url -match '/windows/([\d.]+)/TablePlusSetup.exe'
    $version = $matches[1]
	
    return @{ Version = $version; URL32 = $url }
}

function global:au_SearchReplace {
    @{
        "tools\verification.txt" = @{
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
            "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
        }
    }
}


if ($MyInvocation.InvocationName -ne '.') { update -ChecksumFor none }
