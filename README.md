Playground for Vagrant & SaltStack & Docker
===========================================

Just a personal playground for a unified dev/prod env & deployment scripts. Later, here will come a Docker orchestrator.

This installation has 2 Vagrant VMs names "master" and "minion". Master is the primary and can be `vagrant ssh` without name specification.

Master VM also has its own minion (minion0), so it can be configured as a normal salted machine.

Bootstrap script is downloaded, since it causes problems when fetched (partically downloaded, thus bootstraping errors).

To start:

```ShellSession
$ git clone https://github.com/nolar/vagrant-saltstack-docker-sample.git
$ cd vagrant-saltstack-docker-sample
$ vagrant up
```

Wait approx 8-10 mins while provisioning is going. If needed, retry:

```ShellSession
$ vagrant provision

# OR

$ vagrant provision master
$ vagrant provision minion1
```

Manual salting via master VM:

```ShellSession
$ ./vsalt '*' test.ping
master:
    True
minion:
    True
Connection to 127.0.0.1 closed.
```

To dive inside:

```ShellSession
$ vagrant ssh minion
```


TODO
====

* Add docker containers.
* Move files around for a beautiful layout.
* Re-provisioning hangs on stop/start salt-master. Probably a bug in salt/initctl/etc.
* Try docker provider to save some memory.
