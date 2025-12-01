
resource "github_repository_ruleset" "main" {
  repository_id = github_repository.this.id

  name          = "Main"
  target        = "branch"
  enforcement   = "active"

  bypass_actors {
    actor_id   = 5
    actor_type = "RepositoryRole"
  }

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
    }
  }

  rules {
    non_fast_forward {}

    commit_signatures {}

    required_linear_history {}

    creation = false

    # Deletion is NOT restricted in the screenshot
    deletion = false

    # Updates ARE restricted in the screenshot
    update = false

    required_deployments {
      required_deployment_environments = ["*"]
    }

    code_scanning {}

    required_checks {}

    required_update {}

    pull_request {
      required_approving_review_count   = 1
      require_code_owner_reviews        = true
      require_last_push_approval        = true
      required_review_thread_resolution = true
      dismiss_stale_reviews             = true
    }

    required_status_checks {
      strict_required_status_checks_policy = true

      required_check {
        context = "Copilot"
      }
      required_check {
        # Placeholder for other required CI checks
        context = "ci/build"
      }
    }
  }
}
