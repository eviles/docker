# alpine-httpd
[![](https://imagelayers.io/badge/eviles/alpine-httpd:latest.svg)](https://imagelayers.io/?images=eviles/alpine-httpd:latest 'Get your own badge on imagelayers.io')

## Hot to use

Quickstart

	docker run -d -p 80:80 eviles/alpine-httpd
	
Mount data volume
	
	docker run -d -p 80:80 -v somedir:/var/www/localhost/htdocs eviles/alpine-httpd
