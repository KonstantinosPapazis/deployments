# Install the Gateway API CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml

# Create Namespace
kubectl create namespace nginx-gateway

# Install NGINX Gateway Fabric using direct manifest
kubectl apply -f https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/v1.0.0/deploy/manifests/nginx-gateway.yaml -n nginx-gateway


kubectl apply -f gateway-class.yaml
kubectl apply -f gateway.yaml
kubectl apply -f gateway-service.yaml

## Verify Installation
# Check pods
kubectl get pods -n nginx-gateway

# Check service
kubectl get svc -n nginx-gateway

# Check gateway class
kubectl get gatewayclass

# Check gateway
kubectl get gateway

# Get the LoadBalancer hostname
export LB_HOSTNAME=$(kubectl get svc -n nginx-gateway nginx-gateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Resolve the hostname to IP
export LB_IP=$(nslookup $LB_HOSTNAME | grep -A1 'Name:' | grep 'Address:' | tail -1 | awk '{print $2}')

# Test using the IP directly
curl -v http://$LB_IP/app1










#######OLD
kubectl apply -f app1-deployment.yaml
kubectl apply -f app2-deployment.yaml
kubectl apply -f gateway.yaml
kubectl apply -f routes.yaml


# Check if Gateway is ready
kubectl get gateway test-gateway

# Check if HTTPRoutes are established
kubectl get httproute

# Get the Gateway IP/hostname
kubectl get gateway test-gateway -o jsonpath='{.status.addresses[0].value}'


Testing
Once everything is deployed, you can test the routing by accessing:

    http://<gateway-ip>/app1 - Should route to app1
    http://<gateway-ip>/app2 - Should route to app2
