$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName32 = 'Clash.for.Windows.Setup.0.15.0.exe'

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  fileType     = 'exe'
  file         = "$toolsDir\$fileName32"
  softwareName = 'Clash for Windows*'
  silentArgs   = '/S'
}

Install-ChocolateyInstallPackage @packageArgs
