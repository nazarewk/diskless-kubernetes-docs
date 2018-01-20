# Kubernetes

https://jvns.ca/categories/kubernetes/

https://github.com/kelseyhightower/kubernetes-the-hard-way

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

4 rodzaje sieci:
1. komunikacja wewnątrz Podów (localhost)
2. komunikacja między Podami (SDN lub tzw. overlay network, np. flannel, Calico)
3. komunikacja między Podami i Serwisami (kube-proxy)
4. komunikacja świata z Serwisami

