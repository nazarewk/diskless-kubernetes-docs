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

## Rancher 1.X/2.0 {#rancher-kubernetes}

Wygodne narzędzie do uruchamiania i monitorowania klastra Kubernetes, ale wymaga
interakcji użytkownika. 

```bash
#rancher_version=latest
rancher_version=v2.0.0-alpha10
docker run --rm --name rancher -d -p 8080:8080 rancher/server:${rancher_version}
```

Najpierw należy zalogować się do panelu administracyjnego Ranchera i 
przeprowadzić podstawową konfigurację (adres Ranchera + uzyskanie komendy).

Następnie w celu dodania węzła do klastra wystarczy wywołać jedną komendę 
udostępnioną w panelu administracyjnym Ranchera na docelowym węźle, 
jej domyślny format to:
    
```bash
wersja_agenta=v1.2.9
ip_ranchera=192.168.56.1
skrypt=B52944BEFAA613F0CE90:1514678400000:E2yB6KfxzSix4YHti39BTw5RbKw

sudo docker run --rm --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/rancher:/var/lib/rancher \
  rancher/agent:${wersja_agenta} \
  http://${ip_ranchera}:8080/v1/scripts/${skrypt}
```

W ciągu 2 godzin przeglądu nie udało mi się zautomatyzować procesu uzyskiwania
ww. komendy.

Następnie w cloud-config'u RancherOS'a możemy dodać ww. komendę w formie:
```yaml
#cloud-config
runcmd:
- docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.9 http://192.168.56.1:8080/v1/scripts/...
```

Od wersji 2.0 umożliwia połączenie się z istniejącym klastrem:

    kubectl apply -f http://192.168.56.1:8080/v3/scripts/303F60E1A5E186F53F3F:1514678400000:wstQFdHpOgHqKahoYdmsCXEWMW4.yaml


W wersji `v2.0.0-alpha10` losowo pojawia się błąd
[Upgrade Environment](https://github.com/rancher/rancher/issues/10396).

![Błąd pt. Upgrade Environment](assets/rancher2.0-error.png){dpi=400}

## kubespray-cli

Jest to narzędzie ułatwiające korzystanie z `kubespray`.
Z powodu [błędu](https://github.com/kubespray/kubespray-cli/issues/120)
logiki narzędzie nie radzi sobie z brakiem Python'a na domyślnej dystrybucji 
CoreOS'a, mimo że sam `kubespray` radzi sobie z nim świetnie.
Do uruchomienia na tym systemie potrzebne jest ręczne wywołanie roli 
[`bootstrap-os`](https://github.com/kubernetes-incubator/kubespray/blob/master/roles/bootstrap-os/tasks/main.yml)
z `kubespray` zanim przystąpimy do właściwego deploy'u.

```{.bash include=ipxe-boot/bin/kubernetes-kubespray-cli.sh}
```

Wykrzacza się na kroku czekania na uruchomienie `etcd` ponieważ oczekuje 
połączenia na NATowym interfejsie z adresem `10.0.3.15` zamiast host network
z adresem `192.168.56.10`, stąd `ansible_default_ipv4.address`.

Według użytkowników 
[oficjalnego Slacka kubespray](https://kubernetes.slack.com/messages/kubespray)
`kubespray-cli` jest deprekowane.


## kubespray

Kod znajduje się w moim repozytorium
[kubernetes-cluster](https://github.com/nazarewk/kubernetes-cluster).

```{.bash include=kubernetes-cluster/bin/setup-cluster}
```


### Kubernetes Dashboard
Dostęp do Dashboardu najprościej można uzyskać:

1. [nadanie wszystkich uprawnień roli `kubernetes-dashboard`](https://github.com/kubernetes/dashboard/wiki/Access-control#admin-privileges)
2. Wejście na http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login
3. Kliknięcie skip

```{.bash include=kubernetes-cluster/bin/dashboard}
```

Linki:

- https://github.com/kubernetes/dashboard/wiki/Access-control
- https://github.com/kubernetes-incubator/kubespray/blob/master/docs/getting-started.md#accessing-kubernetes-dashboard


### Napotkane błędy

Błąd przy ustawieniu `loadbalancer_apiserver.address` na `0.0.0.0`:
```
TASK [kubernetes-apps/cluster_roles : Apply workaround to allow all nodes with cert O=system:nodes to register] ************************************
Wednesday 17 January 2018  22:22:59 +0100 (0:00:00.626)       0:08:31.946 *****
fatal: [node2]: FAILED! => {"changed": false, "msg": "error running kubectl (/opt/bin/kubectl apply --force --filename=/etc/kubernetes/node-crb.yml) command (rc=1): Unable to connect to the server: http: server gave HTTP response to HTTPS client\n"}
fatal: [node1]: FAILED! => {"changed": false, "msg": "error running kubectl (/opt/bin/kubectl apply --force --filename=/etc/kubernetes/node-crb.yml) command (rc=1): Unable to connect to the server: http: server gave HTTP response to HTTPS client\n"}
```
