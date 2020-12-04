$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$fileName32 = 'ShadowsocksR-Win32-5.2.2.7z'
$fileName64 = 'ShadowsocksR-Win64-5.2.2.7z'

$shortcutPath = [Environment]::GetFolderPath("Programs") + "\ShadowsocksR Windows.lnk"
$unzipLocation = $Env:LOCALAPPDATA + "\$env:ChocolateyPackageName"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $unzipLocation
  file           = "$toolsPath\$fileName32"
  file64         = "$toolsPath\$fileName64"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs

$exePath = (Get-Childitem -Path $unzipLocation -Filter "ShadowsocksR.exe" -Recurse).FullName
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -targetPath $exePath
