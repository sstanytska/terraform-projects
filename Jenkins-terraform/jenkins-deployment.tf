resource "kubernetes_persistent_volume_claim" "jenkins-pvc" {
  metadata {
    name      = "jenkins-pvc"
    namespace = "${var.namespace}"

    labels {
      app = "jenkins-deployment"
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

resource "kubernetes_deployment" "jenkins-deployment" {
  metadata {
    name      = "jenkins-deployment"
    namespace = "${var.namespace}"

    labels {
      app = "jenkins-deployment"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "jenkins-deployment"
      }
    }

    template {
      metadata {
        labels {
          app = "jenkins-deployment"
        }
      }

      spec {
        volume {
          name = "jenkins-pvc"

          persistent_volume_claim {
            claim_name = "jenkins-pvc"
          }
        }

        container {
          image = "fsadykov/centos_jenkins:0.3"
          name  = "jenkins-deployment"

          port {
            container_port = 8080
            protocol       = "TCP"
          }

          volume_mount {
            name       = "jenkins-pvc"
            mount_path = "/var/lib/jenkins"
          }

          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }
}

resource "kubernetes_service" "jenkins-service" {
  metadata {
    name      = "jenkins-service"
    namespace = "${var.namespace}"
  }

  spec {
    selector {
      app = "jenkins-deployment"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}