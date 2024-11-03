terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.33.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.16.1"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path = "/Users/konstantinospapazis/Documents/repos/deployments/kubeconfig.yaml"
}

provider "helm" {
  kubernetes {
    config_path = "/Users/konstantinospapazis/Documents/repos/deployments/kubeconfig.yaml"
  }
}

provider "kubectl" {
  config_path = "/Users/konstantinospapazis/Documents/repos/deployments/kubeconfig.yaml"
}