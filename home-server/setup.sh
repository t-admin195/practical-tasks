#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
  echo "this script must be run as root." >&2
  exit 1
fi


sudo cp config/nginx.conf /etc/nginx/nginx.conf
sudo cp config/iptables.rules /etc/iptables.rules
sudo iptables-restore < /etc/iptables.rules
sudo systemctl restart nginx

