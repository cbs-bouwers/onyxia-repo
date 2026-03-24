{{/*
  Return the target Kubernetes version
*/}}

{{- define "my-express-app.name" -}}
libreoffice
{{- end }}

{{- define "my-express-app.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}