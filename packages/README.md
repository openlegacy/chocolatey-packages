#### For maintainers

##### How to push new package version


1. Set the desired `version`, `url`, `sha256` values in package files:

- `packages/<package>/<package>.nuspec`
- `packages/<package>/tools/*.ps1`

2. Build and the package

- `cd packages/<package>`
- `choco pack`

3. Add the repository to your `choco` sources:

```console
# add repository to sources
choco source add --source=https://openlegacy.jfrog.io/artifactory/api/nuget/nuget-chocolatey --name=openlegacy

# set auth credentials
choco apikey --source=https://openlegacy.jfrog.io/artifactory/api/nuget/nuget-chocolatey --key "<artifactory_username>"<artifactory_password>"
```

4. Push your package

```console
cd packages/<package>
choco push "<package>.<vresion>.nupkg" --source=https://openlegacy.jfrog.io/artifactory/api/nuget/nuget-chocolatey
```
