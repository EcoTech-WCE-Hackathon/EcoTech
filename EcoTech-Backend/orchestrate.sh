kubectl create secret generic dev-secrets --from-env-file=dev.env
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
kubectl apply -f hpa.yaml