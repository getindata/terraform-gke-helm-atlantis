# Complete Example
Webhook configuration
https://www.runatlantis.io/docs/deployment.html#kubernetes-helm-chart

```terraform
module "terraform_gke_helm_atlantis" {
  source               = "getindata/terraform-helm-atlantis"
  kubernetes_namespace = "default"
  name                 = "atlantis"
  project_id           = "example"

  repos = [
    {
      id                              = "/.*/"
      allowed_overrides               = ["workflow", "delete_source_branch_on_merge"]
      allow_custom_workflows          = true
      allow_all_server_side_workflows = true
    }
  ]

  repos_common_config = {
    apply_requirements = ["approved", "mergeable"]
  }

  workflows = {
    terragrunt-basic-with-features = {
      import = {
        steps = []
      }

      checkov = {
        enabled   = true,
        soft_fail = true
      }
      infracost = {
        enabled = true
      }
      check_gitlab_approvals = {
        enabled = true
      }
      asdf = {
        enabled = true
      }
    }
  }
    
  values = [file("./extra-values/values.yaml")]
  app = {
    name          = "atlantis"
    force_update  = true
    wait          = false
    recreate_pods = false
  }
}
```

## Usage
```
terraform init
terraform plan -out tfplan
terraform apply tfplan
```
