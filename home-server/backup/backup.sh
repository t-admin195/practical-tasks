#!/bin/bash
# load config
source ./dir-backup.conf

ARCHIVE_NAME="backup-$(date +%Y-%m-%d).tar.gz"


echo Do you want to copy the directory you selected? Y/N
read USERINPUT
USERINPUT=$(echo "$USERINPUT" | tr '[:upper:]' '[:lower:]')

if [ ! -d "$BACKUPDIR" ]; then
  mkdir -p "$BACKUPDIR"
fi
# Ensure backup directory exists
if [ "$USERINPUT" = "y" ]; then
  if [ ! -d "$SOURCEDIR" ]; then
  echo "Source directory does not exist: $SOURCEDIR"
  exit 1
fi
# copy and archive
  cp -r "$SOURCEDIR" "$BACKUPDIR"
  tar -czf "$BACKUPDIR/$ARCHIVE_NAME" -C "$BACKUPDIR" "$(basename "$SOURCEDIR")"

  echo "[$(date)] Backup completed and tranferred to remote server..." >> /var/log/backup.log
  echo Copying successful

# transfer to remote server
  echo Transferring a folder to a remote server...

  scp "$BACKUPDIR/$ARCHIVE_NAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
  echo Transferring successful

# cleanup
  echo Deleting the local backup folder...
  rm -rf "$BACKUPDIR"
  echo Deleting successful


elif [ "$USERINPUT" = "n" ]; then
  echo Done
  rm -rf "$BACKUPDIR"
fi
