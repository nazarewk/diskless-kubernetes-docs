# Przegląd sposobów konfiguracji klastra Kubernetes

Najpopularniejszym rozwiązaniem konfiguracji klastra Kubernetes jest 
[kops](https://github.com/kubernetes/kops), ale jak większoś


Interesują nas tylko i wyłącznie rozwiązania bare-metal:
- [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/)
  - [Install with kubadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)
- [kubespray](https://github.com/kubernetes-incubator/kubespray)
  - zestaw skryptów Ansible konfigurujących klaster na jednym z wielu systemów operacyjnych
  - dąży do zostania tzw.  
    [Operatorem](https://github.com/kubernetes-incubator/kubespray/blob/master/docs/comparisons.md)
    korzystającym z kubeadm
- [Fedora via Ansible](https://kubernetes.io/docs/getting-started-guides/fedora/fedora_ansible_config/)
  - deprekowane na rzecz kubespray - odpada
- [Rancher 2.0](http://rancher.com/rancher2-0/), korzysta z RKE
- [Rancher Kubernetes Installer](http://rancher.com/announcing-rke-lightweight-kubernetes-installer/)
- [Rancher 1.X](https://rancher.com/rancher/)

## Rancher 2.0

```bash
docker run --rm --name rancher -d -p 8080:8080 rancher/server:v2.0.0-alpha10
#docker logs -f rancher
```
potem wyklikac host, podac adres w sieci z node'ami Kubernetes i uruchomic
dockerowa komende na node'ach (np. CoreOSowych)

## Rancher 1.X

```bash
docker run --rm --name rancher -d -p 8080:8080 rancher/server:latest
```

jw.

## kubespray-cli

Nie radzi sobie z brakiem Python'a na domyślnej dystrybucji CoreOS'a, stąd
do standardowego flow potrzebny jest dodatkowy playbook realizujący jego
instalację zanim uruchomimy `kubespray deploy`

```bash
#!/usr/bin/env bash
set -e

#pip2 install ansible kubespray
get_coreos_nodes() {
  for node in $@
  do
    echo node1[ansible_host=${node},bootstrap_os=coreos,ansible_user=core]
  done
}

NODES=(192.168.56.{10,12,13})
NODES=($(get_coreos_nodes ${NODES[@]}))
echo NODES=${NODES[@]}
kubespray prepare -y --nodes ${NODES[@]}
cat > ~/.kubespray/bootstrap-os.yml << EOF
- hosts: all
  become: yes
  gather_facts: False
  roles:
  - bootstrap-os
EOF

(cd ~/.kubespray; ansible-playbook -i inventory/inventory.cfg bootstrap-os.yml)
kubespray deploy -y --coreos
```
Wykrzacza się na kroku czekania na uruchomienie `etcd` ponieważ oczekuje 
połączenia na NATowym interfejsie z adresem `10.0.3.15` zamiast host network
z adresem `192.168.56.10`.

## kubespray

```bash
#!/usr/bin/env bash
set -e

#pip2 install ansible kubespray
dir=~/.kubespray
inventory=my_inventory
[ -f ${dir} ] && git clone git@github.com:kubernetes-incubator/kubespray.git ${dir} || (cd ${dir} && git pull)
cd ${dir}

# based on https://github.com/kubernetes-incubator/kubespray/blob/master/docs/getting-started.md#building-your-own-inventory
cp -r inventory ${inventory}
declare -a IPS=(192.168.56.{10,12,13})
CONFIG_FILE=${inventory}/inventory.cfg python3 contrib/inventory_builder/inventory.py ${IPS[@]}

cat > ${inventory}/group_vars/all.yml << EOF
bootstrap_os: coreos
loadbalancer_apiserver:
  address: 0.0.0.0
  port: 8080
kubeconfig_localhost: true
kubectl_localhost: true
EOF

ansible-playbook -i ${inventory}/inventory.cfg cluster.yml -b -v
```

TODO: jak sie dostać do dashboard'u?