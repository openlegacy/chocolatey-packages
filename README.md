
# OpenLegacy Chocolatey packages

##### Add OpenLegacy `choco` source:


```console
choco source add --source=https://openlegacy.jfrog.io/artifactory/api/nuget/nuget-chocolatey --name=openlegacy
```


##### Install packages:

```console
choco install <package>
```
---

#### Openlegacy-CLI

```console
choco install openlegacy-cli
```

Install specific version:
```console
choco install openlegacy-cli --version=1.5.0
```

Install `alpha` version (0.0.0-alpha):
```console
choco install openlegacy-cli --version=0.0.0-alpha --ignore-checksum
```

*OpenLegacy packages are also available at Chocolatey.org: https://chocolatey.org/packages/openlegacy-cli

---
#### For maintainers

See the maintainer instructions in [packages/README.md](packages/README.md)
