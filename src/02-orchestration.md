# Przegląd pojęć i systemów związanych z konteneryzacją

Wiodącym, ale nie jedynym, rozwiązaniem konteneryzacji jest `Docker`.

## Open Container Initiative

[`Open Container Initiative`](https://www.opencontainers.org/about) jest 
inicjatywą tworzenia i utrzymywania publicznych standardów związanych z 
tworzeniem i obsługą kontenerów.

Większość projektów związanych z konteneryzacją dąży do kompatybilności 
ze standardami `OCI`, m. in.:

- [`Docker`](https://blog.docker.com/2017/07/demystifying-open-container-initiative-oci-specifications/)
- [`Kubernetes CRI-O`](https://github.com/kubernetes-incubator/cri-o)
- [`Docker on FreeBSD`](https://wiki.freebsd.org/Docker)
- [`Running CloudABI applications on a FreeBSD based Kubernetes cluster, by Ed Schouten (EuroBSDcon '17)`](https://www.youtube.com/watch?v=akLa9L5O0NY)


## Docker

`Docker` jest najstarszym i w związku z tym aktualnie najpopularniejszym
rozwiązaniem problemu konteneryzacji.

Dobrym przeglądem alternatyw dla `Dockera` jest [porównianie `rkt`
z innymi rozwiązaniami](https://coreos.com/rkt/docs/latest/rkt-vs-other-projects.html)
na oficjalnej stronie `CoreOS`.

Domyślnie obrazy są pobierane przez internet z [`Docker Huba`](https://hub.docker.com/),
co jest ograniczone przepustowością łącza.
Na wolne łącze możemy zaradzić kieszeniując zapytania HTTP ub
uruchamiając [rejestr obrazów](https://docs.docker.com/registry/deploying/) w
sieci lokalnej.
Lokalny rejestr może być ograniczony do obrazów ręcznie w nim umieszczonych lub
udostępniać i kieszeniować obrazy z zewnętrznego rejestru (np. `Docker Hub`).
Pierwsze rozwiązanie w połączeniu z zablokowaniem dostępu do zewnętrznych
rejestrów daje prawie pełną kontrolę nad obrazami uruchamianymi wewnątrz sieci.


## Dostępne rozwiązania zarządzania kontenerami

#### Kubernetes

[Kubernetes](https://kubernetes.io/) (dalej jako `k8s`) jest obecnie
najpopularniejszym narzędziem orkiestracji kontenerami, a przez to tematem 
przewodnim tego dokumentu.

Został stworzony przez `Google` na bazie ich wewnętrznego systemu Borg.

W porównaniu do innych narzędzi `k8s` oferuje najlepszy kompromis między
oferowanymi możliwościami, a kosztem zarządzania.

Dobrym przeglądem alternatyw `k8s` jest artykuł pt.
[`Choosing the Right Containerization and Cluster Management Tool`](https://dzone.com/articles/choosing-the-right-containerization-and-cluster-management-tool).

#### Fleet
[`Fleet`](https://github.com/coreos/fleet)
jest nakładką na [`systemd`](https://www.freedesktop.org/wiki/Software/systemd/) 
realizująca rozproszony system inicjalizacji systemów w systemie operacyjnym
`CoreOS`.

Kontenery są uruchamiane i zarządzane przez `systemd`, a stan przechowywany jest w
etcd.

Aktualnie projekt kończy swój żywot na rzecz `k8s` i w dniu 1 lutego 2018,
został wycofany z domyślnej dystrybucji `CoreOS`. Nadal będzie dostępny w
rejestrze pakietów `CoreOS`.

#### Docker Swarm
[`Docker Swarm`](https://docs.docker.com/engine/swarm/) 
jest rozwiązaniem orkiestracji kontenerami od twórców samego `Dockera`. 
Proste w obsłudze, ale nie oferuje tak dużych możliwości jak inne rozwiązania.

#### Nomad

[`Nomad`](https://www.nomadproject.io/intro/index.html) od `HashiCorp` jest
narzędziem do zarządzania klastrem, które również oferuje zarządzanie
kontenerami.

Przy jego tworzeniu twórcy kierują się filozofią `Unix`. W związku z tym Nomad
jest prosty w obsłudze, wyspecjalizowany i rozszerzalny. Zwykle działa w
tandemie z innymi produktami HashiCorp jak Consul i Vault.

Porównanie z innymi rozwiązaniami możemy znaleźć na oficjalnej stronie `Nomada`:
[`HashiCorp Nomad vs Other Software`](https://www.nomadproject.io/intro/vs/index.html)

#### Mesos

[`Apache Mesos`](http://mesos.apache.org/) jest najbardziej zaawansowanym i
najlepiej skalującym się rozwiązaniem orkiestracji kontenerami.
Jest również najbardziej skomplikowanym i trudnym w zarządzaniu rozwiązaniem,
w związku z tym znajduje swoje zastosowanie tylko w największych systemach
komputerowych.

Dobrym wstępem do zagadnienia jest ten artykuł:
[`An Introduction to Mesosphere`](https://www.digitalocean.com/community/tutorials/an-introduction-to-mesosphere).
