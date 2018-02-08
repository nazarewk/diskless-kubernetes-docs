\appendix

# Wykaz odnośników
\theendnotes

# Wykaz skryptów

## repozytorium kubernetes-cluster

`kubernetes-cluster` (`https://github.com/nazarewk/kubernetes-cluster`)
jest repozytorium Git, które zawiera kompletny kod źródłowy wykorzystywany w tej
pracy inżynierskiej.

Kod można znaleźć i uruchomić w sieci uczelnianej z katalogu
`/pub/Linux/CoreOS/zetis/kubernetes/kubernetes-cluster/` na maszynie `ldap`.

#### bin/pull
Pobiera aktualną wersję repozytorium wraz z najnowszą wersją
zależności:

```{.bash include=kubernetes-cluster/bin/pull}
```

#### bin/vars
Zawiera wspólne zmienne środowiskowe wykorzystywane w reszcie
skryptów oraz linii komend:

```{.bash include=kubernetes-cluster/bin/vars}
```


#### bin/ensure-virtualenv

Konfiguruje środowisko Pythona, włącznie z próbą
instalacji brakującego `virtualenv` przez `apt`:

```{.bash include=kubernetes-cluster/bin/ensure-virtualenv}
```


#### bin/ensure-configuration
Generuje brakujące pliki konfiguracyjne SSH, 
`inventory.cfg` i `group_vars/all.yml` nie nadpisując istniejących:

```{.bash include=kubernetes-cluster/bin/ensure-configuration}
```


#### bin/render-coreos
Generuje konfigurację Ignition (JSON) na podstawie 
Container Linux Config (YAML):

```{.bash include=kubernetes-cluster/bin/render-coreos}
```


#### bin/setup-cluster
Właściwy skrypt konfigurujący klaster na działających
maszynach CoreOS:
```{.bash include=kubernetes-cluster/bin/setup-cluster}
```

#### bin/setup-cluster-full
Skrót do pobierania najnowszej wersji, a następnie
uruchamiania klastra:
```{.bash include=kubernetes-cluster/bin/setup-cluster-full}
```


#### bin/setup-cluster-upgrade
Skrypt analogiczny do `setup-cluster`, ale 
wywołujący `upgrade-cluster.yml` zamiast `cluster.yml`:

```{.bash include=kubernetes-cluster/bin/setup-cluster-upgrade}
```

#### bin/kubectl
Skrót `kubectl` z automatycznym dołączaniem konfiguracji
`kubespray`:

```{.bash include=kubernetes-cluster/bin/kubectl}
```


#### bin/students
Skrypt zarządzający obiektami `k8s` użytkowników, 
czyli studentów:

```{.bash include=kubernetes-cluster/bin/students}
```


#### bin/student-tokens
Listuje przepustki konkretnego użytkownika:

```{.bash include=kubernetes-cluster/bin/student-tokens}
```


#### bin/install-helm
Instaluje menadżer pakietów `Helm`:

```{.bash include=kubernetes-cluster/bin/install-helm}
```

#### zetis/.ssh/kubernetes.conf
Częściowy plik konfiguracyjny SSH do umieszczenia w `~/.ssh/config`:

```{.bash include=kubernetes-cluster/zetis/.ssh/kubernetes.conf}
```


#### zetis/WWW/boot/coreos.ipxe
Skrypt iPXE uruchamiający maszynę z CoreOS:

```{.bash include=kubernetes-cluster/zetis/WWW/boot/coreos.ipxe}
```


#### zetis/WWW/boot/coreos.yml
Plik konfiguracyjny Container Linux Config w formacie YAML,
docelowo do przepuszczenia przez narzędzie `ct`. Wyjątkowo skróciłem ten skrypt,
ze względu na długość kluczy SSH:

```yaml
passwd:
  users:
  - name: admin
    groups: [sudo, docker]
    ssh_authorized_keys:
    - ssh-rsa <klucz RSA> ato@volt.iem.pw.edu.pl
    - ssh-rsa <klucz RSA> nazarewk
    - ssh-rsa <klucz RSA> nazarewk@ldap.iem.pw.edu.pl

```

#### zetis/WWW/boot/coreos.ign
Z powyższego pliku wygenerowany zostaje (również skrócony) plik JSON:
```json
{
  "ignition": {
    "config": {},
    "timeouts": {},
    "version": "2.1.0"
  },
  "networkd": {},
  "passwd": {
    "users": [
      {
        "groups": [
          "sudo",
          "docker"
        ],
        "name": "admin",
        "sshAuthorizedKeys": [
          "ssh-rsa <klucz RSA> nazarewk",
          "ssh-rsa <klucz RSA> nazarewk@ldap.iem.pw.edu.pl",
          "ssh-rsa <klucz RSA> ato@volt.iem.pw.edu.pl"
        ]
      }
    ]
  },
  "storage": {},
  "systemd": {}
}
```

## repozytorium ipxe-boot
`ipxe-boot` (`https://github.com/nazarewk/ipxe-boot`) jest repozytorium kodu
umożliwiającego uruchomienie środowiska bezdyskowego poza uczelnią.

Repozytorium nie zostało wykorzystane w finalnej konfiguracji, więc nie będę
opisywał jego zawartości.
