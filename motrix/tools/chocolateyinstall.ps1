$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName32 = 'Motrix-Setup-1.6.11.exe'

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  fileType     = 'exe'
  file         = "$toolsDir\$fileName32"
  softwareName = 'motrix*'
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
