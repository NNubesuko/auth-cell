variable "tags" {
  description = "共通タグ"
  type        = map(string)
  default     = {}
}

variable "user_pool" {
  description = "ユーザープールの設定"
  type = object({
    name = string
    password_policy = object({
      minimum_length                   = number
      require_lowercase                = bool
      require_numbers                  = bool
      require_symbols                  = bool
      require_uppercase                = bool
      temporary_password_validity_days = number
    })
  })
}

variable "user_pool_client" {
  description = "ユーザープールクライアントの設定"
  type = object({
    name                 = string
    allowed_oauth_scopes = list(string)
    callback_urls        = list(string)
    default_redirect_uri = string
    logout_urls          = list(string)
  })
}
