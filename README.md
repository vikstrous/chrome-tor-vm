# chrome-tor-vm

This a Vagrant config for a virtual machine with a full-featured chrome installation set up to pass all of its traffic through Tor while protecting your host machine from exploits and allowing you to easily wipe and re-install the virtual machine between sessions. I do not guarantee that your privacy is perfectly protected, but I think it's good enough for me. Let me know if you see any privacy leaks or security issues.

# Usage

```
vagrant up
./run.sh
```

# Between Sessions

Run this between sessions to break any possible association between the previous and next session.

```
vagrant destroy
vagrant up
```
