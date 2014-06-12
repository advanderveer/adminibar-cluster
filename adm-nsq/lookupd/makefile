# build docker image
dock: 
	docker build --rm -t hq.stepshape.com/adm-nsqlookupd .

stop: 
	-docker stop adm.nsqlookupd.1 
	-docker rm adm.nsqlookupd.1

start: dock stop
	docker run -d \
		--name adm.nsqlookupd.1 \
		-p 38010:4160 \
		-p 38011:4161 \
		hq.stepshape.com/adm-nsqlookupd \
			--broadcast-address=nsqlookupd1

# publish to the private registry
publish: dock
	docker push hq.stepshape.com/adm-nsqlookupd