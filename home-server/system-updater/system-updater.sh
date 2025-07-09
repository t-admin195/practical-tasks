#!/bin/bash

# check if the script is beig run as root (uid 0)
# if not, display a message and exit
if [ "$UID" != 0 ]; then
  echo "this script must be run with administrator rights"
  exit 1
fi

# create logs directory 
mkdir -p /var/log/system-updater/


logs_path=/var/log/system-updater/
logs_file="/var/log/system-updater/log_$(date +"%Y-%m-%d_%H-%M-%S").txt"
release_file=/etc/os-release


# simulate a simple loading animation by printin dots 
repeat() {
  local dots=("." ".." "...")
  for i in {1..2}; do
    for d in "${dots[@]}"; do
      echo "$d"
      sleep 0.2
    done
  done 
  echo "completed!"
}


# asks whether to keep or delete the log file
log_save() { 
    while true; do
    echo "do you want to save logs? Y/n"
    read userinputlogs
    if [[ $userinputlogs = Y ]] || [[ $userinputlogs = y ]]; then
      repeat
      break
    elif [[ $userinputlogs = N ]] || [[ $userinputlogs = n ]]; then
      rm "$logs_file"
      repeat
      break
    else 
      echo "wrong input, please try again."
  fi
  done
  echo "completed!"  
}


clear  
echo "WELCOME TO"
cat << "EOF"
                _                                       _       _            
               | |                                     | |     | |           
  ___ _   _ ___| |_ ___ _ __ ___ ______ _   _ _ __   __| | __ _| |_ ___ _ __ 
 / __| | | / __| __/ _ \ '_ ` _ \______| | | | '_ \ / _` |/ _` | __/ _ \ '__|
 \__ \ |_| \__ \ ||  __/ | | | | |     | |_| | |_) | (_| | (_| | ||  __/ |   
 |___/\__, |___/\__\___|_| |_| |_|      \__,_| .__/ \__,_|\__,_|\__\___|_|   
       __/ |                                 | |                             
      |___/                                  |_|                             
EOF


# shows a menu and waits for user input
echo "choose an option"
while true; do
  echo "1.update the system \
        2.open the latest log \
        3.show the logs directory \
        4.exit"
  read -p "enter:" userinput

  
# updates the system and logs the output
  if [ "$userinput" = "1" ]; then
    if grep -q "Arch" "$release_file"; then
      sudo pacman -Syu >> "$logs_file" 2>&1
    elif grep -q "Ubuntu" "$release_file" || grep -q "Debian" "$release_file"; then
      sudo apt update -y >> "$logs_file" 2>&1
      sudo apt dist-upgrade -y >> "$logs_file" 2>&1
    else
      echo "unsupported os" >> "$logs_file"
    fi

    if grep -q "Arch" "$release_file"; then
      sudo pacman -S --noconfirm neofetch >> "$logs_file" 2>&1
    else
      sudo apt install -y neofetch
    fi
    neofetch >> "$logs_file" 2>&1
    log_save
    neofetch
  
# displays the latest log file
  elif [ "$userinput" = "2" ]; then
      cat "$(ls -t /var/log/system-updater/log_*.txt | head -n 1)" 
# displays the path to the logs directory 
 elif [ "$userinput" = "3" ]; then
      echo "logs are located at: $logs_path"
    
  elif [ "$userinput" = "4" ]; then
  echo "bye!"
  exit 0

  else
  echo "wrong input"
  fi
done
