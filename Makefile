build_jenkins:
	@terraform -chdir=terraform/vpc apply -auto-approve
	@terraform -chdir=terraform/sg apply -auto-approve
	@terraform -chdir=terraform/jenkins/jenkins-instance apply -auto-approve
	

destroy_jenkins:
	@terraform -chdir=terraform/jenkins/jenkins-instance destroy -auto-approve
	@terraform -chdir=terraform/sg destroy -auto-approve
	@terraform -chdir=terraform/vpc destroy -auto-approve
	@kops delete cluster cluster-kops.yusufluai.my.id --state s3://luai-kops-state --yes


apply_resource:
	