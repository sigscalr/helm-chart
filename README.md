# SigScalr Helm Chart

SigScalr Helm Chart provides a simple deployment for a highly performant, low overhead log managment system that supports automatic Kubernetes events & container logs exporting

# TLDR Installation:

```
helm repo add sigscalr-repo https://sigscalr.github.io/helm-chart
helm install sigscalr sigscalr-repo/sigscalr
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
| sigscalr.storage.size | Storage size for persistent volume claim. Recommended to be half of license limit |
| sigscalr.core.service.alternateServiceType | by default, a headless service is always created for sigscalr. Another service can be created by defining this config |
| sigscalr.core.service.port | Port used by the sigscalr service |
| sigscalr.core.service.annotations | Annotations used for the sigscalr service |
| sigscalr.ui.enabled | Enable the SigScalr UI |
| sigscalr.ui.service.serviceType | How to expose the SigScalr UI service |
| sigscalr.ui.service.port | Port used by the SigScalrUI service |
| sigscalr.ui.service.annotations | Annotations used by the SigScalrUI service |
| k8sExporter.enabled   | Enable automatic exporting of k8s events using [an exporting tool](https://github.com/opsgenie/kubernetes-event-exporter)      |
| k8sExporter.configs.index   | Output index name for kubernetes events      |
| logsExporter.enabled   | Enable automatic exporting of logs using a Daemonset [fluentd](https://docs.fluentd.org/container-deployment/kubernetes)      |
| logsExporter.configs.indexPrefix   | Prefix of index name used by logStash. Suffix will be namespace of log source      |

If k8sExporter or logsExporter is enabled, then a ClusterRole will be created to get/watch/list all resources in all apigroups. Which resources and apiGroups can be edited in serviceAccount.yaml

## Storage options

Currently, only `awsEBS` and `local` storage classes provisioners can be configured by setting `storage.defaultClass: false` and setting the required configs. To add more types of storage classes, add the necessary provisioner info to [`storage.yaml`](charts/sigscalr/templates/storage.yaml). 

It it recommended to use a storage class that supports volume expansion. 

Example configuration to use an EBS storage class.
```
storage:
    defaultClass: false
    size: 20Gi
    awsEBS:
      parameters: 
        type: "gp2"
        fsType: "ext4"
```

Example configuration to use a local storage class.
```
storage:
    defaultClass: false
    size: 20Gi
    local:
        hostname: minikube
        capacity: 5Gi 
        path: /data # must be present on local machine
```