export KOPS_STATE_STORE=s3://luai-kops-state

kops create -f kops-cluster/cluster.yaml
kops create -f kops-cluster/.yaml
kops create -f kops-cluster/cluster.yaml
kops create -f kops-cluster/cluster.yaml
kops create -f kops-cluster/cluster.yaml