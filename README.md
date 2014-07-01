Playground for Vagrant & SaltStack & Docker
===========================================

Just a personal playground for a unified dev/prod env & deployment scripts. Later, here will come a Docker orchestrator and a sample application. Maybe.

This installation has 2 Vagrant VMs named "master" and "minion". Master is the primary VM and can be used as `vagrant ssh` without name specification.

Master VM is also a minion to itself (minion0), so it can be configured as a normal salted machine.

Bootstrap script is prefetched, since fetching causes problems sometimes, and provisioning fails (partially downloaded script).

To start:

```sh-session
$ git clone https://github.com/nolar/vagrant-saltstack-docker-sample.git
$ cd vagrant-saltstack-docker-sample
$ vagrant up
```

Wait approx 8-10 mins while bootstraping & provisioning is going. If needed, retry:

```sh-session
$ vagrant provision

# OR

$ vagrant provision master
$ vagrant provision minion
```

There is a ./vsalt shortcut script - it calls salt on a master VM transparently, so you do not need to install salt on your dev machine.

```sh-session
$ ./vsalt '*' test.ping
master:
    True
minion:
    True
Connection to 127.0.0.1 closed.
```

Run highstate when needed (e.g., when states/pillar has changed). This step is included in bootstraping.

```sh-session
$ ./vsalt '*' state.highstate
```

Check that both nodes have nginx installed:

* http://192.168.3.100/ - master
* http://192.168.3.101/ - minion

To dive inside the VMs (note, master has no docker):

```sh-session
$ vagrant ssh # (master is implied as primary vm)
$ exit

$ vagrant ssh master
$ sudo salt-call --grains
$ exit

$ vagrant ssh minion
$ sudo salt-call --grains
$ docker images
$ docker ps -a
$ docker attach timer_cont #NB: CtrlC kills the container
$ exit
```


TODO
====

* Re-provisioning hangs on stop/start salt-master. Probably a bug in saltstack/bootstrap/initctl/etc.
* Try docker provider to save some memory (causes a lot of issues if just switched).
