# simple-http-server

simple example of running a local HTTP server with python.

## files

- `index.html` – simple HTML page with `<h1>Hello, HTTP!</h1>`

## usage

1. make sure python 3 is installed.

2. run the HTTP server in the folder with `index.html` :

   ```bash
   python3 -m http.server 8000
   ```
open your browser at:

http://localhost:8000
OR
http://your_IP:8000

you should see a page displaying "Hello, HTTP!"
to stop the local server, press ctrl + c in the terminal
