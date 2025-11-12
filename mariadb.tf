# Deployment MariaDB
resource "kubernetes_deployment" "mariadb" {
  metadata {
    name = "mariadb-deployment"
    labels = {
      app = "mariadb"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mariadb"
      }
    }

    template {
      metadata {
        labels = {
          app = "mariadb"
        }
      }

      spec {
        container {
          name  = "mariadb"
          image = "mariadb:11.4"

          port {
            container_port = 3306
          }

          env {
            name = "MARIADB_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mariadb_secret.metadata[0].name
                key  = "MARIADB_ROOT_PASSWORD"
              }
            }
          }
        }
      }
    }
  }
}

# Service MariaDB
resource "kubernetes_service" "mariadb_service" {
  metadata {
    name = "mariadb-service"
    labels = {
      app = "mariadb"
    }
  }

  spec {
    selector = {
      app = kubernetes_deployment.mariadb.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 3306
      target_port = 3306
      node_port   = 30036
    }

    type = "NodePort"
  }
}
