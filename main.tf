resource "github_repository" "this" {
  allow_auto_merge                        = var.allow_auto_merge
  allow_merge_commit                      = var.allow_merge_commit
  allow_rebase_merge                      = var.allow_rebase_merge
  allow_squash_merge                      = var.allow_squash_merge
  allow_update_branch                     = var.allow_update_branch
  archived                                = var.archived
  archive_on_destroy                      = var.archive_on_destroy
  auto_init                               = var.auto_init
  delete_branch_on_merge                  = var.delete_branch_on_merge
  description                             = var.description
  gitignore_template                      = var.gitignore_template
  has_downloads                           = var.has_downloads
  has_discussions                         = var.has_discussions
  has_issues                              = var.has_issues
  has_projects                            = var.has_projects
  has_wiki                                = var.has_wiki
  homepage_url                            = var.homepage_url
  ignore_vulnerability_alerts_during_read = var.ignore_vulnerability_alerts_during_read
  is_template                             = var.is_template
  license_template                        = var.license_template
  merge_commit_message                    = var.merge_commit_message
  merge_commit_title                      = var.merge_commit_title
  name                                    = var.name
  squash_merge_commit_message             = var.squash_merge_commit_message
  squash_merge_commit_title               = var.squash_merge_commit_title
  topics                                  = var.topics
  visibility                              = var.visibility
  vulnerability_alerts                    = var.vulnerability_alerts
  web_commit_signoff_required             = var.web_commit_signoff_required

  dynamic "pages" {
    for_each = var.pages == null ? [] : [var.pages]
    content {
      build_type = lookup(pages.value, "build_type", null)
      cname      = lookup(pages.value, "cname", null)
      dynamic "source" {
        for_each = lookup(pages.value, "source", null) == null ? [] : [lookup(pages.value, "source", null)]
        content {
          branch = source.value.branch
          path   = lookup(source.value, "path", null)
        }
      }
    }
  }

  dynamic "security_and_analysis" {
    for_each = var.security_and_analysis == null ? [] : [var.security_and_analysis]
    content {
      dynamic "advanced_security" {
        for_each = lookup(security_and_analysis.value, "advanced_security", null) == null ? [] : [lookup(security_and_analysis.value, "advanced_security", null)]
        content {
          status = advanced_security.value.status
        }
      }
      dynamic "secret_scanning" {
        for_each = lookup(security_and_analysis.value, "secret_scanning", null) == null ? [] : [lookup(security_and_analysis.value, "secret_scanning", null)]
        content {
          status = secret_scanning.value.status
        }
      }
      dynamic "secret_scanning_push_protection" {
        for_each = lookup(security_and_analysis.value, "secret_scanning_push_protection", null) == null ? [] : [lookup(security_and_analysis.value, "secret_scanning_push_protection", null)]
        content {
          status = secret_scanning_push_protection.value.status
        }
      }
    }
  }

  dynamic "template" {
    for_each = var.create_from_template ? var.template : []
    content {
      owner                = template.value.owner
      repository           = template.value.repository
      include_all_branches = lookup(template.value, "include_all_branches", false)
    }
  }
}

resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = var.branch_default
}
