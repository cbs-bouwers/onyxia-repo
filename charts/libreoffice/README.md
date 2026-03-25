> change Chart.yaml 
version: 0.1.6
appVersion: "0.1.6"

> yq -i '.version |= ( split(".") | .[2] = ((.[2] | tonumber) + 1 | tostring) | join(".") )' charts/libreoffice/Chart.yaml
> rm docs/libreoffice-*.tgz 
> helm package charts/libreoffice -d docs
> helm repo index docs --url https://cbs-bouwers.github.io/onyxia-repo/

git commit and push

> kubectl rollout restart deployment platform-onyxia-api