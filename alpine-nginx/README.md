# alpine-nginx

## How to Use

### With Certbot

Use DOMAINS to automatic obtain an SSL certificate. It'll take a long time.
``
docker run -d -p 80:80 -p 443:443 -e DOMAINS=example.com eviles/alpine-nginx
``

#### Advanced

Mount configure
``
docker run -d -p 80:80 -p 443:443 -e DOMAINS=example.com -v /somewhere/letsencrypt:/etc/letsencrypt -v /somewhere/nginx:/etc/nginx/conf.d eviles/alpine-nginx
``

### Without Certbot

Just don't use DOMAINS.
``
docker run -d -p 80:80 -p 443:443 eviles/alpine-nginx
``

