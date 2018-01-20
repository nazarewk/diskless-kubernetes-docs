# Przegląd pojęć i systemów związanych z konteneryzacją

W związku z mnogością pojęć związanych z izolacją, konteneryzacją i zarządzaniem
systemami komputerowymi zdecydowałem się w dużym skrócie przybliżyć
najważniejsze pojęcia z tematem związane.

## Konteneryzacja

Konteneryzacja jest sposobem izolacji aplikacji i jej zależności. 
Jest kolejnym krokiem po wirtualnych maszynach w dążeniu do minimalizacji 
kosztów ogólnych izolacji aplikacji.

W związku z działaniem na poziomie procesu w systemie operacyjnym konteneryzacja
umożliwia izolację aplikacji stosunkowo niewielkim kosztem w porównaniu do 
wirtualizacji systemów operacyjnych (libvirt, VirtualBox itp.).

Wiodącym, ale nie jedynym, rozwiązaniem konteneryzacji jest Docker.

### Open Container Initiative

[Open Container Initiative](https://www.opencontainers.org/about) jest 
inicjatywą tworzenia i utrzymywania publicznych standardów związanych z formatem
i uruchamianiem kontenerów.

Większość projektów związanych z konteneryzacją dąży do kompatybilności 
ze standardami OCI, m. in.:
- [Docker](https://blog.docker.com/2017/07/demystifying-open-container-initiative-oci-specifications/)
- [Kubernetes CRI-O](https://github.com/kubernetes-incubator/cri-o)
- [Docker on FreeBSD](https://wiki.freebsd.org/Docker)
- [Running CloudABI applications on a FreeBSD based Kubernetes cluster, by Ed Schouten (EuroBSDcon '17)](https://www.youtube.com/watch?v=akLa9L5O0NY)


### Docker

Docker jest najstarszym i w związku z tym aktualnie najpopularniejszym
rozwiązaniem problemu konteneryzacji.

Dobrym przeglądem alternatyw Dockera jest [porównianie `rkt` (kolejna generacja Dockera)
z innymi rozwiązaniami](https://coreos.com/rkt/docs/latest/rkt-vs-other-projects.html)


## Kubernetes

[Kubernetes](https://kubernetes.io/) jest jednym z najpopularniejszych narzędzi 
orkiestracji kontenerami i jednocześnie tematem przewodnim tego dokumentu. 
Został stworzony przez Google na bazie ich wewnętrznego systemu Borg.

- [Choosing the Right Containerization and Cluster Management Tool](https://dzone.com/articles/choosing-the-right-containerization-and-cluster-management-tool)

### Alternatywne rozwiązania zarządzania kontenerami

#### Fleet
[Fleet](https://github.com/coreos/fleet)
jest nakładką na [systemd](https://www.freedesktop.org/wiki/Software/systemd/) 
realizująca rozproszony system inicjalizacji systemów w systemie operacyjnym
CoreOS

Kontenery są uruchamiane i zarządzane przez systemd, a stan przechowywany jest w
etcd.

Aktualnie projekt kończy swój żywot na rzecz Kubernetesa i w dniu 1 lutego 2018,
zostanie wycofany z domyślnej dystrybucji CoreOS. Nadal będzie dostępny w
rejestrze pakietów CoreOS.

#### Docker Swarm
[Docker Swarm](https://docs.docker.com/engine/swarm/) 
jest rozwiązaniem orkiestracji kontenerami od twórców samego Docker'a. 
Proste w konfiguracji, nie oferuje tak dużych możliwości jak niżej wymienione.

#### Nomad
[HasiCorp Nomad vs Kubernetes](https://www.nomadproject.io/intro/vs/kubernetes.html)

#### Mesos

[Apache Mesos](http://mesos.apache.org/) jest najbardziej zaawansowanym i
najlepiej skalującym się rozwiązaniem orkiestracji kontenerami.
Jest również najbardziej skomplikowanym i trudnym w zarządzaniu rozwiązaniem.

- [An Introduction to Mesosphere](https://www.digitalocean.com/community/tutorials/an-introduction-to-mesosphere)


## Zarządzanie Kubernetes z linii komend
  
### kubeadm

[kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/)
jest narzędziem pozwalającym na niskopoziomowe zarządzanie klastrem Kubernetes.
Stąd trendem jest bazowanie na kubeadm przy tworzeniu narzędzi z wyższym
poziomem abstrakcji.

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

### Canonical Kubernetes distribution

Jest to prosta w instalacji dystrybucja Kubernetes. Niestety wymaga 
infrastruktury chmurowej do uruchomienia klastra składającego się z więcej niż 
jednego węzła. 

Opcja bare-metal, która by mnie interesowała nadal wymaga 
działającego środowiska [Metal as a Service](). 

W związku z powyższym nie będę dalej zajmował się tym narzędziem.

Przydatne materiały:
- Juju Charm [the canonical distribution of kubernetes](https://jujucharms.com/canonical-kubernetes/)
- [Install Kubernetes with conjure-up](https://tutorials.ubuntu.com/tutorial/install-kubernetes-with-conjure-up)
- [Kubernetes the not so easy way](https://insights.ubuntu.com/2017/10/12/kubernetes-the-not-so-easy-way/)
  opisuje instalację lokalnego klastra.


### Eksperymentalne i deprekowane rozwiązania
- [Fedora via Ansible](https://kubernetes.io/docs/getting-started-guides/fedora/fedora_ansible_config/)
  deprekowane na rzecz kubespray
- [Rancher Kubernetes Installer](http://rancher.com/announcing-rke-lightweight-kubernetes-installer/)
  jest eksperymentalnym rozwiązaniem wykorzystywanym w Rancher 2.0,
  
#### kubespray-cli

Jest to narzędzie ułatwiające korzystanie z `kubespray`.
Według użytkowników 
[oficjalnego Slacka kubespray](https://kubernetes.slack.com/messages/kubespray)
`kubespray-cli` jest deprekowane.


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
