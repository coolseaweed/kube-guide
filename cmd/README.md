

## Kubernetes commands


### Alias
alias|definition
:---|:---
k|kubectl
rs|replicaset
svc|service
ns|namepsaces



```bash
# add following scripts to ~/.bashrc

alias kubectl="k3s kubectl"
source /etc/profile.d/bash_completion.sh
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k
alias crictl='k3s crictl'
eval "$(starship init bash)"
export KUBE_EDITOR="vim"
export PS1="\h $ "
export PAGER=less
```


### Commands

replicaset
- `k create -f <file-path>`
- `k get replicaset`
- `k delete replicaset <name>`
- `k replace -f <file-path>`
- `k scale -replicas=<num> -f <file-path>`
- `k explain replicaset`
- `k get pods -o yaml`
- `k get replicaset -o yaml`
- `k get all` : to see all info
- `k edit rs <replica name>`
- `k run nginx --image=nginx --dry-run-client -o yaml`: to generate Pod manifest yaml file
- `k create deployment --image=nginx --dry-run-client -o yaml`: to generate Deployment yaml file

service
- `k get services`

namespaces
- `k config set-context $(kubectl config current-context) --namespace=dev`: to change defaul namespace as `dev`
- `k get pods --all-namespaces(-A)`