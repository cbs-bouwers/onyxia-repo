# Generates a resource definition
#
{{- define "rstudio.resources" -}}
  {{- if not .Values.resources.custom.enabled -}}
    {{- if eq .Values.resources.size "XS" }}
      {{/* XS: 1 vCPU + 1 GB RAM */ -}}
      requests:
        cpu: 1000m
        memory: 1Gi
      limits:
        cpu: 1000m
        memory: 1Gi
    {{- else if eq .Values.resources.size "S" }}
      {{/* S: 1 - 2 vCPU + 2 GB RAM */ -}}
      requests:
        cpu: 1000m
        memory: 2Gi
      limits:
        cpu: 2000m
        memory: 2Gi
    {{- else if eq .Values.resources.size "M" }}
      {{/* M: 2 - 4 vCPU + 4 GB RAM */ -}}
      requests:
        cpu: 2000m
        memory: 4Gi
      limits:
        cpu: 4000m
        memory: 4Gi
    {{- else if eq .Values.resources.size "L" }}
      {{/* L: 2 - 4 vCPU + 8 GB RAM */ -}} 
      requests:
        cpu: 2000m
        memory: 8Gi
      limits:
        cpu: 4000m
        memory: 8Gi
    {{- else if eq .Values.resources.size "XL" }}
      {{/* XL: 4 - 8 vCPU + 16 GB RAM */ -}}
      requests:
        cpu: 4000m
        memory: 16Gi
      limits:
        cpu: 8000m
        memory: 16Gi
    {{- end -}}
  {{- else }}
    requests:
      {{- toYaml .Values.resources.custom.requests | nindent 6 }}
    limits:
      {{- toYaml .Values.resources.custom.requests | nindent 6 }}
  {{- end -}}
{{- end -}}
