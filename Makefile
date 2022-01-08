build:
	@terraform -chdir=terraform/vpc apply -auto-approve
	@terraform -chdir=terraform/sg apply -auto-approve
	@terraform -chdir=terraform/jenkins/jenkins-instance apply -auto-approve

destroy:
	@terraform -chdir=terraform/jenkins/jenkins-instance destroy -auto-approve
	@terraform -chdir=terraform/sg destroy -auto-approve
	@terraform -chdir=terraform/vpc destroy -auto-approve
