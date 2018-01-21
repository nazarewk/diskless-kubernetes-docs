# Konfiguracja klastra Kubernetes

Najpopularniejszym rozwiązaniem konfiguracji klastra Kubernetes jest 
[kops](https://github.com/kubernetes/kops), ale jak większość rozwiązań zakłada
uruchomienie w środowiskach chmurowych, PaaS lub IaaS. W związku z tym nie ma
żadnego zastosowania w tej pracy inżynierskiej.

## Rancher 2.0 {#rancher-kubernetes}

Wygodne narzędzie do uruchamiania i monitorowania klastra Kubernetes, ale wymaga
interakcji użytkownika.
Wersja 2.0 (obecnie w fazie alpha) oferuje lepszą integrację z Kubernetes
całkowicie porzucając inne platformy.

```bash
#rancher_version=latest
rancher_version=preview
docker run --rm --name rancher -d -p 8080:8080 rancher/server:${rancher_version}
```

Najpierw należy zalogować się do panelu administracyjnego Ranchera i 
przeprowadzić podstawową konfigurację (adres Ranchera + uzyskanie komendy).

Następnie w celu dodania węzła do klastra wystarczy wywołać jedną komendę 
udostępnioną w panelu administracyjnym Ranchera na docelowym węźle, 
jej domyślny format to:
    
```bash
wersja_agenta=v1.2.9
ip_ranchera=192.168.56.1
skrypt=B52944BEFAA613F0CE90:1514678400000:E2yB6KfxzSix4YHti39BTw5RbKw

sudo docker run --rm --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/rancher:/var/lib/rancher \
  rancher/agent:${wersja_agenta} \
  http://${ip_ranchera}:8080/v1/scripts/${skrypt}
```

W ciągu 2 godzin przeglądu nie udało mi się zautomatyzować procesu uzyskiwania
ww. komendy.

Następnie w cloud-config'u RancherOS'a możemy dodać ww. komendę w formie:
```yaml
#cloud-config
runcmd:
- docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.9 http://192.168.56.1:8080/v1/scripts/...
```

Od wersji 2.0 umożliwia połączenie się z istniejącym klastrem:

    kubectl apply -f http://192.168.56.1:8080/v3/scripts/303F60E1A5E186F53F3F:1514678400000:wstQFdHpOgHqKahoYdmsCXEWMW4.yaml


W wersji `v2.0.0-alpha10` losowo pojawia się błąd
[Upgrade Environment](https://github.com/rancher/rancher/issues/10396).

![Błąd pt. Upgrade Environment](assets/rancher2.0-error.png){width=500 height=140}

### Wnioski

Rancher na chwilę obecną (styczeń 2018) jest bardzo wygodnym, ale również
niestabilnym rozwiązaniem.

Ze względu na brak stabilności odrzucam Ranchera jako rozwiązanie problemu
uruchamiania klastra Kubernetes.


## kubespray-cli

Z powodu [błędu](https://github.com/kubespray/kubespray-cli/issues/120)
logiki narzędzie nie radzi sobie z brakiem Python'a na domyślnej dystrybucji 
CoreOS'a, mimo że sam `kubespray` radzi sobie z nim świetnie.
Do uruchomienia na tym systemie potrzebne jest ręczne wywołanie roli 
[`bootstrap-os`](https://github.com/kubernetes-incubator/kubespray/blob/master/roles/bootstrap-os/tasks/main.yml)
z `kubespray` zanim przystąpimy do właściwego deploy'u.

```{.bash include=ipxe-boot/bin/kubernetes-kubespray-cli.sh}
```

Wykrzacza się na kroku czekania na uruchomienie `etcd` ponieważ oczekuje 
połączenia na NATowym interfejsie z adresem `10.0.3.15` zamiast host network
z adresem `192.168.56.10`, stąd `ansible_default_ipv4.address`.

### Wnioski

W trakcie testowania okazało się, że `kubespray-cli` nie jest aktywnie 
rozwiązane i stało się niekompatybilne z samym Kubespray.
W związku z tym uznaję `kubespray-cli` za nie mające zastosowania w tej pracy
inżynierskiej.


## kubespray

Kod znajduje się w moim repozytorium
[kubernetes-cluster](https://github.com/nazarewk/kubernetes-cluster).

```{.bash include=kubernetes-cluster/bin/setup-cluster}
```


### Kubernetes Dashboard
Dostęp do Dashboardu najprościej można uzyskać:

1. [nadanie wszystkich uprawnień roli `kubernetes-dashboard`](https://github.com/kubernetes/dashboard/wiki/Access-control#admin-privileges)
2. Wejście na http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login
3. Kliknięcie skip

```{.bash include=kubernetes-cluster/bin/dashboard}
```

Linki:

- https://github.com/kubernetes/dashboard/wiki/Access-control
- https://github.com/kubernetes-incubator/kubespray/blob/master/docs/getting-started.md#accessing-kubernetes-dashboard


### Napotkane błędy

Błąd przy ustawieniu `loadbalancer_apiserver.address` na `0.0.0.0`:
```
TASK [kubernetes-apps/cluster_roles : Apply workaround to allow all nodes with cert O=system:nodes to register] ************************************
Wednesday 17 January 2018  22:22:59 +0100 (0:00:00.626)       0:08:31.946 *****
fatal: [node2]: FAILED! => {"changed": false, "msg": "error running kubectl (/opt/bin/kubectl apply --force --filename=/etc/kubernetes/node-crb.yml) command (rc=1): Unable to connect to the server: http: server gave HTTP response to HTTPS client\n"}
fatal: [node1]: FAILED! => {"changed": false, "msg": "error running kubectl (/opt/bin/kubectl apply --force --filename=/etc/kubernetes/node-crb.yml) command (rc=1): Unable to connect to the server: http: server gave HTTP response to HTTPS client\n"}
```

## OpenShift Origin

Według [dokumentacji](https://docs.openshift.org/latest/getting_started/administrators.html)
są dwie metody uruchamiania serwera, w Dockerze i na systemie linux.

```bash
# https://docs.openshift.org/latest/getting_started/administrators.html#installation-methods
docker run -d --name "origin" \
  --privileged --pid=host --net=host \
  -v /:/rootfs:ro \
  -v /var/run:/var/run:rw \
  -v /sys:/sys \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -v /var/lib/docker:/var/lib/docker:rw \
  -v /var/lib/origin/openshift.local.volumes:/var/lib/origin/openshift.local.volumes:rslave \
  openshift/origin start --public-master
```

Dodałem opcję `--public-master` aby uruchomić konsolę webową

### Korzystanie ze sterownika systemd zamiast domyślnego cgroupfs

Większość dystrybucji linuxa (np. Arch, CoreOS, Fedora, Debian) domyślnie nie
konfiguruje sterownika cgroup Dockera i korzysta z domyślnego `cgroupfs`.

Typ sterownika cgroup można wyświetlić komendą `docker info`:

    $ docker info | grep -i cgroup                                                                                                                                                                                                                         :(
    Cgroup Driver: systemd

OpenShift natomiast konfiguruje Kubernetes do korzystania z `cgroup` przez 
`systemd`. Kubelet przy starcie weryfikuje zgodność silników cgroup, co
[skutkuje niekompatybilnością z domyślną konfiguracją Dockera](https://github.com/openshift/origin/issues/14766),
czyli poniższym błędem:

    F0120 19:18:58.708005   25376 node.go:269] failed to run Kubelet: failed to create kubelet: misconfiguration: kubelet cgroup driver: "systemd" is different from docker cgroup driver: "cgroupfs"

Problem można rozwiązać dopisując `--exec-opt native.cgroupdriver=systemd` do
linii komend `dockerd` (zwykle w pliku `docker.service`).
Dla przykładu w Arch Linux'ie zmiana wygląda następująco:
    
    $ cp /usr/lib/systemd/system/docker.service /etc/systemd/system/docker.service
    $ vim /etc/systemd/system/docker.service
    $ diff /usr/lib/systemd/system/docker.service /etc/systemd/system/docker.service
    13c13
    < ExecStart=/usr/bin/dockerd -H fd://
    ---
    > ExecStart=/usr/bin/dockerd -H fd:// --exec-opt native.cgroupdriver=systemd

### Próba uruchomienia serwera na Arch Linux

Po wystartowaniu serwera zgodnie z dokumentacją OpenShift Origin i naprawieniu
błędu z konfiguracją cgroup przeszedłem do kolejnego kroku [Try It Out](https://docs.openshift.org/latest/getting_started/administrators.html#try-it-out):

0. Uruchomienie shella na serwerze:
```
$ docker exec -it origin bash
```

1. Logowanie jako testowy użytkownik:
```
$ oc login
Username: test
Password: test
```
2. Stworzenie nowego projektu:
```
$ oc new-project test
```

3. Pobranie aplikacji z Docker Huba:
```
$ oc tag --source=docker openshift/deployment-example:v1 deployment-example:latest
```

4. Wystartowanie aplikacji:
```
$ oc new-app deployment-example:latest
```

5. Odczekanie aż aplikacja się uruchomi:
```
$ watch -n 5 oc status
In project test on server https://192.168.0.87:8443

svc/deployment-example - 172.30.52.184:8080
  dc/deployment-example deploys istag/deployment-example:latest 
    deployment #1 failed 1 minute ago: config change
```


Niestety nie udało mi się przejść kroku 5, więc próba uruchomienia OpenShift
Origin na Arch Linux zakończyła się niepowodzeniem.

### Próba uruchomienia serwera na Fedora Atomic Host w VirtualBox'ie

Maszynę z najnowszym Fedora Atomic Host uruchomiłem za pomocą poniższego
`Vagrantfile`:
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/27-atomic-host"
  config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 8443, host: 18443, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8080, host: 18080, host_ip: "127.0.0.1"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "8192"
  end
  config.vm.provision "shell", inline: <<-SHELL
  SHELL
end
```

```bash
$ vagrant up
$ vagrant ssh
$ sudo docker run -d --name "origin" \
  --privileged --pid=host --net=host \
  -v /:/rootfs:ro \
  -v /var/run:/var/run:rw \
  -v /sys:/sys \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -v /var/lib/docker:/var/lib/docker:rw \
  -v /var/lib/origin/openshift.local.volumes:/var/lib/origin/openshift.local.volumes:rslave \
  openshift/origin start
```

Kroki 0-4 były analogiczne do uruchamiania na Arch Linux, następnie:

5. Odczekanie aż aplikacja się uruchomi i weryfikacja działania:
```bash
$ watch -n 5 oc status
In project test on server https://10.0.2.15:8443

svc/deployment-example - 172.30.221.105:8080
  dc/deployment-example deploys istag/deployment-example:latest 
    deployment #1 deployed 3 seconds ago - 1 pod
$ curl http://172.30.221.105:8080 | grep v1
<div class="box"><h1>v1</h1><h2></h2></div>
```

6. Aktualizacja, przebudowanie i weryfikacja działania aplikacji:
```bash
$ oc tag --source=docker openshift/deployment-example:v2 deployment-example:latest
Tag deployment-example:latest set to openshift/deployment-example:v2.
$ watch -n 5 oc status
In project test on server https://10.0.2.15:8443

svc/deployment-example - 172.30.221.105:8080
  dc/deployment-example deploys istag/deployment-example:latest 
    deployment #2 running for 8 seconds - 1 pod
    deployment #1 deployed 8 minutes ago - 1 pod
$ curl -s http://172.30.221.105:8080 | grep v2
<div class="box"><h1>v2</h1><h2></h2></div>
```

7. Nie udało mi się uzyskać dostępu do panelu administracyjnego OpenShift:
```bash
$ curl -k 'https://localhost:8443/console/'
missing service (service "webconsole" not found)
missing route (service "webconsole" not found)
```


W internecie nie znalazłem żadnych informacji na temat tego błędu.
Próbowałem również uzyskać pomoc na kanale `#openshift` na `irc.freenode.net`:
```
[17:29] <nazarewk> i'm trying to evaluate openshift origin, but when i start server and try to go to https://localhost:8443 i'm getting missing service (service "webconsole" not found)
[17:30] <nazarewk> any ideas how do i get into the console?
[17:40] <meta4knox> In your terminal, type 'oc status' to confirm that https://localhost:8443 is your actual cluster address
[17:41] <nazarewk> meta4knox: i'm getting this https://dpaste.de/7qPu
[17:41] <jbossbot> Title: dpaste
[17:43] <nazarewk> tried all options: curl -k https://172.30.0.1:443/console/ and curl -k https://10.0.2.15:8443/console/
[17:43] <nazarewk> and still getting exactly the same message
[17:44] <meta4knox> did you visit https://10.0.2.15:8443?
[17:44] <meta4knox> ok
[17:45] <meta4knox> Have you previously modified your hosts file such that it could be overriding this request?
[17:45] <nazarewk> nope i'm on fresh fedora atomic host vagrant
[17:46] <meta4knox> hmm
[17:46] <meta4knox> And this worked on other nodes without issue? (i.e. using the same configs?)
[17:47] <nazarewk> well i never managed to get it working
[17:47] <meta4knox> If so, then I'd just blow this one away and start fresh.
[17:47] <nazarewk> i just started researching openshift origin yesterday
[17:47] <meta4knox> OK
[17:47] <nazarewk> tried to run it
[17:47] <nazarewk> got though the try it out without issues on fedora atomic
[17:47] <nazarewk> but can't get to the console
[17:47] <meta4knox> Cloud hosting provider?
[17:48] <nazarewk> nope, i'm on my local machine and running it with vagrant
[17:48] <nazarewk> (i'm researching ways to get the Kubernetes onto bare metal without any extra infrastructure)
[17:49] <nazarewk> already went through Rancher and kubespray without issues
[17:49] <nazarewk> OpenShift looks the most promising but can't get it to work
[17:49] <meta4knox> Sounds like something's not exposed properly. I seem to remember (from long ago) that you need to expose your vm/container to the host in order to access it.
[17:49] <nazarewk> i'm trying from withing VM
[17:50] <meta4knox> Also, if you're trying to get Kube or OpenShift working without much hassle, I strongly recommend looking into Minishift
[17:50] <nazarewk> vagrant ssh -> sudo docker exec -it origin bash
[17:50] <nazarewk> i need it to run multi-host
[17:50] <nazarewk> (in later stages)
[17:50] <meta4knox> gotcha
[17:50] <meta4knox> Sorry I couldn't help
[17:51] <meta4knox> good luck
[17:51] <nazarewk> thanks for trying :)
```


### Wnioski

Panel administracyjny klastra OpenShift Origin jest jedyną znaczącą przewagą
nad Kubespray. Reszta zarządzania klastrem odbywa się również za pomocą
repozytorium skryptów Ansibla ([w tym dodawanie kolejnych węzłów klastra](https://docs.openshift.com/enterprise/3.0/admin_guide/manage_nodes.html#adding-nodes)).

Z powodu braku dostępu do ww. panelu próbę uruchomienia OpenShift Origin
uznaję za nieudaną.