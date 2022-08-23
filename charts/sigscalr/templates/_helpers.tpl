{{/*
Expand the name of the chart.
*/}}
{{- define "sigscalr.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sigscalr.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sigscalr.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sigscalr.labels" -}}
helm.sh/chart: {{ include "sigscalr.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sigscalr-server.labels" -}}
helm.sh/chart: {{ include "sigscalr.chart" . }}
{{ include "sigscalr-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sigscalr-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sigscalr.name" . }}-core
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sigscalr.serviceAccountName" -}}
{{- default (include "sigscalr.fullname" .) .Values.serviceAccount.name }}
{{- end }}

{{/*
Return the storage class name to use
*/}}
{{ define "sigscalr.storageClass" }}
{{ if .Values.sigscalr.storage.defaultClass }}
{{ else }}
storageClassName: {{ .Chart.Name }}-storage-class
{{ end }}
{{ end }}

{{/*
Events Exporter Common labels
*/}}
{{- define "sigscalr-events-exporter.labels" -}}
helm.sh/chart: {{ include "sigscalr.chart" . }}
{{ include "sigscalr-events-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Logs Exporter Common labels
*/}}
{{- define "sigscalr-fluentd.labels" -}}
helm.sh/chart: {{ include "sigscalr.chart" . }}
{{ include "sigscalr-fluentd.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
SigScalr UI Common labels
*/}}
{{- define "sigscalr-ui.labels" -}}
helm.sh/chart: {{ include "sigscalr.chart" . }}
{{ include "sigscalr-ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Log Exporter Selector labels
*/}}
{{- define "sigscalr-fluentd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sigscalr.name" . }}-fluentd
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Events Exporter Selector labels
*/}}
{{- define "sigscalr-events-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sigscalr.name" . }}-events-exporter
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
SigScalr UI Selector labels
*/}}
{{- define "sigscalr-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sigscalr.name" . }}-ui
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
SigScalr PVC storage size
*/}}
{{- define "sigscalr-pvc.size" -}}
{{ if .Values.sigscalr }}
{{ if .Values.sigscalr.storage }}
{{ if .Values.sigscalr.storage.size }}
storage: {{ .Values.sigscalr.storage.size }}
{{ else }}
storage: 10Gi
{{ end }}
{{ end }}
{{ end }}
{{- end }}