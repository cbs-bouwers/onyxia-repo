# PSPP
Read 50_apps/pspp/README.md on the futurum repo for image creation details. The helm chart expect the images to be available on a public repo or the klusters local repo: cbsfuturumacr.azurecr.io

# Create a helm chart:

1. Add a Chart.yaml
Copy one from reference charts. Change name and reset version to 0.0.1. Give it some description and place an icon in docs/icons and reference to it. Onyxia will use these to create an app tile. keywords and home are also properties used by Onyxia to personalize the app tile.

2. Add values.yaml
This is the regular helm value file which contains variables used by helm to merge into the templates (deployment, service, ingress etc). These values can also be hardcoded, but important: Values that need to be set by the user or Onyxia runtime should be defined in the value file.

3. Add deployment.yaml
Add a deployment descriptor to the templates directory. For Onyxia to function correctly we need to add metadata labels (app.kubernetes.io/name, app.kubernetes.io/instance) on deployment and template. This is used to check if the app is up and running and prevents an eternal loading spinner. 

4. Add service.yaml
5. Add ingress.yaml

# 


> yq -i '.version |= ( split(".") | .[2] = ((.[2] | tonumber) + 1 | tostring) | join(".") )' charts/libreoffice/Chart.yaml
> rm docs/pspp-*.tgz 
> helm package charts/pspp -d docs
> helm repo index docs --url https://cbs-bouwers.github.io/onyxia-repo/

git commit and push

> kubectl rollout restart deployment platform-onyxia-api