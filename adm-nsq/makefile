#download binary dependencies
setup:
	wget https://s3.amazonaws.com/bitly-downloads/nsq/nsq-0.2.28.linux-amd64.go1.2.1.tar.gz -O ./nsq.tar.gz
	tar xvfz nsq.tar.gz
	cp nsq-*/bin/nsqadmin admin
	cp nsq-*/bin/nsqlookupd lookupd
	cp nsq-*/bin/nsqd nsqd
	rm -fr nsq-*
	rm -fr nsq.tar.gz

start:
	cd lookupd && make start
	cd admin && make start