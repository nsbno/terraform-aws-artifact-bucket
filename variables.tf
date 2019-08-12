variable "name_prefix" {
  description = "A prefix used for naming resources."
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

variable "trusted_accounts" {
  description = "IDs of other accounts that are trusted to read from this bucket"
  type        = list(string)
  default     = []
}

