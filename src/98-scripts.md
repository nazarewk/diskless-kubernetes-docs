
# Wykaz skryptów

## kubernetes-cluster

\newpage
### `bin/pull`
Pobiera aktualną wersję repozytorium wraz z najnowszą wersją
zależności:

```{.bash include=kubernetes-cluster/bin/pull}
```

\newpage
### `bin/vars`
Zawiera wspólne zmienne środowiskowe wykorzystywane w reszcie
skryptów oraz linii komend:

```{.bash include=kubernetes-cluster/bin/vars}
```

\newpage
### `bin/ensure-virtualenv`

Konfiguruje środowisko Pythona, włącznie z próbą
instalacji brakującego `virtualenv` przez `apt`:

```{.bash include=kubernetes-cluster/bin/ensure-virtualenv}
```

\newpage
### `bin/ensure-configuration`
Generuje brakujące pliki konfiguracyjne SSH, 
`inventory.cfg` i `group_vars/all.yml` nie nadpisując istniejących:

```{.bash include=kubernetes-cluster/bin/ensure-configuration}
```

\newpage
### `bin/render-coreos` 
Generuje konfigurację Ignition (JSON) na podstawie 
Container Linux Config (YAML):

```{.bash include=kubernetes-cluster/bin/render-coreos}
```

\newpage
### `bin/setup-cluster`
Właściwy skrypt konfigurujący klaster na działających
maszynach CoreOS:
```{.bash include=kubernetes-cluster/bin/setup-cluster}
```

\newpage
### `bin/setup-cluster-full`
Skrót do pobierania najnowszej wersji, a następnie
uruchamiania klastra:
```{.bash include=kubernetes-cluster/bin/setup-cluster-full}
```

\newpage
### `bin/setup-cluster-upgrade`
Skrypt analogiczny do `setup-cluster`, ale 
wywołujący `upgrade-cluster.yml` zamiast `cluster.yml`:

```{.bash include=kubernetes-cluster/bin/setup-cluster-upgrade}
```

\newpage
### `bin/kubectl`
Skrót `kubectl` z automatycznym dołączaniem konfiguracji
`kubespray`:

```{.bash include=kubernetes-cluster/bin/kubectl}
```

\newpage
### `bin/students`
Skrypt zarządzający obiektami Kubernetes użytkowników, 
czyli studentów:

```{.bash include=kubernetes-cluster/bin/students}
```

\newpage
### `bin/student-tokens`
Listuje przepustki konkretnego użytkownika:

```{.bash include=kubernetes-cluster/bin/student-tokens}
```

\newpage
### `zetis/.ssh/kubernetes.conf`
Częściowy plik konfiguracyjny SSH do umieszczenia w `~/.ssh/config`:

```{.bash include=kubernetes-cluster/zetis/.ssh/kubernetes.conf}
```

\newpage
### `zetis/WWW/boot/coreos.ipxe`
Skrypt iPXE uruchamiający maszynę z CoreOS:

```{.bash include=kubernetes-cluster/zetis/WWW/boot/coreos.ipxe}
```

\newpage
### `zetis/WWW/boot/coreos.yml`
Plik konfiguracyjny Container Linux Config w formacie YAML,
docelowo do przepuszczenia przez narzędzie `ct`:

```{.bash include=kubernetes-cluster/zetis/WWW/boot/coreos.yml}
```