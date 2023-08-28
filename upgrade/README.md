`kubeadm upgrade plan`: upgrade version check


Reference: `https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/`

Step 1. unschedule node

`k drain <node-name> --ignore-daemonsets`
