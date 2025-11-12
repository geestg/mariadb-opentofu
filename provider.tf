terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
  }

  required_version = ">= 1.6.0"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context_cluster = "minikube"
}
