# alpine-jenkins
[![](https://imagelayers.io/badge/eviles/alpine-jenkins:latest.svg)](https://imagelayers.io/?images=eviles/alpine-jenkins:latest 'Get your own badge on imagelayers.io')

## Hot to use

Quickstart

	docker run -d -p 8080:8080 -p 50000:50000 eviles/alpine-jenkins
	
Mount data volume
	
	docker run -d -p 8080:8080 -p 50000:50000 -v somedir:/var/jenkins eviles/alpine-jenkins
