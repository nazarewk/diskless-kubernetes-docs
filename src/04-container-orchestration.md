# Przegląd systemów orkiestracji kontenerami


## Fleet
[Fleet](https://coreos.com/fleet/docs/latest/launching-containers-fleet.html)
jest nakładką na [systemd](https://www.freedesktop.org/wiki/Software/systemd/) 
realizująca rozproszony system inicjalizacji systemów.
Kontenery są uruchamiane i zarządzane przez systemd.


## Docker Swarm
[Docker Swarm](https://docs.docker.com/engine/swarm/) 
jest rozwiązaniem orkiestracji kontenerami od twórców samego Docker'a. 
Proste w konfiguracji, nie oferuje tak dużych możliwości jak niżej wymienione.


## Kubernetes
[Kubernetes](https://kubernetes.io/) jest jednym z najpopularniejszych narzędzi 
orkiestracji kontenerami. Stworzony przez Google i bazowany na wewnętrznym 
systemie Borg.


## Mesos
[Apache Mesos](http://mesos.apache.org/) zaawansowane narzędzie orkiestracji 
kontenerami. 


## Rancher 
[Rancher](https://rancher.com/) jest platformą zarządzania kontenerami 
umożliwiającą między innymi zarządzanie klastrem Kubernetes.
Od wersji 2.0 twórcy skupiają się na zarządzaniu Kubernetes porzucając
inne silniki.
