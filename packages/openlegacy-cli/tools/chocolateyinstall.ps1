$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://ol-public-artifacts.s3.amazonaws.com/openlegacy-cli/2.17.0/windows/openlegacy-cli.zip' # download url, HTTPS preferred

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'  # 'EXE_MSI_OR_MSU' #only one of these: exe, msi, msu
  url           = $url

  softwareName  = 'openlegacy-cli*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = 'b7054df3a076acf2352d2db382278d5a4286a27c3bec04e920fb71688a1c43d9'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
}

Install-ChocolateyZipPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyPath "$toolsDir\ol\bin" 'Machine' # Machine will assert administrative rights

# Git bash support
Start-Process "$toolsDir\ol\bin\write_to_bash.bat" # Run script to add git bash_profile the 'ol' alias and autocomplete

# cleanup before upgrade/install
$dirnames = @('connectors','generators','deployers')
foreach ($i in $dirnames) {
    $dirpath="$HOME/.ol/cli/$i"
    echo "Removing outdated resources at $dirpath ..."
    Remove-Item $dirpath -Recurse -ErrorAction Ignore
}

echo "*******************************************************************************************************"
echo "Note that the CLI require java 17 or higher, please make sure its installed and JAVA_HOME is configured"
echo "*******************************************************************************************************"

