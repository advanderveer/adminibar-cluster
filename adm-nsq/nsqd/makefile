##
# This service is not usually started on its own but rather
# linked to another service; a message producer most likely.
##

# build docker image
dock: 
	docker build --rm -t hq.stepshape.com/adm-nsqd .

# publish to the private registry
publish: dock
	docker push hq.stepshape.com/adm-nsqd