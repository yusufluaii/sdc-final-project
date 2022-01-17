build_jenkins:
	@terraform -chdir=terraform/vpc apply -auto-approve
	@terraform -chdir=terraform/sg apply -auto-approve
	@terraform -chdir=terraform/jenkins/jenkins-instance apply -auto-approve
	

destroy_jenkins:
	@terraform -chdir=terraform/jenkins/jenkins-instance destroy -auto-approve
	@terraform -chdir=terraform/sg destroy -auto-approve
	@terraform -chdir=terraform/vpc destroy -auto-approve


apply_k8s:
	@kubectl apply -f k8s/ns
	@helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true
	@helm install prometheus prometheus-community/kube-prometheus-stack -f k8s/monitoring/prometheus-value.yaml -n monitoring
	@kubectl apply -f k8s/database
	@kubectl apply -f k8s/frontend
	@kubectl apply -f k8s/backend
	@kubectl apply -f k8s/ingress