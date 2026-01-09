
resource "github_repository_ruleset" "main" {
  repository = github_repository.this.id

  name        = "Main"
  target      = "branch"
  enforcement = "active"

  bypass_actors {
    actor_id    = 5
    actor_type  = "RepositoryRole"
    bypass_mode = "always"
  }

  dynamic "bypass_actors" {
    for_each = var.additional_bypass_actors
    content {
      actor_id    = bypass_actors.value.actor_id
      actor_type  = bypass_actors.value.actor_type
      bypass_mode = bypass_actors.value.bypass_mode
    }
  }

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    non_fast_forward = true

    creation = false
    deletion = true

    required_linear_history = true
    required_signatures     = true

    update = false

    pull_request {
      required_approving_review_count   = 1
      require_code_owner_review         = true
      require_last_push_approval        = true
      required_review_thread_resolution = true
    }
  }
}
