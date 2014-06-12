# build docker image
dock: 
	docker build --rm -t hq.stepshape.com/adm-nsqadmin .

stop: 
	-docker stop adm.nsqadmin.1
	-docker rm adm.nsqadmin.1

start: dock stop
	docker run -d \
		--name 	adm.nsqadmin.1 \
		-p 		38020:4171  \
		hq.stepshape.com/adm-nsqadmin \
			--lookupd-http-address=172.17.42.1:38011 #docker0 address

# publish to the private registry
publish: dock
	docker push hq.stepshape.com/adm-nsqadmin