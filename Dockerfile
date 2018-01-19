FROM nazarewk/pandoc
RUN yaourt -S --noconfirm pandoc-include-code-bin \
 && sudo paccache -rk 0 \
 && sudo rm -Rf /tmp/yaourt-tmp-arch