$ErrorActionPreference = 'Stop';

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$shortcutPath = [Environment]::GetFolderPath("Programs") + '\Snipaste.lnk'
$unzipLocation = $Env:LOCALAPPDATA + "\$env:ChocolateyPackageName"
$fileName32 = 'Snipaste-2.5.6-Beta-x86.zip'
$fileName64 = 'Snipaste-2.5.6-Beta-x64.zip'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $unzipLocation

  file           = "$toolsPath\$fileName32"
  file64         = "$toolsPath\$fileName64"

  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs

$exePath = (Get-Childitem -Path $unzipLocation -Filter "snipaste.exe" -Recurse).fullname
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -targetPath "$exePath"
