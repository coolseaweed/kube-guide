

## Kubernetes commands


### Alias
alias|definition
:---|:---
k|kubectl
rs|replicaset
svc|service
ns|namepsaces
cm|configmap



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

label
- `k label nodes <node name> <key>=<value>`

nodeAffinity
- `k label nodes <node name> <key>=<value>`

static pods
> How to check the pods is static pods
- `k get pods -A` and find `-controlplane` appended pods
- `k get pod <pod name> -o yaml | grep -A 10 'ownerReferences:' | grep 'kind:'` output -> `kind: Node` 

- `ps -ef | grep /usr/bin/kubelet`: to lookfor kubelet cmds
- `cat /var/lib/kubelet/config.yaml | grep -i static`: to checkout the path of directory holding the static pod definition files


rolling updates and rollbacks
- `k rollout status <deployment name>`
- `k rollout history <deployment name>`
- `k rollout undo <deployment name>`


en/decoding secret keys
- `echo -n <value> | base64`: encode (caution!! not encrypted!)
- `echo -n <encoded value> | base64 --decode`: decode
