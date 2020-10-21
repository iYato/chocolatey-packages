$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = $env:ChocolateyPackageName
$unzipLocation = "$Env:LOCALAPPDATA\$packageName"
$shortcutPath = [Environment]::GetFolderPath("Programs") + "\Netch.lnk"
$fileName64 = 'Netch.7z'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  file64         = "$toolsDir\$fileName64"

  softwareName   = 'netch*'

  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs

$exePath = (Get-Childitem -Path $unzipLocation -Filter "Netch.exe" -Recurse).fullname
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -Target "$exePath"
