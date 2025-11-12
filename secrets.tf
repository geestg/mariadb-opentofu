resource "kubernetes_secret" "mariadb_secret" {
  metadata {
    name = "mariadb-secret"
  }

  string_data = {
    MARIADB_ROOT_PASSWORD = "RootPassw0rd!"
  }

  type = "Opaque"
}
