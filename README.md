# Onyxia helm charts

This repo is used by Onyxia datalab. It serves as a catalog of available applications.

## How to manage Charts?

1. Create chart folder with `helm create charts/my-chart`
2. Add INSEE's `library-chart` dependency to `charts/my-chart/Chart.yaml`

```
dependencies:
  - name: library-chart
    version: 2.0.3
    repository: https://inseefrlab.github.io/helm-charts-interactive-services
```

2. Modify chart

> [!TIP]
> You can use `helm template --debug ./charts/my-chart -f __test/values_my-chart.yaml > __test/resources.yaml`, \
> to test the templating of the chart, by rendering the kubernetes resources using a basic test values file.\
> In this example I've created \_\_test/values-my-chart.yaml to test what resource definitions the charts creates,
> given specific test values.\
> With the `--debug` flag Helm will render the resource definitions even if it leads to invalid YAML.

3. Update Chart version in `charts/my-chart/Chart.yaml`
4. Run `./scripts/build_chart.sh my-chart` to package chart and update repository index. This will do

- `helm lint`
- `helm dependency update`
- `helm package`
- `helm repo index`

5. Commit and push to `main`
6. Wait for Github Action to update github page at https://cbs-bouwers.github.io/onyxia-repo/

## How to setup Chart repo for Onyxia?

To make the code reachable for onyxia create a gihub pages pointing to docs directory (docs is default for pages):

repo > settings> pages

Deploy from branch: main/docs

To add a library follow the following steps:

- helm create charts/my-chart (optional)
- Make sure you add dependency library-chart (in charts/my-chart/Chart.yaml):
  dependencies:
  - name: library-chart
    version: 2.0.3
    repository: https://inseefrlab.github.io/helm-charts-interactive-services
- helm dependency update charts/my-chart (pull dependencies)
- helm package charts/my-chart (package helm chart)
- mv charts/my-chart/my-chart-0.0.1.tgz docs/
- helm repo index docs --url https://cbs-bouwers.github.io/onyxia-repo/
- Push the hanges to main

If you change the catalog, you must restart the Onyxia API for changes to take effect. old versions will be shown in a dropdown, untill you remove them from the repo.

> kubectl rollout restart deployment platform-onyxia-api

To supply custom icons upload them docs/icons. You can refference them with the following url:

https://cbs-bouwers.github.io/onyxia-repo/icons/icon.png

# Theme
Add resources to onyxia-theme and zip to docs:

> zip -r docs/themes/onyxia-theme-futurum.zip onyxia-theme 

This theme set will be available under:

https://cbs-bouwers.github.io/onyxia-repo/themes/onyxia-theme-futurum.zip

And should be added to 40_platform/onyxia/values.yaml as:

onyxia:
  web:
    env:
      CUSTOM_RESOURCES