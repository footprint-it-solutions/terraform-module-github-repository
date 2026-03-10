
resource "github_repository_ruleset" "main" {
  enforcement = "active"
  name        = "Main"
  repository  = github_repository.this.id
  target      = "branch"

  bypass_actors {
    actor_id    = 5
    actor_type  = "RepositoryRole"
    bypass_mode = var.repository_admin_bypass_mode
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
      exclude = []
      include = ["~DEFAULT_BRANCH"]
    }
  }

  rules {
    creation = false
    deletion = true

    dynamic "merge_queue" {
      for_each = var.merge_queue_enabled ? [1] : []
      content {
        check_response_timeout_minutes    = var.merge_queue_check_response_timeout_minutes
        grouping_strategy                 = var.merge_queue_grouping_strategy
        max_entries_to_build              = var.merge_queue_max_entries_to_build
        max_entries_to_merge              = var.merge_queue_max_entries_to_merge
        merge_method                      = var.merge_queue_merge_method
        min_entries_to_merge              = var.merge_queue_min_entries_to_merge
        min_entries_to_merge_wait_minutes = var.merge_queue_min_entries_to_merge_wait_minutes
      }
    }

    non_fast_forward = true

    pull_request {
      require_code_owner_review         = true
      require_last_push_approval        = true
      required_approving_review_count   = 1
      required_review_thread_resolution = true
    }

    required_linear_history = true
    required_signatures     = true

    update = false
  }
}
