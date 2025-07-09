# k8s-nginx-demo

a minimalistic project to deploy nginx in kubernetes using minikube.

## structure

```bash
k8s-nginx-demo
    └── k8s
        ├── deployment.yaml
        ├── README.md
        └── service.yml
```

## usage

start minikube:

```bash
minikube start 
```

apply manifests:

```bash
kubectl apply -f k8s/
```

check status:

```bash
kubectl get pods
kubectl get svc
```

access service:

```bash
minikube service nginx-service
```

