# Onyxia helm charts
This repo is used by Onyxia datalab. It serves as a catalog of available applications.

To make the code reachable for onyxia crate a gihub pages pointing to docs directory (docs is default for pages):

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
 
If you change the catalog, you must restart the Onyxia API for changes to take effect.

> kubectl rollout restart deployment platform-onyxia-api