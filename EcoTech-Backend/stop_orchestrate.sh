kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
kubectl delete -f hpa.yaml
kubectl delete -f ingress.yaml
kubectl delete  secrets/dev-secrets