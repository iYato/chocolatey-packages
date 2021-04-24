$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName32 = 'PicGo-Setup-2.3.0-beta.6.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'PicGo*'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'
  file           = "$toolsDir\$fileName32"
}

Install-ChocolateyPackage @packageArgs
