{{- define "hello-eks.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}
{{- define "hello-eks.fullname" -}}
{{- printf "%s" (include "hello-eks.name" .) -}}
{{- end -}}
{{- define "hello-eks.labels" -}}
app.kubernetes.io/name: {{ include "hello-eks.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
