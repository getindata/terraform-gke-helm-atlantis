variable "repos" {
  description = "Map of repositories and their configs. Refer to https://www.runatlantis.io/docs/server-side-repo-config.html#example-server-side-repo"
  type = list(object({
    id                            = optional(string, "/.*/")
    branch                        = optional(string)
    apply_requirements            = optional(list(string))
    allowed_overrides             = optional(list(string))
    allowed_workflows             = optional(list(string))
    allow_custom_workflows        = optional(bool)
    delete_source_branch_on_merge = optional(bool)
    pre_workflow_hooks = optional(list(object({
      run = string
    })))
    post_workflow_hooks = optional(list(object({
      run = string
    })))
    workflow = optional(string)
    ######### Helpers #########
    allow_all_server_side_workflows = optional(bool, false)
    terragrunt_atlantis_config = optional(object({
      enabled              = optional(bool)
      output               = optional(string)
      automerge            = optional(bool)
      autoplan             = optional(bool)
      parallel             = optional(bool)
      cascade_dependencies = optional(bool)
      filter               = optional(string)
      use_project_markers  = optional(bool)
    }))
  }))
  default = []
}

variable "repos_common_config" {
  description = "Common config that will be merged into each item of the repos list"
  type = object({
    id                            = optional(string)
    branch                        = optional(string)
    apply_requirements            = optional(list(string))
    allowed_overrides             = optional(list(string))
    allowed_workflows             = optional(list(string))
    allow_custom_workflows        = optional(bool)
    delete_source_branch_on_merge = optional(bool)
    pre_workflow_hooks = optional(list(object({
      run = string
    })))
    post_workflow_hooks = optional(list(object({
      run = string
    })))
    workflow = optional(string)
    ######### Helpers #########
    allow_all_server_side_workflows = optional(bool, false)
    terragrunt_atlantis_config = optional(object({
      enabled              = optional(bool)
      output               = optional(string)
      automerge            = optional(bool)
      autoplan             = optional(bool)
      parallel             = optional(bool)
      cascade_dependencies = optional(bool)
      filter               = optional(string)
      use_project_markers  = optional(bool)
    }))
  })
  default = {}
}

variable "workflows" {
  description = "List of custom workflow that will be added to the repo config file"
  type = map(object({
    plan = optional(object({
      steps = optional(list(object({
        env = optional(object({
          name    = string
          command = string
        }))
        run      = optional(string)
        multienv = optional(string)
        atlantis_step = optional(object({
          command    = string
          extra_args = optional(list(string))
        }))
      })))
    }))
    apply = optional(object({
      steps = optional(list(object({
        env = optional(object({
          name    = string
          command = string
        }))
        run      = optional(string)
        multienv = optional(string)
        atlantis_step = optional(object({
          command    = string
          extra_args = optional(list(string))
        }))
      })))
    }))
    import = optional(object({
      steps = optional(list(object({
        env = optional(object({
          name    = string
          command = string
        }))
        run      = optional(string)
        multienv = optional(string)
        atlantis_step = optional(object({
          command    = string
          extra_args = optional(list(string))
        }))
      })))
    }))
    state_rm = optional(object({
      steps = optional(list(object({
        env = optional(object({
          name    = string
          command = string
        }))
        run      = optional(string)
        multienv = optional(string)
        atlantis_step = optional(object({
          command    = string
          extra_args = optional(list(string))
        }))
      })))
    }))
    template = optional(string, "terragrunt-basic")
    asdf = optional(object({
      enabled = optional(bool, false)
    }), {})
    checkov = optional(object({
      enabled   = optional(bool, false)
      soft_fail = optional(bool, false)
      file      = optional(string, "$SHOWFILE")
    }), {})
    pull_gitlab_variables = optional(object({
      enabled = optional(bool, false)
    }), {})
    check_gitlab_approvals = optional(object({
      enabled = optional(bool, false)
    }), {}),
    infracost = optional(object({
      enabled                    = optional(bool, false)
      platform                   = optional(string, "gitlab")
      token_environment_variable = optional(string)
      behavior                   = optional(string, "new")
    }), {}),
  }))
  default = {}
}

variable "app" {
  description = "An application to deploy with specific values Here you can specify: The name of the application to deploy,Chart name, Repository address, Chart version"
  type = object({
    name                       = string
    chart                      = optional(string, "atlantis")
    repository                 = optional(string, "https://runatlantis.github.io/helm-charts")
    version                    = optional(string, "^5")
    force_update               = optional(bool, true)
    wait                       = optional(bool, true)
    recreate_pods              = optional(bool, true)
    max_history                = optional(number, 0)
    lint                       = optional(bool, true)
    cleanup_on_fail            = optional(bool, false)
    create_namespace           = optional(bool, false)
    disable_webhooks           = optional(bool, false)
    verify                     = optional(bool, false)
    reuse_values               = optional(bool, false)
    reset_values               = optional(bool, false)
    atomic                     = optional(bool, false)
    skip_crds                  = optional(bool, false)
    render_subchart_notes      = optional(bool, true)
    disable_openapi_validation = optional(bool, false)
    wait_for_jobs              = optional(bool, false)
    dependency_update          = optional(bool, false)
    replace                    = optional(bool, false)
    timeout                    = optional(number, 300)
  })
}
variable "kubernetes_namespace" {
  description = "Namespace where kubernetes SA will be applyed"
  type        = string
}

variable "values" {
  description = "Extra values"
  type        = list(string)
  default     = []
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}
