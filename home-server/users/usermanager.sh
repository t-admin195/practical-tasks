#!/bin/bash
if [[ "$EUID" -ne 0 ]]; then
  echo "this script must be run as root." >&2
  exit 1
fi

add_user() {
  echo "enter new username:"
  read username

  if id "$username" &>/dev/null; then
    echo "User '$username' already exists."
  else
    useradd "$username"
    passwd "$username"
    echo "User '$username' created."
  fi
}

while true; do
  add_user

  echo "current users:" 
  awk -F: '{print $1}' /etc/passwd

  echo "is that right? Y/N"
  read answer
  answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

  if [[ "$answer" == "y" || "$answer" == "" ]]; then
    echo "completed."
    break
  elif [[ "$answer" == "n" ]]; then
    userdel "$username"
    echo "user removed. retry"
  else    echo "abort."
    break
  fi
done

