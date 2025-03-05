# Logefrei sur Kubernetes

## Requis

Helm: ```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
sudo ./get_helm.sh

````

Traefik comme Ingress Controller: ```bash
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
kubectl create ns traefik
helm install traefik traefik/traefik --namespace traefik
helm upgrade --install traefik \
 --namespace traefik \
 --set dashboard.enabled=true \
 --set rbac.enabled=true \
 --set nodeSelector.node-type=master \
 --set="additionalArguments={--api.dashboard=true,--log.level=DEBUG,--providers.kubernetesingress.ingressclass=traefik-internal,--serversTransport.insecureSkipVerify=true}" \
 traefik/traefik

# Pour exposer le dashboard

kubectl apply -f k8s/traefik-dev.yaml

````

Kube Dashboard: ```bash
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

```

## Installation

```

kubectl create ns metroboulotdodo
kubectl config set-context --current --namespace=metroboulotdodo
kubectl apply -f k8s/secrets/db.yaml
kubectl apply -f k8s/microservices -R

```

## Structure

- k8s
  - microservices
    - db: metroboulotdodo-db
      - valueFrom db secret pour POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB
    - canvas: metroboulotdodo-back @ npm run start:canvas
    - data: metroboulotdodo-back @ npm run start:data
      - valueFrom db secret pour DATABASE_URL
    - dijkstra: metroboulotdodo-back @ npm run start:dijkstra
    - kruskal: metroboulotdodo-back @ npm run start:kruskal
    - proxy: metroboulotdodo-back @ npm run start:proxy
      - IngressRoute traefik /api 3000
    - front: metroboulotdodo-front
      - IngressRoute traefik / 80
  - secrets
    - db (Secret)
      - POSTGRES_USER
      - POSTGRES_PASSWORD
      - POSTGRES_DB
      - DATABASE_URL

```

```

```
