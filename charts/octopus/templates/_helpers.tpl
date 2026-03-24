{{/*
  Return the target Kubernetes version
*/}}

{{- define "my-express-app.name" -}}
octopus-app
{{- end }}

{{- define "my-express-app.fullname" -}}
{{ include "my-express-app.name" . }}
{{- end }}