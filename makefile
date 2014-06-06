cfStackName = adminibar
cfUrl = https://s3.amazonaws.com/coreos.com/dist/aws/coreos-beta.template

#the aws user's keypair (configured in web interface)
cfKeyPairName = "advanderveer@Ads-MacBook-Pro.local"

#number of virtual machines (min=3)
cfClusterSize = 3

#etcd discoery url is new generated on each evocation
etcdDiscoveryUrl = `curl https://discovery.etcd.io/new`

launch: 
	@echo "launching cluster on aws EC2..."
	@echo "[$(cfUrl)]"
	@aws cloudformation create-stack \
		--stack-name $(cfStackName) \
		--template-url $(cfUrl) \
		--parameters \
			ParameterKey=DiscoveryURL,ParameterValue=$(etcdDiscoveryUrl) \
			ParameterKey=KeyPair,ParameterValue=$(cfKeyPairName) \
			ParameterKey=ClusterSize,ParameterValue=$(cfClusterSize)
	@aws cloudformation describe-stacks --stack-name $(cfStackName)

terminate:
	@echo "terminating cluster on aws EC2..."
	aws cloudformation delete-stack --stack-name $(cfStackName)