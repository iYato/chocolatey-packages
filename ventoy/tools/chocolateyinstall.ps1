﻿$ErrorActionPreference = 'Stop';
$url = 'https://github.com/ventoy/Ventoy/releases/download/v1.0.16/ventoy-1.0.16-windows.zip'
$checksum = '1c3df6c1ccee7bd60b79eac9d1b6da284aed2c12d10c3e5c08fe30008fb01986'

$packageName = $env:ChocolateyPackageName
$shortcutsPath = Join-Path ([Environment]::GetFolderPath("Programs")) 'Ventoy.lnk'
$unzipPath = "$Env:LOCALAPPDATA\$packageName"
$version = $env:ChocolateyPackageVersion

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $unzipPath
  url           = $url
  softwareName  = 'ventoy'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Copy-Item -Path "$unzipPath/ventoy-$version/*" -Destination $unzipPath -Force -Recurse
Remove-Item "$unzipPath/ventoy-$version" -Force -Recurse

Install-ChocolateyShortcut -shortcutFilePath $shortcutsPath -Target "$unzipPath\Ventoy2Disk.exe" -WorkingDirectory $unzipPath









    








