# build docker image
dock: 
	docker build --rm -t hq.stepshape.com/adm-haproxy .

stop: 
	-docker kill adm.haproxy.1 #@todo change this to "stop" instead
	-docker rm adm.haproxy.1

start: dock stop
	docker run -d --name adm.haproxy.1 --net="host" -p 80:80 -p 443:443 hq.stepshape.com/adm-haproxy

# publish to the private registry
publish: dock
	docker push hq.stepshape.com/adm-haproxy