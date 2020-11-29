$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://ol-public-artifacts.s3.amazonaws.com/openlegacy-cli/1.15.0/windows/openlegacy-cli.zip' # download url, HTTPS preferred

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'  # 'EXE_MSI_OR_MSU' #only one of these: exe, msi, msu
  url           = $url

  softwareName  = 'openlegacy-cli*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = 'bd80cd909eae4eb3d3db168679da2c51bdac8a9100e758d9d7c70efa7f35e0fe'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
}

Install-ChocolateyZipPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyPath "$toolsDir/ol/bin" 'Machine' # Machine will assert administrative rights

echo "*********************************************************************************************"
echo "Note that the CLI require java 11, please make sure its installed and JAVA_HOME is configured"
echo "*********************************************************************************************"
