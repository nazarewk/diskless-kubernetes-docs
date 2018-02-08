
# Rezultaty i wnioski

Główne założenia pracy inżynierskiej zostały spełnione. Wyjaśniłem dużą ilość
zagadnień związanych z `k8s` oraz oddałem do użytku skrypty konfigurujące
klaster `k8s` wraz z prostym w obsłudze dodawaniem i usuwaniem jego
użytkowników.

W trakcie pisania pracy temat okazał się zbyt obszerny, żeby go kompletnie i
wyczerpująco opisać w pracy inżynierskiej. W związku z tym musiałem wybrać
tylko najważniejsze informacje i przekazać je w możliwie najkrótszej formie.

Projekt jest bardzo aktywnie rozwijany, więc wiele informacji wyszło na jaw
w końcowych etapach pisania pracy. W samej pracy pojawiły się jedynie
wzmianki o nich bez dogłębnej analizy.

Nie udało mi się przeprowadzić testów wydajnościowych klastra ze względu na
brak czasu.


## Lista alternatyw Kubernetes

`Kubernetes` oferuje duże możliwości w stosunku do progu wejścia w system, ale
istnieją również inne rozwiązania, o których warto wspomnieć.

##### Fleet
jest nakładką na `systemd` realizującą rozproszony system inicjalizacji
systemów operacyjnych `CoreOS`. Kontenery są uruchamiane i zarządzane przez
`systemd`, a stan przechowywany jest w `etcd`.

Aktualnie projekt kończy swój żywot na rzecz `k8s` i w dniu 1 lutego 2018,
został wycofany z domyślnej dystrybucji `CoreOS`. Nadal będzie dostępny w
rejestrze pakietów `CoreOS`.

##### Docker Swarm
jest rozwiązaniem zarządzania kontenerami zintegrowanym z systemem `Docker`.
Główną zaletą jest niski próg wejścia i prostota, a wadą są małe
możliwości w stosunku do innych rozwiązań.

##### Nomad
jest narzędziem do zarządzania siecią komputerową, które również oferuje zarządzanie
kontenerami.

Przy jego tworzeniu twórcy kierują się filozofią `Unix`. W związku z tym `Nomad`
jest prosty w obsłudze, wyspecjalizowany i rozszerzalny. Zwykle działa w
tandemie z innymi produktami firmy "HashiCorp" jak `Consul` i `Vault`.

##### Mesos
jest najbardziej zaawansowanym i najefektywniej skalującym się rozwiązaniem
zarządzania kontenerami.
Jest również najbardziej skomplikowanym i trudnym w zarządzaniu rozwiązaniem.
W związku z tym znajduje swoje zastosowanie tylko w największych sieciach
komputerowych o zasięgu globalnym.