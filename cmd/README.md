

## Kubernetes commands


### Alias
alias|definition
:---|:---
k|kubectl
rs|replicaset
svc|service
ns|namepsaces
cm|configmap
sa|serviceaccounts



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
- `k get secrets -A -o json | k replace -f -`: replace all secrets into new schema

kubeapi-server
- `crictl pods`

config
- `k config view`
- `k config use-context <cluster name>`
- `k describe pod <kube-apiserver pod name> -n kube-system`: to check out wether external etcd
- `vi /etc/systemd/system/ectd.service` : in container change datadir + `systemctl daemon-reload` + `systemctl restart etcd`

Certificate Authority create (via OpenSSL)

**CA**
- `openssl genrsa -out ca.key 2048`: generate keys
- `openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr`: generate Certificate Signing Request (CSR)
- `openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt`: generate signed certificate (CA)

**admin**
- `openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out admin.csr`: generate Certificate Signing Request (CSR)
- `openssl x509 -req -in admin.csr -CA ca.crt -CAKey ca.key -out admin.crt`: generate signed certificate (client or admin)

**kube api server**
- `openssl req -new -key admin.key -subj "/CN=kube-apiserver" -out apiserver.csr -config openssl.cnf`: generate Certificate Signing Request (CSR)
```
[req]
req_extension = v3_req
distinguished_name = req_distinguished_name
[v3_req]
basicConstraints= CA:FALSE
keyUsage = nonRepudiation
sujectAltName = @alt_names
[alt_names]
DNS.1 = kubernates
DNS.2 = kubernates.default
DNS.3 = kubernates.default.svc
DNS.4 = kubernates.default.svc.cluster.local
IP.1 = 10.96.0.1
IP.2 = 172.17.0.87
```

Logging
- `openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout`: to veiw cert file
- `journalctl -u etcd.service -l`: inspect service logs
- `ps -ef`: logging processing apps


kube-CSR
- `cat <csr filename> | base64 -w 0`: create base64 encoded content
```
---
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: akshay
spec:
  groups:
  - system:authenticated
  request: <Paste the base64 encoded value of the CSR file>
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
``` 
- `k get csr`: get csr list
- `k certificate approve akshay`: approve CSR request

config
- `k config view`
- `k config --kubeconfig=<config path> [CMD]`

RBAC(Role Based Access Controls)
- `k get roles`
- `k get rolebindings`
- `k describe role developer`
- `k auth can-i create deployments (--as <user>)`: check access
- `k auth can-i delete nodes`: check access
- `/var/rabc`: role & rolebinding config files

service account
- `k create token <service account>`
- `https://jwt.io/`: to see token contents