
resource "github_repository_ruleset" "main" {
  repository = github_repository.this.id

  name          = "Main"
  target        = "branch"
  enforcement   = "active"

  bypass_actors {
    actor_id   = 5
    actor_type = "RepositoryRole"
    bypass_mode = "always"
  }

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    non_fast_forward = true

    required_linear_history = true

    creation = false

    # Deletion is NOT restricted in the screenshot
    deletion = false

    # Updates ARE restricted in the screenshot
    update = false

    pull_request {
      required_approving_review_count   = 1
      require_code_owner_review         = true
      require_last_push_approval        = true
      required_review_thread_resolution = true
    }
  }
}
