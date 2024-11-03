locals {
  iam_role_policy_prefix = "arn:${data.aws_partition.current.partition}:iam::aws:policy"
  dns_suffix = data.aws_partition.current.dns_suffix
}