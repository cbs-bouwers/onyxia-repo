{{/*
  Return the target Kubernetes version
*/}}

{{- define "app.name" -}}
webtop
{{- end }}

{{- define "app.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}