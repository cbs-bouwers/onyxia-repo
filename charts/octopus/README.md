> change Chart.yaml 
version: 0.1.6
appVersion: "0.1.6"

> helm package charts/octopus
> mv octopus-0.1.6.tgz docs
> rm docs/octopus-0.1.5.tgz 
> helm repo index docs --url https://cbs-bouwers.github.io/onyxia-repo/

git commit and push

> kubectl rollout restart deployment platform-onyxia-api