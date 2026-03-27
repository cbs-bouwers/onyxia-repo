> change Chart.yaml 
version: 0.1.6
appVersion: "0.1.6"

> yq -i '.version |= ( split(".") | .[2] = ((.[2] | tonumber) + 1 | tostring) | join(".") )' charts/webtop/Chart.yaml
> rm docs/webtop-*.tgz 
> helm package charts/webtop -d docs
> helm repo index docs --url https://cbs-bouwers.github.io/onyxia-repo/

git commit and push

> kubectl rollout restart deployment platform-onyxia-api