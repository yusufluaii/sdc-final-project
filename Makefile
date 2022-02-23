build_jenkins:
	@terraform -chdir=terraform/vpc apply -auto-approve
	@terraform -chdir=terraform/sg apply -auto-approve
	@terraform -chdir=terraform/jenkins/jenkins-instance apply -auto-approve
	

destroy_jenkins:
	@terraform -chdir=terraform/jenkins/jenkins-instance destroy -auto-approve
	@terraform -chdir=terraform/sg destroy -auto-approve
	@terraform -chdir=terraform/vpc destroy -auto-approve

create_cluster:
	@kops create -f kops-cluster/cluster.yaml --state s3://luai-kops-state --name cluster-kops.yusufluai.my.id
	@kops create -f kops-cluster/master.yaml --state s3://luai-kops-state --name cluster-kops.yusufluai.my.id 
	@kops create -f kops-cluster/production-node-1a.yaml --state s3://luai-kops-state --name cluster-kops.yusufluai.my.id 
	@kops create -f kops-cluster/production-node-1b.yaml --state s3://luai-kops-state --name cluster-kops.yusufluai.my.id 
	@kops create -f kops-cluster/production-node-1c.yaml --state s3://luai-kops-state --name cluster-kops.yusufluai.my.id
	@kops update cluster --name cluster-kops.yusufluai.my.id --yes --admin --state s3://luai-kops-state 

prune_cluster:
	@kops delete cluster --yes --name=cluster-kops.yusufluai.my.id --state=s3://luai-kops-state 