# alpine-httpd-tomcat
[![](https://imagelayers.io/badge/eviles/alpine-httpd-tomcat:latest.svg)](https://imagelayers.io/?images=eviles/alpine-httpd-tomcat:latest 'Get your own badge on imagelayers.io')

## Information

It will forward .jsp and .do to tomcat and the others use apache2.

## Hot to use

Quickstart

	docker run -d -p 80:80 eviles/alpine-httpd-tomcat
	
Mount data volume
	
	docker run -d -p 80:80 -v somedir:/usr/local/tomcat/webapps -v somedir:/var/www/localhost/htdocs eviles/alpine-httpd-tomcat
