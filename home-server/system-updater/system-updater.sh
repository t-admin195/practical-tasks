#!/bin/bash


# === Check if the script is beig run as root (uid 0) ===
# === If not, display a message and exit ===
if [ "$UID" -ne 0 ]; then
  echo "This script must be run with administrator rights"
  exit 1
fi


# ===Variables=== 
log_path=/var/log/system-updater/
log_file=/var/log/system-updater/log_$(date +"%Y-%m-%d_%H-%M-%S").txt
release_file=/etc/os-release 


# ===Creates the logs directory if it doesn't exist===
mkdir -p "$log_path"


# ===Log all output (stdout and stderr) to both screen and log file
exec > >(tee -a "$log_file") 2>&1


# ===Simulate a simple loading animation by printin dots===
repeat() {
  local dots=("." ".." "...")
  for i in {1..3}; do
    for d in "${dots[@]}"; do
      echo "$d"
      sleep 0.3
    done
  done 

  echo "Completed!"
}



# ===Asks whether to keep or delete the log file===
log_save() { 
    while true; do
    echo "Do you want to save logs? Y/n"
    read userinputlogs
    if [[ "$userinputlogs" = Y ]] || [[ "$userinputlogs" = y ]]; then
      repeat
      break
    elif [[ "$userinputlogs" = N ]] || [[ "$userinputlogs" = n ]]; then
      rm "$log_file"
      repeat
      break
    else 
      echo "Wrong input, please try again."
  fi
  done
  echo "Completed!"  
}


# ===Check whether the latest command was successful===
check_exit_status() {
  if [ $? -ne 0 ]; then
    echo "An error occurred. See $log_file"  
    return 1
  fi  
}


# ===Just a display of "Please wait" message=== 
please_wait() {
  echo "Please wait..."
}


# ===Functions to log info and error messages with timestamps to both log file and console===


log_info() {
  echo "[$(date +"%Y-%m-%d_%H-%M-%S")] [INFO] $1" | tee -a "$log_file"
} 

log_error() {
  echo "[$(date +"%Y-%m-%d_%H-%M-%S")] [ERROR] $1" | tee -a "$log_file"
}


run_neofetch() {
  if [ -f /usr/bin/neofetch ]; then
    log_info "Neofetch already installed"
    neofetch
  else
    log_info "Install neofetch"
      if grep -q "Arch" "$release_file"; then
        pacman -S neofetch --noconfirm
        check_exit_status   
      elif grep -q "Ubuntu" "$release_file" || grep -q "Debian" "$release_file"; then
        apt-get update
        check_exit_status
        apt-get install -y neofetch
        check_exit_status
      else
        log_error "Unsupported OS for neofetch install"
        return 1
      fi

      log_info "Starting Neofetch"
      neofetch
      check_exit_status


      log_save
  fi 
}

# ===ASCII logo===
clear  
echo "Hi $HOSTNAME! Welcome to"
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


# ===Shows a menu and waits for user input===
echo "Choose an option"
cat << "EOF" 
1.Update the system
2.Open the latest log
3.Show the logs directory
4.Delete all logs
5.Exit
EOF
while true; do
  read -p "Enter:..." userinput

  
# ===Updates the system and logs the output + install and start Neofetch===


# ==Arch==
  if [ "$userinput" = "1" ]; then
    if grep -q "Arch" "$release_file"; then
      please_wait
      log_info "Starting system update..."
      pacman -Syu
      check_exit_status
      please_wait
      run_neofetch
      
# ==Ubuntu==
    elif grep -q "Ubuntu" "$release_file" || grep -q "Debian" "$release_file"; then
      please_wait
      log_info "Starting system update..."
      apt-get update 
      check_exit_status
      log_info "Running dist-upgrade"
      apt-get dist-upgrade -y
      check_exit_status
      please_wait
      run_neofetch 
      
    else
        log_error "ERROR! Unsupported os" 
        echo "ERROR! Unsupported os"
    fi
   
  
# ===Displays the latest log file===
  elif [ "$userinput" = "2" ]; then
    shopt -s nullglob
    logs=(/var/log/system-updater/log_*.txt)
    if (( ${#logs[@]} == 0 )); then
      echo "There aren't any logs here. ¯\_(ツ)_/¯"
    else
      cat "$(ls -t /var/log/system-updater/log_*.txt | head -n 1)"
    fi

      
# ===Displays the path to the logs directory===
  elif [ "$userinput" = "3" ]; then
      echo "Logs are located at: $log_path"
 

  elif [ "$userinput" = "4" ]; then 
    read -p "Are you sure you want to delete all logs? Y/n" userinputlogs1
    if [[ "$userinputlogs1" = Y ]] || [[ "$userinputlogs1" = y ]]; then
      repeat
      rm -rf "${log_path}"*
    elif [[ "$userinputlogs1" = N ]] || [[ "$userinputlogs1" = n ]]; then
      echo "Abort"
    else
      echo "Abort."
    fi
  elif [ "$userinput" = "5" ]; then
  echo "Bye!"
  exit 0

  else
  echo "Wrong input"
  fi 
done
