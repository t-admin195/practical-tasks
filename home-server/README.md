# home-server

a simple mini-project to set up a basic home linux server with user management, backu and nginx

## Structure

home-server/
├── backup/
│ ├── backup.conf
│ └── backup.sh
├── config/
│ ├── iptables.rules
│ └── nginx.conf
├── users/
│ 
└── README.md + setup.sh

##Usage

###Create user:

```bash
sudo ./users/usermanager.sh
```

###Backup:

- edit backup/backup.conf

then run:

```bash
./backup/backup.sh
```
### Apply configs:

sudo ./setup.sh


