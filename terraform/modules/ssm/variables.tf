variable "tags" {
  description = "共通タグ"
  type        = map(string)
  default     = {}
}

variable "parameters" {
  description = "SSMパラメータ"
  type = map(object({
    name        = string
    value       = string
    description = optional(string)
    type        = optional(string)
    tier        = optional(string)
    data_type   = optional(string)
    overwrite   = optional(bool)
  }))
}
