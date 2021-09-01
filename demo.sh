# expose event listener so that the GitHub webhook can deliver the JSON payload
~/Downloads/ngrok http 8080

# ArgoCD Cluster IP
kubectl get svc/argocd-server -n argocd -ojson | jq .spec.clusterIP

# Port forward ArgoCD load balancer
kubectl port-forward svc/argocd-server -n argocd 8090:443

# ArgoCD is available at
https://localhost:8090/

# Port forward Tekton Dashboard so that its available at
# http://localhost:8001/api/v1/namespaces/tekton-pipelines/services/tekton-dashboard:http/proxy
kubectl proxy

# Create namespace demo
kubectl create namespace demo

# Create ArgoCD app to sync Tekton Pipeline
argocd app create demo-app-build --repo https://github.com/pritidesai/awesome-application --path pipeline --dest-name docker-desktop --dest-namespace demo

# Sync Tekton Pipeline
argocd app sync demo-app-build

# Create ArgoCD app to sync Deployment
argocd app create demo-app-deploy --repo https://github.com/pritidesai/awesome-application --path deployment --dest-name docker-desktop --dest-namespace demo

# Create ArgoCD secret and Service Account
kubectl apply -n demo -f pipeline/argocdsecret.yaml
kubectl apply -n demo -f pipeline/service-account.yaml

# No sync here since the app image is not available yet

# Port forward Tekton Event Listener
kubectl port-forward  svc/el-demo-el -n demo 8080

# Tekton Dashboard

# Setup GitHub webhook

# Change the application in Github and commit changes which will activate the trigger and pipelineRun must start

# Confirm the PipelineRun started

# Access the application at
http://localhost:32426/




