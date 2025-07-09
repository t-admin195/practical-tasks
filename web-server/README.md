# nginx-docker-site

nginx and docker practice with a static HTML page.

## tools

- `docker`–build and run containers
- `nginx`–serve static files
- `/etc/hosts`–local domain name mapping

## files

- `dockerfile`–nginx image with static site
- `index.html`–demo web page
- `README.md` –project description

## use

map 127.0.0.1 `mysite.local` in `/etc/hosts`, then visit:

```
http://mysite.local:8080
```

