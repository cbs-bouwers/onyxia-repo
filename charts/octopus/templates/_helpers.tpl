{{/*
  Return the target Kubernetes version
*/}}

{{- define "app.name" -}}
octopus-app
{{- end }}

{{- define "app.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}