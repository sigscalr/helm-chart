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
| k8sExporter.enabled   | Enable automatic exporting of k8s events using [an exporting tool](https://github.com/opsgenie/kubernetes-event-exporter)      |
| k8sExporter.configs.index   | Output index name for kubernetes events      |
| logsExporter.enabled   | Enable automatic exporting of logs using a Daemonset [fluentd](https://docs.fluentd.org/container-deployment/kubernetes)      |
| logsExporter.configs.indexPrefix   | Prefix of index name used by logStash. Suffix will be namespace of log source      |
| service.alternateServiceType | by default, a headless service is always created for sigscalr. Another service can be created using configs below |

If k8sExporter or logsExporter is enabled, then a ClusterRole will be created to get/watch/list all resources in all apigroups. Which resources and apiGroups can be edited in serviceAccount.yaml


### Storage options

Currently, only `awsEBS` and `local` storage classes provisioners can be configured by setting `storage.defaultClass: false` and setting the required configs. To add more types of storage classes, add the necessary provisioner info to [`storage.yaml`](charts/sigscalr/templates/storage.yaml). 

It it reccomended to use a storage class that supports volume expansion. 

Example configuration to use an EBS storage class.
```
storage:
    defaultClass: false
    awsEBS:
      parameters: 
        type: "gp2"
        fsType: "ext4"
```

Example configuration to use a local storage class.
```
storage:
    defaultClass: false
    local:
        hostname: minikube
        capacity: 5Gi 
        path: /data # must be present on local machine
```