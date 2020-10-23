$ErrorActionPreference = 'Stop';
$url = 'https://bitbucket.org/liule/snipaste/downloads/Snipaste-2.5.2-Beta-x86.zip'
$url64 = 'https://bitbucket.org/liule/snipaste/downloads/Snipaste-2.5.2-Beta-x64.zip'
$checksum = 'ccf4ec5b3f901fd48949e9453d8cd159a893935405356d1c1be19d136a83b9f2'
$checksum64 = '7d9fbfc02f587e31495c254ebbc8330739da897e3a5596e80c207407b62a6ecd'

$shortcutsPath = [Environment]::GetFolderPath("Programs")
$localAppData = $Env:LOCALAPPDATA
$foldName = $env:ChocolateyPackageTitle
$installPath = Join-Path -Path $localAppData -ChildPath $foldName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  url            = $url
  url64bit       = $url64

  softwareName   = 'snipaste*'

  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64
  checksumType64 = 'sha256'

  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath (Join-Path -Path $shortcutsPath -ChildPath 'Snipaste.lnk') -targetPath (Join-Path -Path $installPath -ChildPath 'snipaste.exe')
