# Przegląd pojęć i systemów związanych z konteneryzacją

Wiodącym, ale nie jedynym, rozwiązaniem konteneryzacji jest _Docker_.

## Open Container Initiative

[_Open Container Initiative_](https://www.opencontainers.org/about) jest 
inicjatywą tworzenia i utrzymywania publicznych standardów związanych z 
tworzeniem i obsługą kontenerów.

Większość projektów związanych z konteneryzacją dąży do kompatybilności 
ze standardami _OCI_, m. in.:

- [_Docker_](https://blog.docker.com/2017/07/demystifying-open-container-initiative-oci-specifications/)
- [_Kubernetes_ CRI-O](https://github.com/kubernetes-incubator/cri-o)
- [_Docker on FreeBSD_](https://wiki.freebsd.org/Docker)
- [_Running CloudABI applications on a FreeBSD based Kubernetes cluster, by Ed Schouten (EuroBSDcon '17)_](https://www.youtube.com/watch?v=akLa9L5O0NY)


## _Docker_

_Docker_ jest najstarszym i w związku z tym aktualnie najpopularniejszym
rozwiązaniem problemu konteneryzacji.

Dobrym przeglądem alternatyw dla _Dockera_ jest [porównianie _rkt_
z innymi rozwiązaniami](https://coreos.com/rkt/docs/latest/rkt-vs-other-projects.html)
na oficjalnej stronie _CoreOS_.

Domyślnie obrazy są pobierane przez internet z [_Docker Huba_](https://hub.docker.com/),
co jest ograniczone przepustowością łącza.
Na wolne łącze możemy zaradzić kieszeniując zapytania HTTP ub
uruchamiając [rejestr obrazów](https://docs.docker.com/registry/deploying/) w
sieci lokalnej.
Lokalny rejestr może być ograniczony do obrazów ręcznie w nim umieszczonych lub
udostępniać i kieszeniować obrazy z zewnętrznego rejestru (np. _Docker Hub_).
Pierwsze rozwiązanie w połączeniu z zablokowaniem dostępu do zewnętrznych
rejestrów daje prawie pełną kontrolę nad obrazami uruchamianymi wewnątrz sieci.


## Dostępne rozwiązania zarządzania kontenerami

### _Kubernetes_

[_Kubernetes_](https://kubernetes.io/) (w skrócie _k8s_) jest obecnie
najpopularniejszym narzędziem orkiestracji kontenerami, a przez to tematem 
przewodnim tego dokumentu.

Został stworzony przez _Google_ na bazie ich wewnętrznego systemu Borg.

W porównaniu do innych narzędzi _Kubernetes_ oferuje najlepszy kompromis między
oferowanymi możliwościami, a kosztem zarządzania.

Dobrym przeglądem alternatyw _Kubernetes_ jest artykuł pt.
[_Choosing the Right Containerization and Cluster Management Tool_](https://dzone.com/articles/choosing-the-right-containerization-and-cluster-management-tool).

### _Fleet_
[_Fleet_](https://github.com/coreos/fleet)
jest nakładką na [_systemd_](https://www.freedesktop.org/wiki/Software/systemd/) 
realizująca rozproszony system inicjalizacji systemów w systemie operacyjnym
_CoreOS_.

Kontenery są uruchamiane i zarządzane przez _systemd_, a stan przechowywany jest w
etcd.

Aktualnie projekt kończy swój żywot na rzecz _Kubernetes_ i w dniu 1 lutego 2018,
został wycofany z domyślnej dystrybucji _CoreOS_. Nadal będzie dostępny w
rejestrze pakietów _CoreOS_.

### _Docker Swarm_
[_Docker Swarm_](https://docs.docker.com/engine/swarm/) 
jest rozwiązaniem orkiestracji kontenerami od twórców samego _Dockera_. 
Proste w obsłudze, ale nie oferuje tak dużych możliwości jak inne rozwiązania.

### _Nomad_

[_Nomad_](https://www.nomadproject.io/intro/index.html) od _HashiCorp_ jest
narzędziem do zarządzania klastrem, które również oferuje zarządzanie
kontenerami.

Przy jego tworzeniu twórcy kierują się filozofią _Unix_. W związku z tym Nomad
jest prosty w obsłudze, wyspecjalizowany i rozszerzalny. Zwykle działa w
tandemie z innymi produktami HashiCorp jak Consul i Vault.

Porównanie z innymi rozwiązaniami możemy znaleźć na oficjalnej stronie _Nomada_:
[_HashiCorp Nomad vs Other Software_](https://www.nomadproject.io/intro/vs/index.html)

### _Mesos_

[_Apache Mesos_](http://mesos.apache.org/) jest najbardziej zaawansowanym i
najlepiej skalującym się rozwiązaniem orkiestracji kontenerami.
Jest również najbardziej skomplikowanym i trudnym w zarządzaniu rozwiązaniem,
w związku z tym znajduje swoje zastosowanie tylko w największych systemach
komputerowych.

Dobrym wstępem do zagadnienia jest ten artykuł:
[_An Introduction to Mesosphere_](https://www.digitalocean.com/community/tutorials/an-introduction-to-mesosphere).
