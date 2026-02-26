# rstudio-minimal

![Version: 2.4.2](https://img.shields.io/badge/Version-2.4.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

The RStudio IDE with a collection of standard data science packages.
This service limits user-configuration options to the minimum.

**Homepage:** <https://www.rstudio.com/>

## Minimal Chart

This is a minimal chart, which means that the amount of configuration options the user can adjust is greatly limited.

What's different from standard INSEE Charts?

- No custom container image (user can only pick image from list)
- By default T-shirt size resources (XS, S, M, L, XL)
- (WIP) Provide users with option to customize resources
- Remove Kubernetes permissions (do not allow users to create services that change cluster)
- Hide Vault from (Onyxia uses form to inject vault settings)
- Hide S3 configuration (Onyxia uses form to inject S3 settings)
- Hide Git configuration (Onyxia can inject information into form)
- Remove networking (do not allow user to open extra ports on service)
- Remove discovery (do not discover third-party services in cluster (like PostgeSQL))
- Remove security (do not allow user to change container password)

## T-Shirt sizing

> [!NOTE]
> Sizes are defined in `templates/_resources.tpl`

| Size | CPU (reserved - limit) [mCPU] | RAM (claimed - limit) [GiB] | Purpose                    |
| ---- | ----------------------------- | --------------------------- | -------------------------- |
| XS   | 1000 - 1000                   | 1 - 1                       | Batchjobs, Small projects  |
| S    | 1000 - 2000                   | 2 - 2                       | Entry-level data analysis  |
| M    | 2000 - 4000                   | 4 - 4                       | Common usage               |
| L    | 2000 - 4000                   | 8 - 8                       | Large datasets             |
| XL   | 4000 - 8000                   | 16 - 16                     | Advanced, high-performance |

### Kubernetes resource limits and scheduling

- Kubernetes schedules pods on a node according to the **requested** size.
- _If_ node has capacity, pods are allowed to consume more than the requested size (up to the their limit).
- Keep in mind, a node will need to spend some of its resources on administration
- CPU resources are determined in CPU units: 1000 mCPU = 1 physical/virtual CPU.
  I prefer to think of CPU als % of cycles; 1000 mCPU = 100% clock-cycles of 1 CPU go to process, 1.5 CPU = 100% of CPU A + 50% of CPU B
- Memory resources should be defined in "bibytes": KiB, MiB, GiB, TiB (1 KiB = 1024 bytes, 1 MiB = 1048576 bytes)
- Exceeding CPU _limits_ will cause containers to be throttled.
- Exceeding Memory _limits_ will cause kubernetes to **kill** the container.
- Containers _can use the unused requested CPU time_ of other containers (within their limit).

Right now I've just selected some initial values without too much consideration.
We may want to investigate the proper values later.

## Source Code

- <https://github.com/InseeFrLab/images-datascience>
- <https://github.com/InseeFrLab/helm-charts-interactive-services>

## Requirements

| Repository                                                    | Name          | Version |
| ------------------------------------------------------------- | ------------- | ------- |
| https://inseefrlab.github.io/helm-charts-interactive-services | library-chart | 2.0.3   |

## Values

| Key                                        | Type   | Default                              | Description |
| ------------------------------------------ | ------ | ------------------------------------ | ----------- |
| affinity                                   | object | `{}`                                 |             |
| autoscaling.enabled                        | bool   | `false`                              |             |
| autoscaling.maxReplicas                    | int    | `100`                                |             |
| autoscaling.minReplicas                    | int    | `1`                                  |             |
| autoscaling.targetCPUUtilizationPercentage | int    | `80`                                 |             |
| discovery.postgresql                       | bool   | `true`                               |             |
| environment.group                          | string | `"users"`                            |             |
| environment.user                           | string | `"onyxia"`                           |             |
| extraEnvVars                               | list   | `[]`                                 |             |
| fullnameOverride                           | string | `""`                                 |             |
| git.branch                                 | string | `""`                                 |             |
| git.cache                                  | string | `""`                                 |             |
| git.email                                  | string | `""`                                 |             |
| git.enabled                                | bool   | `false`                              |             |
| git.name                                   | string | `""`                                 |             |
| git.repository                             | string | `""`                                 |             |
| git.secretName                             | string | `""`                                 |             |
| git.token                                  | string | `""`                                 |             |
| global.suspend                             | bool   | `false`                              |             |
| imagePullSecrets                           | list   | `[]`                                 |             |
| ingress.annotations                        | list   | `[]`                                 |             |
| ingress.certManagerClusterIssuer           | string | `""`                                 |             |
| ingress.enabled                            | bool   | `false`                              |             |
| ingress.hostname                           | string | `"chart-example.local"`              |             |
| ingress.path                               | string | `"/"`                                |             |
| ingress.tls                                | bool   | `true`                               |             |
| ingress.tlsSecretName                      | string | `""`                                 |             |
| ingress.useCertManager                     | bool   | `false`                              |             |
| ingress.useTlsSecret                       | bool   | `false`                              |             |
| ingress.userHostname                       | string | `"chart-example-user.local"`         |             |
| ingress.userPath                           | string | `"/"`                                |             |
| init.personalInit                          | string | `""`                                 |             |
| init.personalInitArgs                      | string | `""`                                 |             |
| init.regionInit                            | string | `""`                                 |             |
| init.standardInitPath                      | string | `"/opt/onyxia-init.sh"`              |             |
| kubernetes.enabled                         | bool   | `true`                               |             |
| kubernetes.role                            | string | `"view"`                             |             |
| message.en                                 | string | `""`                                 |             |
| message.fr                                 | string | `""`                                 |             |
| nameOverride                               | string | `""`                                 |             |
| networking.clusterIP                       | string | `"None"`                             |             |
| networking.service.port                    | int    | `8787`                               |             |
| networking.sparkui.port                    | int    | `4040`                               |             |
| networking.type                            | string | `"ClusterIP"`                        |             |
| networking.user.enabled                    | bool   | `false`                              |             |
| networking.user.port                       | int    | `5000`                               |             |
| networking.user.ports                      | list   | `[]`                                 |             |
| nodeSelector                               | object | `{}`                                 |             |
| openshiftSCC.enabled                       | bool   | `false`                              |             |
| openshiftSCC.scc                           | string | `""`                                 |             |
| persistence.accessMode                     | string | `"ReadWriteOnce"`                    |             |
| persistence.enabled                        | bool   | `true`                               |             |
| persistence.size                           | string | `"10Gi"`                             |             |
| podAnnotations                             | object | `{}`                                 |             |
| podSecurityContext.fsGroup                 | int    | `100`                                |             |
| postgresql.secretName                      | string | `""`                                 |             |
| proxy.enabled                              | bool   | `false`                              |             |
| proxy.httpProxy                            | string | `""`                                 |             |
| proxy.httpsProxy                           | string | `""`                                 |             |
| proxy.noProxy                              | string | `""`                                 |             |
| replicaCount                               | int    | `1`                                  |             |
| repository.configMapName                   | string | `""`                                 |             |
| repository.packageManagerUrl               | string | `""`                                 |             |
| repository.rRepository                     | string | `""`                                 |             |
| resources.size                             | string | `"M"`                                |             |
| resources.custom.requests.cpu              | string | `1000m`                              |             |
| resources.custom.requests.memory           | string | `"1Gi"`                              |             |
| route.annotations                          | list   | `[]`                                 |             |
| route.enabled                              | bool   | `false`                              |             |
| route.hostname                             | string | `"chart-example.local"`              |             |
| route.tls.termination                      | string | `"edge"`                             |             |
| route.userHostname                         | string | `"chart-example-user.local"`         |             |
| route.wildcardPolicy                       | string | `"None"`                             |             |
| runtimeClassName                           | string | `""`                                 |             |
| s3.accessKeyId                             | string | `""`                                 |             |
| s3.defaultRegion                           | string | `""`                                 |             |
| s3.enabled                                 | bool   | `false`                              |             |
| s3.endpoint                                | string | `""`                                 |             |
| s3.pathStyleAccess                         | bool   | `false`                              |             |
| s3.secretAccessKey                         | string | `""`                                 |             |
| s3.secretName                              | string | `""`                                 |             |
| s3.sessionToken                            | string | `""`                                 |             |
| s3.workingDirectoryPath                    | string | `""`                                 |             |
| security.allowlist.enabled                 | bool   | `false`                              |             |
| security.allowlist.ip                      | string | `"0.0.0.0/0"`                        |             |
| security.networkPolicy.enabled             | bool   | `false`                              |             |
| security.networkPolicy.from                | list   | `[]`                                 |             |
| security.password                          | string | `"changeme"`                         |             |
| securityContext                            | object | `{}`                                 |             |
| service.image.custom.enabled               | bool   | `false`                              |             |
| service.image.custom.version               | string | `"inseefrlab/onyxia-rstudio:r4.5.2"` |             |
| service.image.pullPolicy                   | string | `"IfNotPresent"`                     |             |
| service.image.version                      | string | `"inseefrlab/onyxia-rstudio:r4.5.2"` |             |
| service.initContainer.image                | string | `"inseefrlab/onyxia-base:latest"`    |             |
| service.initContainer.pullPolicy           | string | `"IfNotPresent"`                     |             |
| serviceAccount.annotations                 | object | `{}`                                 |             |
| serviceAccount.create                      | bool   | `true`                               |             |
| serviceAccount.name                        | string | `""`                                 |             |
| startupProbe.failureThreshold              | int    | `60`                                 |             |
| startupProbe.initialDelaySeconds           | int    | `10`                                 |             |
| startupProbe.periodSeconds                 | int    | `10`                                 |             |
| startupProbe.successThreshold              | int    | `1`                                  |             |
| startupProbe.timeoutSeconds                | int    | `2`                                  |             |
| tolerations                                | list   | `[]`                                 |             |
| userPreferences.darkMode                   | bool   | `false`                              |             |
| userPreferences.language                   | string | `"en"`                               |             |
| vault.directory                            | string | `""`                                 |             |
| vault.enabled                              | bool   | `false`                              |             |
| vault.mount                                | string | `""`                                 |             |
| vault.secret                               | string | `""`                                 |             |
| vault.secretName                           | string | `""`                                 |             |
| vault.token                                | string | `""`                                 |             |
| vault.url                                  | string | `""`                                 |             |

---

Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
