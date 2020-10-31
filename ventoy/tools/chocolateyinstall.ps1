$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName32 = 'ventoy-1.0.27-windows.zip'
$packageName = $env:ChocolateyPackageName
$shortcutsPath = Join-Path ([Environment]::GetFolderPath("Programs")) 'Ventoy.lnk'
$unzipPath = "$Env:LOCALAPPDATA\$packageName"
$version = $env:ChocolateyPackageVersion

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $unzipPath
  file          = "$toolsDir\$fileName32"
  softwareName  = 'ventoy'
}

Install-ChocolateyZipPackage @packageArgs

Copy-Item -Path "$unzipPath/ventoy-$version/*" -Destination $unzipPath -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$unzipPath/ventoy-$version" -Force -Recurse -ErrorAction SilentlyContinue

$exePath = (Get-ChildItem $unzipPath -Filter "Ventoy2Disk.exe" -Recurse).FullName
Install-ChocolateyShortcut -shortcutFilePath $shortcutsPath -Target "$exePath" -WorkingDirectory $unzipPath
