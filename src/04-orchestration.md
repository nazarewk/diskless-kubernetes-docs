# Przegląd pojęć i systemów związanych z konteneryzacją

W związku z mnogością pojęć związanych z izolacją, konteneryzacją i zarządzaniem
systemami komputerowymi zdecydowałem się pokrótce przybliżyć najważniejsze
pojęcia z tematem związane.

## Kubernetes

[Kubernetes](https://kubernetes.io/) jest jednym z najpopularniejszych narzędzi 
orkiestracji kontenerami i tematem przewodnim tego dokumentu. 
Został stworzony przez Google na bazie ich wewnętrznego systemu Borg.

- [Choosing the Right Containerization and Cluster Management Tool](https://dzone.com/articles/choosing-the-right-containerization-and-cluster-management-tool)

## Open Container Initiative

[Open Container Initiative](https://www.opencontainers.org/about) jest 
inicjatywą tworzenia i utrzymywania publicznych standardów związanych z formatem
i uruchamianiem kontenerów.

Większość projektów związanych z konteneryzacją dąży do kompatybilności 
ze standardami OCI, m. in.:
- [Docker](https://blog.docker.com/2017/07/demystifying-open-container-initiative-oci-specifications/)
- [Kubernetes CRI-O](https://github.com/kubernetes-incubator/cri-o)
- [Docker on FreeBSD](https://wiki.freebsd.org/Docker)
- [Running CloudABI applications on a FreeBSD based Kubernetes cluster, by Ed Schouten (EuroBSDcon '17)](https://www.youtube.com/watch?v=akLa9L5O0NY)

## Zarządzanie Kubernetes bez graficznego interfejsu
  
### kubeadm

- [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/)
- [Install with kubadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)

### Kubespray
- [kubespray](https://github.com/kubernetes-incubator/kubespray)
- zestaw skryptów Ansible konfigurujących klaster na jednym z wielu systemów operacyjnych
- dąży do zostania tzw.  
  [Operatorem](https://github.com/kubernetes-incubator/kubespray/blob/master/docs/comparisons.md)
  korzystającym z kubeadm
  
### OpenShift Ansible
Konfiguracja [OpenShift Origin](#openshift-origin) realizowana jest zestawem
skryptów Ansible'owych rozwijanych jako projekt 
[openshift-ansible](https://github.com/openshift/openshift-ansible).

### Eksperymentalne i deprekowane rozwiązania
- [Fedora via Ansible](https://kubernetes.io/docs/getting-started-guides/fedora/fedora_ansible_config/)
  deprekowane na rzecz kubespray
- [Rancher Kubernetes Installer](http://rancher.com/announcing-rke-lightweight-kubernetes-installer/)


## Graficzne nakładki na Kubernetes

### Kubernetes Dashboard

[Kubernetes Dashboard](https://github.com/kubernetes/dashboard) jest wbudowanym
interfejsem graficznym klastra Kubernetes. Umożliwia monitorowanie i zarządzanie
klastrem w ramach funkcjonalności samego Kubernetes.

### Rancher 
[Rancher](https://rancher.com/) jest platformą zarządzania kontenerami 
umożliwiającą między innymi zarządzanie klastrem Kubernetes.
Od wersji 2.0 twórcy skupiają się tylko i wyłącznie na zarządzaniu Kubernetes 
porzucając inne rozwiązania.

### OpenShift by Red Hat {#openshift-origin}
OpenShift jest komercyjną usługą typu PaaS (Platform as a Service), od wersji 3 
skupia się na zarządzaniu klastrem Kubernetes.

Rdzeniem projektu jest open sourcowy 
[OpenShift Origin](https://github.com/openshift/origin) konfigurowany przez
[OpenShift Ansible](#openshift-ansible).

- [OpenShift Origin vs Kubernetes](https://www.reddit.com/r/devops/comments/59ql4r/openshift_origin_vs_kubernetes/)
- [The Differences Between Kubernetes and OpenShift](https://medium.com/levvel-consulting/the-differences-between-kubernetes-and-openshift-ae778059a90e)
- [Demo konsoli](https://youtu.be/-mFovK19aB4?t=6m54s) (niestety po hebrajsku)

### DC/OS

[Datacenter Operating System](https://dcos.io/) jest częścią
[Mesosphere](https://mesosphere.com/) i Mesosa. Niedawno został rozszerzony
o [Kubernetes](https://mesosphere.com/blog/kubernetes-dcos/) jako alternatywnego
(w stosunku do [Marathon](https://mesosphere.github.io/marathon/)) systemu
orkiestracji kontenerami.

## Alternatywne rozwiązania zarządzania kontenerami

### Fleet
[Fleet](https://coreos.com/fleet/docs/latest/launching-containers-fleet.html)
jest nakładką na [systemd](https://www.freedesktop.org/wiki/Software/systemd/) 
realizująca rozproszony system inicjalizacji systemów.
Kontenery są uruchamiane i zarządzane przez systemd.

### Docker Swarm
[Docker Swarm](https://docs.docker.com/engine/swarm/) 
jest rozwiązaniem orkiestracji kontenerami od twórców samego Docker'a. 
Proste w konfiguracji, nie oferuje tak dużych możliwości jak niżej wymienione.

### Mesos

- [Apache Mesos](http://mesos.apache.org/) zaawansowane narzędzie orkiestracji 
  kontenerami.
- [An Introduction to Mesosphere](https://www.digitalocean.com/community/tutorials/an-introduction-to-mesosphere)

### Nomad
[HasiCorp Nomad vs Kubernetes](https://www.nomadproject.io/intro/vs/kubernetes.html)

## Alternatywy Dockera

- [rkt vs other projects](https://coreos.com/rkt/docs/latest/rkt-vs-other-projects.html)
- [Linux Containers](https://linuxcontainers.org/) od Canonical