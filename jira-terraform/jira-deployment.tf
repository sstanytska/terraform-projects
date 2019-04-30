resource "kubernetes_persistent_volume_claim" "jira-pvc" {
  metadata {
    name      = "jira-pvc"
    namespace = "${var.namespace}"

    labels {
      app = "jira-deployment"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests {
        storage = "10Gi"
      }
    }

    storage_class_name = "standard"
  }
}

resource "kubernetes_deployment" "jira-deployment" {
  metadata {
    name      = "jira-deployment"
    namespace = "${var.namespace}"

    labels {
      app = "jira-deployment"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "jira-deployment"
      }
    }

    template {
      metadata {
        labels {
          app = "jira-deployment"
        }
      }

      spec {
        volume {
          name = "jira-pvc"

          persistent_volume_claim {
            claim_name = "jira-pvc"
          }
        }

        container {
          image = "gcr.io/hightowerlabs/jira:7.3.6-standalone"
          name  = "jira-deployment"

          port {
            container_port = 8080
            protocol       = "TCP"
          }

          volume_mount {
            name       = "jira-pvc"
            mount_path = "/var/lib/jira"
          }

          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }
}

resource "kubernetes_service" "jira-service" {
  metadata {
    name      = "jira-service"
    namespace = "${var.namespace}"
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 8080
    }

    selector {
      app = "jira-deployment"
    }

    type = "LoadBalancer"
  }
}