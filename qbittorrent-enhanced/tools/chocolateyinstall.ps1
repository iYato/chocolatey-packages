$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName32 = 'qbittorrent_4.3.2.10_setup.exe'
$fileName64 = 'qbittorrent_4.3.2.10_x64_setup.exe'

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  fileType     = 'exe'
  file         = "$toolsDir\$fileName32"
  file64       = "$toolsDir\$fileName64"
  softwareName = 'qbittorrent*'
  silentArgs   = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
