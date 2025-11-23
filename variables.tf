variable "allow_auto_merge" {
  description = "Boolean specifying whether auto-merging is enabled on pull requests."
  type        = bool
  default     = true # Resource default is false, but we prefer true
}

variable "allow_merge_commit" {
  description = "Boolean specifying whether merge commits are allowed."
  type        = bool
  default     = false # Resource default is true, but we prefer false
}

variable "allow_rebase_merge" {
  description = "Boolean specifying whether rebase merging is allowed."
  type        = bool
  default     = false # Resource default is true, but we prefer false
}

variable "allow_squash_merge" {
  description = "Boolean specifying whether squash merging is allowed."
  type        = bool
  default     = true
}

variable "allow_update_branch" {
  description = "Boolean specifying whether the \"Update branch\" option is enabled on pull requests."
  type        = bool
  default     = true # Resource default is false, but we prefer true
}

variable "archived" {
  description = "Specifies if the repository should be archived. Defaults to false."
  type        = bool
  default     = false
}

# This is essential to avoid accidental deletions of repos
variable "archive_on_destroy" {
  description = "Set to true to archive the repository instead of deleting on destroy."
  type        = bool
  default     = true
}

variable "auto_init" {
  description = "Set to true to produce an initial commit in the repository."
  type        = bool
  default     = false
}

variable "branch_default" {
  description = "The name of the default branch for the repository."
  type        = string
  default     = "main"
}

variable "create_from_template" {
  description = "Set to true to create the repository from a template."
  type        = bool
  default     = false
}

variable "delete_branch_on_merge" {
  description = "Automatically delete head branch after a pull request is merged. Defaults to false."
  type        = bool
  default     = true # Resource default is false, but we prefer true
}

variable "description" {
  description = "A description of the repository."
  type        = string
  default     = null
}

variable "gitignore_template" {
  description = "Use the name of the template without the extension. For example, \"Haskell\"."
  type        = string
  default     = null
}

variable "has_downloads" {
  description = "Set to true to enable the (deprecated) downloads features on the repository."
  type        = bool
  default     = false
}

variable "has_discussions" {
  description = "Set to true to enable GitHub Discussions on the repository. Defaults to false."
  type        = bool
  default     = false
}

variable "has_issues" {
  description = "Boolean specifying whether Issues are enabled."
  type        = bool
  default     = true
}

variable "has_projects" {
  description = "Set to true to enable the GitHub Projects features on the repository."
  type        = bool
  default     = false # Resource default is true, but we prefer false
}

variable "has_wiki" {
  description = "Set to true to enable the GitHub Wiki features on the repository."
  type        = bool
  default     = false
}

variable "homepage_url" {
  description = "URL of a page describing the project."
  type        = string
  default     = null
}

variable "ignore_vulnerability_alerts_during_read" {
  description = "Set to true to not call the vulnerability alerts endpoint so the resource can also be used without admin permissions during read."
  type        = bool
  default     = true # Resource default is false, but we prefer true
}

variable "is_template" {
  description = "Set to true to tell GitHub that this is a template repository."
  type        = bool
  default     = false
}

variable "license_template" {
  description = "Use the name of the template without the extension. For example, \"mit\" or \"mpl-2.0\"."
  type        = string
  default     = null
}

variable "merge_commit_message" {
  description = "Can be PR_BODY, PR_TITLE, or BLANK for a default merge commit message. Applicable only if allow_merge_commit is true."
  type        = string
  default     = null
}

variable "merge_commit_title" {
  description = "Can be PR_TITLE or MERGE_MESSAGE for a default merge commit title. Applicable only if allow_merge_commit is true."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the repository."
  type        = string
}

variable "pages" {
  description = "The repository's GitHub Pages configuration."
  type        = any
  default     = null
}

variable "security_and_analysis" {
  description = "The repository's security and analysis configuration."
  type        = any
  default     = null
}

variable "squash_merge_commit_message" {
  description = "Can be PR_BODY, COMMIT_MESSAGES, or BLANK for a default squash merge commit message. Applicable only if allow_squash_merge is true."
  type        = string
  default     = null
}

variable "squash_merge_commit_title" {
  description = "Can be PR_TITLE or COMMIT_OR_PR_TITLE for a default squash merge commit title. Applicable only if allow_squash_merge is true."
  type        = string
  default     = null
}

variable "template" {
  description = "Configuration for creating a repository from a template."
  type = set(object({
    owner                = string
    repository           = string
    include_all_branches = optional(bool, false)
  }))
  default = []
}

variable "topics" {
  description = "The list of topics of the repository."
  type        = set(string)
  default     = []
}

variable "visibility" {
  description = "The visibility of the repository."
  type        = string
  default     = "private"
}

variable "vulnerability_alerts" {
  description = "Set to true to enable security alerts for vulnerable dependencies."
  type        = bool
  default     = true # Resource default is false, but we prefer true
}

variable "web_commit_signoff_required" {
  description = "Require contributors to sign off on web-based commits."
  type        = bool
  default     = false
}
