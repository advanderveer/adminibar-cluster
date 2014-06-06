#download binary dependencies
setup:
	wget https://s3.amazonaws.com/bitly-downloads/nsq/nsq-0.2.28.linux-amd64.go1.2.1.tar.gz -O ./nsq.tar.gz
	tar xvfz nsq.tar.gz
	cp nsq-*/bin/nsqadmin admin
	cp nsq-*/bin/nsqlookupd lookupd
	rm -fr nsq-*
	rm -fr nsq.tar.gz

dock-admin:
	docker build --rm ./admin/

#
# Lookupd
#			
dock-lookupd:
	docker build --rm -t hq.stepshape.com/adm-nsqlookupd ./lookupd/

publish-lookupd: dock-lookupd
	docker push hq.stepshape.com/adm-nsqlookupd

start-lookupd: dock-lookupd
	fleetctl destroy lookupd/adm.nsqlookupd\@{nr,addr,http,tcp}.1.service 
	fleetctl start lookupd/adm.nsqlookupd\@{nr,addr,http,tcp}.1.service 