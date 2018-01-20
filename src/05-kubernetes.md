# Kubernetes

Materiały:
- https://jvns.ca/categories/kubernetes/
- https://github.com/kelseyhightower/kubernetes-the-hard-way
- https://www.youtube.com/watch?v=4-pawkiazEg

## Administracja, a korzystanie z klastra

Administracja klastrem polega na jego skonfigurowaniu i dopasowaniu komponentów,
aby umożliwić korzystanie z niego.

Korzystanie z klastra polega na uruchamianiu aplikacji na klastrze.

W pracy inżynierskiej skupiam się przede wszystkim na kwestiach związanych z 
administracja klastrem.

## Architektura

### Składowe kontrolujące klaster
- etcd - przechowywanie stanu klastra
- kube-apiserver - interfejs konfiguracyjny klastra (zarówno wewnętrzny jak i 
  zewnętrzny), prowadzi interakcję tylko ze stanem klastra w etcd
- kube-scheduler - proces decydujący na którym węźle klastra uruhamiać Pody (
  na podstawie dostępnych zasobów, obecnego obciążenia itp.).
  W skrócie zarządza popytem i podażą na zasoby klastra.
- kube-controller-manager - kontroler klastra dążący do doprowadzenia 
  obecnego stanu klastra do pożądanego na podstawie informacji z kube-apiserver

### Składowe workera
- kubelet - monitoruje i kontroluje stan pojedynczego węzła. Na przykład
  restartuje Pod, który przestał działać na tym samym węźle.
- kube-proxy - proxy i load balancer odpowiedzialny za przekierowanie ruchu do
  odpowiedniego kontenera
- cAdvisor - monitoruje zużycie zasobów i wydajność kontenerów w ramach jednego
  węzła

### Komunikacja sieciowa

Materiały:

- https://www.slideshare.net/weaveworks/kubernetes-networking-78049891
- https://jvns.ca/blog/2016/12/22/container-networking/
- `https://medium.com/@anne_e_currie/kubernetes-aws-networking-for-dummies-like-me-b6dedeeb95f3`

Info:

- Kubernetes **zakłada**, że każdy Pod ma swój własny adres IP, ale w żadnym
  stopniu nie zajmuje się konfiguracją i przedziałem adresów IP
- Kubernetes polega na zewnętrznych rozwiązaniach zajmujących się przydzielaniem
  adresów IP

4 rodzaje komunikacji sieciowej:

1. wewnątrz Podów (localhost)
2. między Podami (trasowanie lub nakładka sieciowa - overlay network)
3. między Podami i Serwisami (kube-proxy)
4. świata z Serwisami

W skrócie:

- Kubernetes uruchamia Pody, które implementują Serwisy,
- Pody potrzebują Sieci Podów - trasowanych lub nakładkę sieciową,
- Sieć Podów jest sterowana przez CNI (Container Network Interface),
- Klient łączy się do Serwisów przez wirtualne IP Klastra,
- Kubernetes ma wiele sposobów na wystawienie Serwisów poza klaster,

