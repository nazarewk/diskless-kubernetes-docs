\appendix

# Wykaz skryptów

## ipxe-boot
[_ipxe-boot_](https://github.com/nazarewk/ipxe-boot) jest stworzonym przeze mnie
na potrzeby pracy repozytorium git skryptów pozwalających na bezdyskowe
uruchamianie maszyn poza siecią uczelnianą.

Nie zostały one wykorzystane w końcowej formie pracy inżynierskiej, więc nie
będę ich bezpośrednio wymieniał.


## kubernetes-cluster

[_kubernetes-cluster_](https://github.com/nazarewk/kubernetes-cluster)
jest repozytorium Git, które zawiera kompletny kod źródłowy wykorzystywany w tej
pracy inżynierskiej i umieszczony w katalogu
_/pub/Linux/CoreOS/zetis/kubernetes/kubernetes-cluster/_ sieci uczelnianej.

\newpage
#### _bin/pull_
Pobiera aktualną wersję repozytorium wraz z najnowszą wersją
zależności:

```{.bash include=kubernetes-cluster/bin/pull}
```

#### _bin/vars_
Zawiera wspólne zmienne środowiskowe wykorzystywane w reszcie
skryptów oraz linii komend:

```{.bash include=kubernetes-cluster/bin/vars}
```

\newpage
#### _bin/ensure-virtualenv_

Konfiguruje środowisko Pythona, włącznie z próbą
instalacji brakującego _virtualenv_ przez _apt_:

```{.bash include=kubernetes-cluster/bin/ensure-virtualenv}
```

\newpage
#### _bin/ensure-configuration_
Generuje brakujące pliki konfiguracyjne SSH, 
_inventory.cfg_ i _group_vars/all.yml_ nie nadpisując istniejących:

```{.bash include=kubernetes-cluster/bin/ensure-configuration}
```

\newpage
#### _bin/render-coreos_ 
Generuje konfigurację Ignition (JSON) na podstawie 
Container Linux Config (YAML):

```{.bash include=kubernetes-cluster/bin/render-coreos}
```

\newpage
#### _bin/setup-cluster_
Właściwy skrypt konfigurujący klaster na działających
maszynach CoreOS:
```{.bash include=kubernetes-cluster/bin/setup-cluster}
```

#### _bin/setup-cluster-full_
Skrót do pobierania najnowszej wersji, a następnie
uruchamiania klastra:
```{.bash include=kubernetes-cluster/bin/setup-cluster-full}
```

\newpage
#### _bin/setup-cluster-upgrade_
Skrypt analogiczny do _setup-cluster_, ale 
wywołujący _upgrade-cluster.yml_ zamiast _cluster.yml_:

```{.bash include=kubernetes-cluster/bin/setup-cluster-upgrade}
```

#### _bin/kubectl_
Skrót _kubectl_ z automatycznym dołączaniem konfiguracji
_kubespray_:

```{.bash include=kubernetes-cluster/bin/kubectl}
```

\newpage
#### _bin/students_
Skrypt zarządzający obiektami _Kubernetes_ użytkowników, 
czyli studentów:

```{.bash include=kubernetes-cluster/bin/students}
```

\newpage
#### _bin/student-tokens_
Listuje przepustki konkretnego użytkownika:

```{.bash include=kubernetes-cluster/bin/student-tokens}
```

\newpage
#### _bin/install-helm_
Instaluje menadżer pakietów _Helm_:

```{.bash include=kubernetes-cluster/bin/install-helm}
```

#### _zetis/.ssh/kubernetes.conf_
Częściowy plik konfiguracyjny SSH do umieszczenia w _~/.ssh/config_:

```{.bash include=kubernetes-cluster/zetis/.ssh/kubernetes.conf}
```

\newpage
#### _zetis/WWW/boot/coreos.ipxe_
Skrypt iPXE uruchamiający maszynę z CoreOS:

```{.bash include=kubernetes-cluster/zetis/WWW/boot/coreos.ipxe}
```

\newpage
#### _zetis/WWW/boot/coreos.yml_
Plik konfiguracyjny Container Linux Config w formacie YAML,
docelowo do przepuszczenia przez narzędzie _ct_. Wyjątkowo skróciłem ten skrypt,
ze względu na długość kluczy SSH:

```yaml
passwd:
  users:
  - name: admin
    groups: [sudo, docker]
    ssh_authorized_keys:
    - ssh-rsa AAAAB3N...dAYs7Y6L8= ato@volt.iem.pw.edu.pl
    - ssh-rsa AAAAB3N...N9aLYp0ct/ nazarewk
    - ssh-rsa AAAAB3N...XRjw== nazarewk@ldap.iem.pw.edu.pl

```

#### _zetis/WWW/boot/coreos.ign_
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
          "ssh-rsa AAAAB3N...N9aLYp0ct/ nazarewk",
          "ssh-rsa AAAAB3N...XRjw== nazarewk@ldap.iem.pw.edu.pl",
          "ssh-rsa AAAAB3N...dAYs7Y6L8= ato@volt.iem.pw.edu.pl"
        ]
      }
    ]
  },
  "storage": {},
  "systemd": {}
}

```