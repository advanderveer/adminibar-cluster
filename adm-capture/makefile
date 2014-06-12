stop:
	-docker stop adm.capture.1 
	-docker stop adm.capture.1.nsqd 
	-docker stop adm.capture.2 
	-docker stop adm.capture.2.nsqd 
	-docker rm adm.capture.1
	-docker rm adm.capture.1.nsqd 
	-docker rm adm.capture.2
	-docker rm adm.capture.2.nsqd 

# start capture instances
start: stop
	
	#replicate 1
	docker run -d \
		--name adm.capture.1.nsqd \
		--link adm.nsqlookupd.1:nsqlookupd1 \
		hq.stepshape.com/adm-nsqd \
			--lookupd-tcp-address=nsqlookupd1:4160 \
			--broadcast-address=capture1nsqd
	docker run -d \
		--name adm.capture.1 \
		-p 38001:38000 \
		--link adm.capture.1.nsqd:nsqd \
		--env CAPTURE_QUE=http://nsqd:4151 hq.stepshape.com/adm-capture:0.1.2
	
	#replicate 2
	docker run -d \
		--name adm.capture.2.nsqd \
		--link adm.nsqlookupd.1:nsqlookupd1 \
		hq.stepshape.com/adm-nsqd \
			--lookupd-tcp-address=nsqlookupd1:4160 \
			--broadcast-address=capture2nsqd
	docker run -d \
		--name adm.capture.2 \
		-p 38002:38000 \
		--link adm.capture.2.nsqd:nsqd \
		--env CAPTURE_QUE=http://nsqd:4151 hq.stepshape.com/adm-capture:0.1.2