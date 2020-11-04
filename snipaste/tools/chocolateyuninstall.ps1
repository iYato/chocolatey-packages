$ErrorActionPreference = 'Stop';

$shortcutPath = [Environment]::GetFolderPath("Programs") + '\Snipaste.lnk'
$unzipLocation = $Env:LOCALAPPDATA + "\$env:ChocolateyPackageName"

Remove-Item -Path $shortcutPath -ErrorAction SilentlyContinue
if (Test-Path $unzipLocation) { 
    Remove-Item -Path $unzipLocation -Recurse -Force -ErrorAction SilentlyContinue 
}
