# Wstęp

W ostatnich latach zyskują na popularności tematy związane z izolacją 
aplikacji, konteneryzacją i zarządzaniem rozproszonymi systemami komputerowymi.

Sam problem izolacji systemów komputerowych jest znany już od dawna i dorobił
się wielu podejść do jego rozwiązania:

- rozwijane od późnych lat 1960 wirtualne maszyny dzielące się na dwa rodzaje:
  - systemowe lub inaczej emulatory maszyn. W uproszczeniu polegają
    na uruchamianiu kompletnego systemu operacyjnego, który nie zdaje sobie
    sprawy ze współdzielenia zasobów "myśląc", że posiada całą fizyczną maszynę
    na własność. Umożliwia uruchomienie całkiem innego systemu operacyjnego
    jako gościa.
    
  - działające na poziomie procesu. Oferują przede wszystkim izolację
    zależności i niezależność od systemu operacyjnego, możemy tu
    wyróżnić między innymi:
    - interpretery (np. CPython lub Lua),
    - kompilatory JIT (np. Jython, PyPy, LuaJIT, .NET),
    - maszyny wirtualne języków programowania (np. Java lub V8),
    
- wprowadzony w roku 1979 `chroot` polegający na uruchomieniu procesu ze
  zmienionym drzewem systemu plików, z którego nie może się wydostać,

- parawirtualizacja, która jest podobna do systemowych wirtualnych maszyn,
  a tą różnicą, że przekierowuje zapytania systemowe do systemu-gospodarza.
  Ten typ wirtualizacji nie pozwala na uruchomienie całkiem innego systemu
  operacyjnego i wymaga kompatybilności systemu-gościa.
  Przykładem jej implementacji są `jail` z FreeBSD lub `lxc` 
  (Linux Containers).


\pagebreak
## Konteneryzacja

Pełna wirtualizacja systemów operacyjnych świetnie sprawdza się przy
współdzieleniu zasobów sprzętowych z niezaufanymi użytkownikami. Na przykład
w centrach danych lub usługach chmurowych.

Natomiast rozwój realnych aplikacji i usług internetowych dąży do izolacji
jak najmniejszych ich części na poziomie pojedynczego procesu.
Niektórzy idą dalej i dalej rozbijają procesy na jeszcze mniejsze jednostki (tzw.
mikroserwisy) ograniczając ich funkcjonalność do minimum.

Zastosowanie w tym przypadku pełnej wirtualizacji skutkowałby
nieproporcjonalnie dużym narzutem zasobów sprzętowych, a przez to finansowych,
w stosunku do uruchamianej aplikacji. Standardowe narzędzia parawirtualizacji
zmniejszają ten narzut, ale nadal jest znaczny i wymaga dalszej optymalizacji.

W ten sposób zrodziła się idea konteneryzacji. Polega ona na:

- uruchamianiu pojedynczych procesów,
- we w pełni skonfigurowanym środowisku niezależnym od innych procesów
  współdzielących system operacyjny,
- dążeniu do minimalizacji kosztów uruchamiania kolejnych procesów,

Warto tu zaznaczyć, że konteneryzacja nie jest jednym narzędziem lub gotowym
rozwiązaniem. Jest natomiast dobrze określonym zbiorem problemów i recept na ich
rozwiązanie.

\pagebreak
Konteneryzację realizuje się łącząc wiele istniejących lub nowych narzędzi
optymalizowanych w konkretnym celu. Sytuację dobrze ilustruje poniższe porównanie LXC
z Dockerem:

![LXC vs Docker](https://robinsystems.com/wp-content/uploads/2017/03/linux-vs-docker-comparison-architecture-docker-lxc.png){width=500 height=320}\

Jak widać na powyższej ilustracji zarówno LXC jak i Docker bazują na kernelu
Linuxa, w tym: SELinux lub Apparmor, namespaces i cgroups.
Różnią się natomiast implementacją samych kontenerów, LXC korzysta jedynie z
`liblxc`, a Docker postanowił zaimplementować wielopoziomowy system:
`Docker Engine`, `containerd` i `runc`.

## Cel pracy inżynierskiej

Celem tej pracy inżynierskiej jest przedstawienie podstawowych pojęć związanych
z aktualnie najpopularniejszym rozwiązaniem zarządzania kontenerami o nazwie
`Kubernetes`. Kolejnym krokiem będzie przegląd dostępnych rozwiązań oraz
wdrożenie tego  systemu w sieci uczelnianej na potrzeby prowadzenia
laboratoriów ze studentami.

Wdrożenie w sieci uczelnianej wiąże się z koniecznością uruchomienia systemu
z sieci na maszynach bezdyskowych.

Celem dodatkowym jest przeprowadzenie testów wydajnościowych klastra Kubernetes.
