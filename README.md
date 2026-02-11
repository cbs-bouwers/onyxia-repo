# Onyxia helm charts

Create github pages > doc

> cd doc
> cd library-chart/
> helm package .
> mv mv library-chart-2.0.3.tgz ../jupyter-python/charts/
> cd ..
> helm create my-chart
> helm package my-chart
> helm repo index . --url https://cbs-bouwers.github.io/onyxia-repo/

Change 
index.yaml
    urls:
    - https://cbs-bouwers.github.io/onyxia-repo/.....tgz