data "aws_iam_policy_document" "assume_test_role_policy_eks_pod_identity" {

  statement {
    effect = "Allow"
    sid     = "EKSPodIdentityAssumeRole"
    actions = ["sts:AssumeRole","sts:TagSession"]

    principals {
      type        = "Service"
      identifiers = ["pods.eks.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_iam_role" "test_eks_pod_identity_role" {

  name = "test-pod-identity1"
  description = "Test role for Pod Identity"

  assume_role_policy    = data.aws_iam_policy_document.assume_test_role_policy_eks_pod_identity.json
  force_detach_policies = true

}

resource "aws_iam_role_policy_attachment" "test_eks_pod_identity_policy" {
  for_each = { for k, v in toset(compact([
    "${local.iam_role_policy_prefix}/AmazonS3ReadOnlyAccess",
  ])) : k => v }

  policy_arn = each.value
  role       = aws_iam_role.test_eks_pod_identity_role.name
}

resource "aws_eks_pod_identity_association" "test_example" {
  cluster_name    = "my-cluster"
  namespace       = "ops-iam-test-ns"
  service_account = "ops-iam-test"
  role_arn        = aws_iam_role.test_eks_pod_identity_role.arn
}