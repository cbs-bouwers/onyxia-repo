{{/*
  Return the target Kubernetes version
*/}}

{{- define "app.name" -}}
pspp
{{- end }}

{{- define "app.user" -}}
user-max
{{- end }}

{{- define "app.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}