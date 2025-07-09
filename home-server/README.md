# home-server

a simple mini-project to set up a basic home linux server with user management, backups, nginx configuration, and update automation

## Structure

```bash
home-server
├── backup
│   ├── backup.conf
│   └── backup.sh
├── config
│   ├── iptables.rules
│   └── nginx.conf
├── README.md
├── setup.sh
├── system-updater
│   ├── README.md
│   └── system-updater.sh
└── users
    └── usermanager.sh
```

## Usage

- create user:

```bash
sudo ./users/usermanager.sh
```
## Backup:

- edit backup/backup.conf

then run:

```bash
./backup/backup.sh
```
## Apply configs:

sudo ./setup.sh

## System-update

```bash
sudo ./system-update.sh
```

**important**: most scripts are run as su (superuser).
