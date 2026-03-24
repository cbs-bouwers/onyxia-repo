> change Chart.yaml 
version: 0.1.6
appVersion: "0.1.6"

> rm docs/octopus-*.tgz 
> helm package charts/octopus -d docs
> helm repo index docs --url https://cbs-bouwers.github.io/onyxia-repo/

git commit and push

> kubectl rollout restart deployment platform-onyxia-api