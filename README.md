# net-basic

simple echo server and client scripts for basic network practise.

## files

- `server.sh` - start an echo server on port 1234 using `socat` 
- `client.sh` - send a message to the server using `nc`

## usage

1. install `socat` if its not installed yet:

   ```bash
   sudo apt update
   sudo apt install socat
   ```

2. make scripts executable:

   ```bash
   chmod +x server.sh client.sh
   ```

3. run the server in one terminal:

   ```bash
   ./server.sh
   ```

4. run the client in another terminal:

   ```bash
   ./client.sh
   ```

you should see the client message echoed back from server



