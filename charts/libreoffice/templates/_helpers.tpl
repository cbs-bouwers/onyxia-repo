{{/*
  Return the target Kubernetes version
*/}}

{{- define "app.name" -}}
libreoffice
{{- end }}

{{- define "app.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}