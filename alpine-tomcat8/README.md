# alpine-tomcat8
[![](https://imagelayers.io/badge/eviles/alpine-tomcat8:latest.svg)](https://imagelayers.io/?images=eviles/alpine-tomcat8:latest 'Get your own badge on imagelayers.io')

## Hot to use

Quickstart

	docker run -d -p 8080:8080 eviles/alpine-tomcat8
	
Mount data volume
	
	docker run -d -p 8080:8080 -v somedir:/usr/local/tomcat/webapps eviles/alpine-tomcat8
