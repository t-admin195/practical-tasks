# ftp-docker-server

simple FTP server in Docker for file transfer.

## usage

1. run server:  
   `docker-compose up -d`

2. connect via FTP client:
   host: 127.0.0.1
   port: 21
   user: user
   password: 12345

3. files upload/download saved in local `ftpdata` folder.

4. stop server:
   `docker-compose down`

