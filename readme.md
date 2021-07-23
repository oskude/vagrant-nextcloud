# vagrant-nextcloud

my initial vagrant setup for local [nextcloud](https://nextcloud.com/) development.

- code is in vagrant users home `~/nextcloud`
- apache virtual host runs as vagrant user
- host port 4433 is forwarded to quest port 443
- mysql db:nextcloud user:vagrant pass:vagrant
- provisions are run on every _up_, and update all the things >.<*
- setup user/system files from files, not from strings ;P

## usage

one-time setup:

```
$ git clone https://github.com/oskude/vagrant-nextcloud
$ echo "10.20.30.42 nextcloud.local" | sudo -k tee -a /etc/hosts
```

begin your day:
```
$ cd vagrant-nextcloud
$ vagrant up
$ firefox https://nextcloud.local
```

edit guest files from host:
```
$ cd vagrant-nextcloud
$ vagrant ssh-config > .vagrant.ssh
$ mkdir /tmp/nextcloud
$ sshfs default:nextcloud /tmp/nextcloud -F $PWD/.vagrant.ssh
$ code /tmp/nextcloud
```

unmount /tmp/nextcloud:
```
$ fusermount3 -u /tmp/nextcloud
```

## todo

- setup things for [unit-testing](https://docs.nextcloud.com/server/latest/developer_manual/core/unit-testing.html#running-unit-tests-for-the-nextcloud-core-project)
- setup things for [debugging](https://docs.nextcloud.com/server/latest/developer_manual/getting_started/debugging.html#)
- use https://github.com/goodhosts/vagrant ?
- why can't [pretty urls](https://docs.nextcloud.com//server/stable/admin_manual/installation/source_installation.html#pretty-urls) be simply couple lines in vhost config?
- use custom nextcloud repo?
- is samba faster than sshfs?
- put usage commands in makefile or script(s)
- is php still veeery slow if run from vbox host shared folder?

## tips

- vagrant and vbox spam host users home with critical data (and mine is in ram, and empty on every boot), so a simple workaround to get everything to this dir: `alias vagrant="HOME=$PWD vagrant"`
- lazy pretty follow of nextcloud log in guest: `tail -f ~/nextcloud/data/nextcloud.log | jq`

---

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
