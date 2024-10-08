# Terraform Gke Helm Atlantis

<!--- Pick Cloud provider Badge -->
<!---![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white) -->
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
<!---!![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white) -->
<!---![Snowflake](https://img.shields.io/badge/-SNOWFLAKE-249edc?style=for-the-badge&logo=snowflake&logoColor=white) -->
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

<!--- Replace repository name -->
![License](https://badgen.net/github/license/getindata/terraform-gke-helm-atlantis/)
![Release](https://badgen.net/github/release/getindata/terraform-gke-helm-atlantis/)

<p align="center">
  <img height="150" src="https://getindata.com/img/logo.svg">
  <h3 align="center">We help companies turn their data into assets</h3>
</p>

---

Terraform module for managing Atlantis on GKE Cluster

Additionally, this module generates the configuration for Atlantis and uses this configuration in deployment

## USAGE BASIC
```terraform
module "terraform_gke_helm_atlantis" {
  source               = "getindata/terraform-gke-helm-atlantis"
  kubernetes_namespace = "default"
  name                 = "atlantis"
  project_id           = "example"

  values = [file("./extra-values/values.yaml")]  
  app = {
    name       = "atlantis"
}
```
## USAGE ADVANCED
```terraform
module "terraform_gke_helm_atlantis" {
  source               = "getindata/terraform-gke-helm-atlantis"
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

## EXAMPLES
- [Simple](examples/simple) - Basic usage of the module
- [Complete](examples/complete) - Advanced usage of the module

<!-- BEGIN_TF_DOCS -->




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_app"></a> [app](#input\_app) | An application to deploy with specific values Here you can specify: The name of the application to deploy,Chart name, Repository address, Chart version | <pre>object({<br>    name                       = string<br>    chart                      = optional(string, "atlantis")<br>    repository                 = optional(string, "https://runatlantis.github.io/helm-charts")<br>    version                    = optional(string, "^5")<br>    force_update               = optional(bool, true)<br>    wait                       = optional(bool, true)<br>    recreate_pods              = optional(bool, true)<br>    max_history                = optional(number, 0)<br>    lint                       = optional(bool, true)<br>    cleanup_on_fail            = optional(bool, false)<br>    create_namespace           = optional(bool, false)<br>    disable_webhooks           = optional(bool, false)<br>    verify                     = optional(bool, false)<br>    reuse_values               = optional(bool, false)<br>    reset_values               = optional(bool, false)<br>    atomic                     = optional(bool, false)<br>    skip_crds                  = optional(bool, false)<br>    render_subchart_notes      = optional(bool, true)<br>    disable_openapi_validation = optional(bool, false)<br>    wait_for_jobs              = optional(bool, false)<br>    dependency_update          = optional(bool, false)<br>    replace                    = optional(bool, false)<br>    timeout                    = optional(number, 300)<br>  })</pre> | n/a | yes |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_kubernetes_namespace"></a> [kubernetes\_namespace](#input\_kubernetes\_namespace) | Namespace where kubernetes SA will be applyed | `string` | n/a | yes |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_repos"></a> [repos](#input\_repos) | Map of repositories and their configs. Refer to https://www.runatlantis.io/docs/server-side-repo-config.html#example-server-side-repo | <pre>list(object({<br>    id                            = optional(string, "/.*/")<br>    branch                        = optional(string)<br>    apply_requirements            = optional(list(string))<br>    allowed_overrides             = optional(list(string))<br>    allowed_workflows             = optional(list(string))<br>    allow_custom_workflows        = optional(bool)<br>    delete_source_branch_on_merge = optional(bool)<br>    pre_workflow_hooks = optional(list(object({<br>      run = string<br>    })))<br>    post_workflow_hooks = optional(list(object({<br>      run = string<br>    })))<br>    workflow = optional(string)<br>    ######### Helpers #########<br>    allow_all_server_side_workflows = optional(bool, false)<br>    terragrunt_atlantis_config = optional(object({<br>      enabled              = optional(bool)<br>      output               = optional(string)<br>      automerge            = optional(bool)<br>      autoplan             = optional(bool)<br>      parallel             = optional(bool)<br>      cascade_dependencies = optional(bool)<br>      filter               = optional(string)<br>      use_project_markers  = optional(bool)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_repos_common_config"></a> [repos\_common\_config](#input\_repos\_common\_config) | Common config that will be merged into each item of the repos list | <pre>object({<br>    id                            = optional(string)<br>    branch                        = optional(string)<br>    apply_requirements            = optional(list(string))<br>    allowed_overrides             = optional(list(string))<br>    allowed_workflows             = optional(list(string))<br>    allow_custom_workflows        = optional(bool)<br>    delete_source_branch_on_merge = optional(bool)<br>    pre_workflow_hooks = optional(list(object({<br>      run = string<br>    })))<br>    post_workflow_hooks = optional(list(object({<br>      run = string<br>    })))<br>    workflow = optional(string)<br>    ######### Helpers #########<br>    allow_all_server_side_workflows = optional(bool, false)<br>    terragrunt_atlantis_config = optional(object({<br>      enabled              = optional(bool)<br>      output               = optional(string)<br>      automerge            = optional(bool)<br>      autoplan             = optional(bool)<br>      parallel             = optional(bool)<br>      cascade_dependencies = optional(bool)<br>      filter               = optional(string)<br>      use_project_markers  = optional(bool)<br>    }))<br>  })</pre> | `{}` | no |
| <a name="input_role"></a> [role](#input\_role) | Atlantis SA roles | `list(string)` | <pre>[<br>  "roles/editor"<br>]</pre> | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_values"></a> [values](#input\_values) | Extra values | `list(string)` | `[]` | no |
| <a name="input_workflows"></a> [workflows](#input\_workflows) | List of custom workflow that will be added to the repo config file | <pre>map(object({<br>    plan = optional(object({<br>      steps = optional(list(object({<br>        env = optional(object({<br>          name    = string<br>          command = string<br>        }))<br>        run      = optional(string)<br>        multienv = optional(string)<br>        atlantis_step = optional(object({<br>          command    = string<br>          extra_args = optional(list(string))<br>        }))<br>      })))<br>    }))<br>    apply = optional(object({<br>      steps = optional(list(object({<br>        env = optional(object({<br>          name    = string<br>          command = string<br>        }))<br>        run      = optional(string)<br>        multienv = optional(string)<br>        atlantis_step = optional(object({<br>          command    = string<br>          extra_args = optional(list(string))<br>        }))<br>      })))<br>    }))<br>    import = optional(object({<br>      steps = optional(list(object({<br>        env = optional(object({<br>          name    = string<br>          command = string<br>        }))<br>        run      = optional(string)<br>        multienv = optional(string)<br>        atlantis_step = optional(object({<br>          command    = string<br>          extra_args = optional(list(string))<br>        }))<br>      })))<br>    }))<br>    state_rm = optional(object({<br>      steps = optional(list(object({<br>        env = optional(object({<br>          name    = string<br>          command = string<br>        }))<br>        run      = optional(string)<br>        multienv = optional(string)<br>        atlantis_step = optional(object({<br>          command    = string<br>          extra_args = optional(list(string))<br>        }))<br>      })))<br>    }))<br>    template = optional(string, "terragrunt-basic")<br>    asdf = optional(object({<br>      enabled = optional(bool, false)<br>    }), {})<br>    checkov = optional(object({<br>      enabled   = optional(bool, false)<br>      soft_fail = optional(bool, false)<br>      file      = optional(string, "$SHOWFILE")<br>    }), {})<br>    pull_gitlab_variables = optional(object({<br>      enabled = optional(bool, false)<br>    }), {})<br>    check_gitlab_approvals = optional(object({<br>      enabled = optional(bool, false)<br>    }), {}),<br>    infracost = optional(object({<br>      enabled                    = optional(bool, false)<br>      platform                   = optional(string, "gitlab")<br>      token_environment_variable = optional(string)<br>      behavior                   = optional(string, "new")<br>    }), {}),<br>  }))</pre> | `{}` | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_atlantis_repo_config"></a> [atlantis\_repo\_config](#module\_atlantis\_repo\_config) | getindata/atlantis-repo-config/null | 2.3.0 |
| <a name="module_terraform_gke_helm_release"></a> [terraform\_gke\_helm\_release](#module\_terraform\_gke\_helm\_release) | getindata/helm-release/gke | 1.1.1 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_service_account"></a> [gcp\_service\_account](#output\_gcp\_service\_account) | GCP service account. |
| <a name="output_gcp_service_account_email"></a> [gcp\_service\_account\_email](#output\_gcp\_service\_account\_email) | Email address of GCP service account. |
| <a name="output_gcp_service_account_fqn"></a> [gcp\_service\_account\_fqn](#output\_gcp\_service\_account\_fqn) | FQN of GCP service account. |
| <a name="output_gcp_service_account_name"></a> [gcp\_service\_account\_name](#output\_gcp\_service\_account\_name) | Name of GCP service account. |
| <a name="output_k8s_service_account_name"></a> [k8s\_service\_account\_name](#output\_k8s\_service\_account\_name) | Name of K8S service account. |
| <a name="output_k8s_service_account_namespace"></a> [k8s\_service\_account\_namespace](#output\_k8s\_service\_account\_namespace) | Namespace of k8s service account. |

## Providers

No providers.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Resources

No resources.
<!-- END_TF_DOCS -->

## CONTRIBUTING

Contributions are very welcomed!

Start by reviewing [contribution guide](CONTRIBUTING.md) and our [code of conduct](CODE_OF_CONDUCT.md). After that, start coding and ship your changes by creating a new PR.

## LICENSE

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.

## AUTHORS

<!--- Replace repository name -->
<a href="https://github.com/getindata/terraform-helm-atlantis/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=getindata/terraform-module-template" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
