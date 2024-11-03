# Install the Gateway API CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml

# Add Envoy Gateway Helm repository
helm repo add envoy-gateway https://envoyproxy.github.io/gateway/helm
helm repo update

# Install Envoy Gateway
helm install eg envoy-gateway/gateway -n envoy-gateway-system --create-namespace


# Apply the application
kubectl apply -f app.yaml

# Apply the Gateway configuration
kubectl apply -f gateway.yaml


## Verify the installation
# Check Gateway status
kubectl get gateway eg

# Check HTTPRoute status
kubectl get httproute backend-route

# Check pods
kubectl get pods -n envoy-gateway-system

## Access the application
# Get the Gateway IP/hostname
export GATEWAY_IP=$(kubectl get gateway eg -o jsonpath='{.status.addresses[0].value}')

# Test the application
curl -v http://$GATEWAY_IP/

