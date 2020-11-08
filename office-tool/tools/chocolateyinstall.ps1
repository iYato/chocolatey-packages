$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName32 = 'Office-Tool-v8.0.zip'
$shortcutPath = [Environment]::GetFolderPath("Programs") + '\Office Tool Plus.lnk'
$unzipLocation = "$Env:LOCALAPPDATA\$packageName"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  file           = "$toolsDir\$fileName32"
  unzipLocation  = "$unzipLocation"
  validExitCodes = @(0, 3010, 1641)
}

Remove-Item -Path "$unzipLocation\*" -Force -Recurse -ErrorAction SilentlyContinue
Install-ChocolateyZipPackage @packageArgs

$exePath = (Get-Childitem -Path $unzipLocation -Filter "Office Tool Plus.exe" -Recurse).FullName
Install-ChocolateyShortcut -shortcutFilePath "$shortcutPath" -targetPath "$exePath"
