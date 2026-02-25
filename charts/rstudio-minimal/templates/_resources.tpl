# Generates a resource definition
#

{{- define "rstudio.resources" }}
	{{- if .Values.resources.custom }}
		{{ toYaml .Values.resources }}
	{{- else }}
		{{- if eq .Values.resources.size "XS" }}
			# XS: provide between 0.5 - 1.1 vCPU + 1 - 2 GB RAM
			requests:
				cpu: 500m
				memory: 1024Gi
			limits:
				cpu: 1100m
				memory: 2048Gi
		{{- else if eq ".Values.resources.size" "S" }}
			# S: provide between 0.5 - 1.1 vCPU + 2 - 4 GB RAM
			requests:
				cpu: 900m
				memory: 2048Gi
			limits:
				cpu: 1100m
				memory: 4096Gi
		{{- else if eq ".Values.resources.size" "M" }}
			# M: provide between 0.5 - 2.1 vCPU + 2 - 8 GB RAM
			requests:
				cpu: 900m
				memory: 2048Gi
			limits:
				cpu: 2100m
				memory: 8192Gi
		{{- else if eq ".Values.resources.size" "L" }}
			# L: provide between 2.0 - 4.1 vCPU + 2 - 16 GB RAM
			requests:
				cpu: 2000m
				memory: 2048Gi
			limits:
				cpu: 4100m
				memory: 16384Gi
		{{- else if eq ".Values.resources.size" "XL" }}
			# XL: provide between 2.0 - 8.1 vCPU + 2 - 32 GB RAM
			requests:
				cpu: 2000m
				memory: 2048Gi
			limits:
				cpu: 8100m
				memory: 32768Gi
		{{- end }}
	{{- end }}
{{- end}}
