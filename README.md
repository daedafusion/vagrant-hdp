# vagrant-hdp

HDP Installation via Vagrant

# Setup

```bash
cp Vagrantfile.sample Vagrantfile
vim Vagrantfile # Customize to your needs (esp. CPU & RAM)
vagrant up
vagrant ssh
```

```bash
cd /vagrant
make
```

Open a browser to your vagrant host on port 8080 (recommend setting an alias in your /etc/hosts file).

- Install HDP 2.4
- Target Hosts: hdp
- Host Registration Information: Paste in private key, set username to `ubuntu`
