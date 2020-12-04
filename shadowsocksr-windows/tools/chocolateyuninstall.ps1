$ErrorActionPreference = 'Stop';

$shortcutPath = [Environment]::GetFolderPath("Programs") + "\ShadowsocksR Windows.lnk"
$unzipLocation = $Env:LOCALAPPDATA + "\$env:ChocolateyPackageName"

Remove-Item -Path $shortcutPath -ErrorAction SilentlyContinue
Remove-Item -Path "$unzipLocation" -Recurse -Force -ErrorAction SilentlyContinue 