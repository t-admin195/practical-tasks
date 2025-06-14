# dir-backup

simple bash script to create a `.tar.gz` backup of a directory and upload it to a remote server using `scp`.

## tools

- bash – scripting language
- tar – create compressed archive
- scp – send files over SSH

## files

- dir-backup.sh – backup script
- dir-backup.conf – user configuration
- README.md – project description

## usage

edit dir-backup.conf with your paths and server info, then run

```bash
./dir-backup.sh

## 
