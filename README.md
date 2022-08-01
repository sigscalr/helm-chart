# SigScalr Helm Chart

SigScalr Helm Chart provides a simple deployment for a highly performant, low overhead log managment system that supports automatic Kubernetes events & container logs exporting

# TLDR Installation:

```
helm repo add sigscalrrepo https://sigscalr.github.io/helm-chart
helm install sigscalr sigscalrrepo/sigscalr
```

# Installation

Please ensure that `helm` is installed.


To install SigScalr from source:
```bash
git clone
helm install sigscalr .
```

Important configs in `values.yaml`
| Values      | Description |
| ----------- | ----------- |
| sigscalr.configs      | Server configs for sigscalr       |
| sigscalr.storage   | Defines storage class to use for sigscalr StatefulSet        |
| k8sExporter.enabled   | Enable automatic exporting of k8s events using [an exporting tool](https://github.com/opsgenie/kubernetes-event-exporter)      |
| k8sExporter.configs.index   | Output index name for kubernetes events      |
| logsExporter.enabled   | Enable automatic exporting of logs using a Daemonset [fluentd](https://docs.fluentd.org/container-deployment/kubernetes)      |
| logsExporter.configs.indexPrefix   | Prefix of index name used by logStash. Suffix will be namespace of log source      |
| service.alternateServiceType | by default, a headless service is always created for sigscalr. Another service can be created using configs below |

If k8sExporter or logsExporter is enabled, then a ClusterRole will be created to get/watch/list all resources in all apigroups. Which resources and apiGroups can be edited in serviceAccount.yaml