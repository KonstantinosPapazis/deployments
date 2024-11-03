resource "kubectl_manifest" "namespace_test" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: Namespace
    metadata:
      name: ops-iam-test-ns
  YAML
}

resource "kubectl_manifest" "sa_test" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: ops-iam-test
      namespace: ops-iam-test-ns
  YAML

  depends_on = [kubectl_manifest.namespace_test]
}

resource "kubectl_manifest" "test_deployment" {
  yaml_body = <<-YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: ops-iam-test-deployment
      namespace: ops-iam-test-ns
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: ops-iam-test-app
      template:
        metadata:
          labels:
            app: ops-iam-test-app
        spec:
          containers:
          - name: aws-cli
            image: amazon/aws-cli:latest
            command: ['sleep', '36000']
          restartPolicy: Always
          serviceAccountName: "ops-iam-test"
  YAML

  depends_on = [kubectl_manifest.sa_test]
}

