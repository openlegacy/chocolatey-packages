
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$urlPath = 'https://github.com/openlegacy/chocolatey-packages/raw/master/install_windows.zip'

$packageName = 'openlegacy-cli'


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' #only one of these: exe, msi, msu
  url           = $urlPath

  softwareName  = 'openlegacy-cli*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  # Checksums are now required as of 0.10.0.
  # To determine checksums, you can get that from the original site if provided. 
  # You can also use checksum.exe (choco install checksum) and use it 
  # e.g. checksum -t sha256 -f path\to\file
  #checksum      = 'C10A9476FA0233A0E93B8D5E2BE39EC0C2233359E44B437366657695482007BD'
  checksum      = $verChecksum
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  }

Install-ChocolateyZipPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-package
## add specific folders to the path - any executables found in the chocolatey package 
## folder will already be on the path. This is used in addition to that or for cases 
## when a native installer doesn't add things to the path.
## - https://chocolatey.org/docs/helpers-install-chocolatey-path
Install-ChocolateyPath $toolsDir/ol/bin # Machine will assert administrative rights