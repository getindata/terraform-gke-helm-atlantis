module "terraform_gke_helm_atlantis" {
  source               = "../../"
  kubernetes_namespace = "default"
  name                 = "atlantis"
  project_id           = "example"

  values = [file("./extra-values/values.yaml")]

  app = {
    name = "atlantis"
  }
}
