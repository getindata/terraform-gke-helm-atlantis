module "atlantis_repo_config" {
  source  = "getindata/atlantis-repo-config/null"
  version = "2.3.0"

  repos               = var.repos
  repos_common_config = var.repos_common_config

  workflows = var.workflows
}

module "terraform_gke_helm_release" {
  context                    = module.this.context
  source                     = "getindata/helm-release/gke"
  version                    = "1.1.1"
  kubernetes_namespace       = var.kubernetes_namespace
  create_namespace           = true
  project_id                 = var.project_id
  name                       = var.app.name
  service_account_value_path = "serviceAccount.name"

  descriptor_formats = {
    gcp-service-account = {
      labels = ["namespace", "environment", "name"]
      format = "sa-%v-%v-%v"
    }
  }
  values = concat([templatefile("${path.module}/template/values.yaml.tftpl", { repoConfig = indent(2, module.atlantis_repo_config.repos_config_yaml) })], var.values)

  roles = var.role

  app = {
    name       = var.app.name
    chart      = var.app.chart
    repository = var.app.repository
  }
}
