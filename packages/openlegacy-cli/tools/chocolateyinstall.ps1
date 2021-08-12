$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://ol-public-artifacts.s3.amazonaws.com/openlegacy-cli/1.38.0/windows/openlegacy-cli.zip' # download url, HTTPS preferred

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'  # 'EXE_MSI_OR_MSU' #only one of these: exe, msi, msu
  url           = $url

  softwareName  = 'openlegacy-cli*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = '61f7f99b4ead77ac20b8881051d06ac4b4ebeb6f6c97b18efd61e3b9ff00bc8c'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
}

Install-ChocolateyZipPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyPath "$toolsDir\ol\bin" 'Machine' # Machine will assert administrative rights

# Git bash support
Start-Process "$toolsDir\ol\bin\write_to_bash.bat" # Run script to add git bash_profile the 'ol' alias and autocomplete

# remove connectors
$connectors="$HOME/.ol/cli/connectors"
echo "Removing outdated connectors at $connectors ..."
Remove-Item $connectors -Recurse -ErrorAction Ignore

echo "*********************************************************************************************"
echo "Note that the CLI require java 11, please make sure its installed and JAVA_HOME is configured"
echo "*********************************************************************************************"
