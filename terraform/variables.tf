variable "project_name" {
  description = "プロジェクト名"
  type        = string
}

variable "environment" {
  description = "環境名(例: develop、staging、production)"
  type        = string
}

variable "aws_region" {
  description = "AWSリージョン"
  type        = string
}

variable "assume_role_arn" {
  description = "Terraform操作で引き受けるオプションのIAMロールARN"
  type        = string
  default     = null
}

variable "default_tags" {
  description = "共通タグ"
  type        = map(string)
}

variable "cognito_user_pool_password_policy" {
  description = "Cognitoユーザープールに適用されるパスワードポリシーの設定"
  type = object({
    minimum_length                   = number
    require_lowercase                = bool
    require_numbers                  = bool
    require_symbols                  = bool
    require_uppercase                = bool
    temporary_password_validity_days = number
  })
  default = {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = false
    require_uppercase                = true
    temporary_password_validity_days = 7
  }
}

variable "cognito_callback_urls" {
  description = "Cognitoユーザープールクライアントに許可されたOAuth2コールバックURLリスト"
  type        = list(string)

  validation {
    condition     = length(var.cognito_callback_urls) > 0
    error_message = "少なくとも1つのCognitoコールバックURLを指定する必要があります。"
  }
}

variable "cognito_logout_urls" {
  description = "Cognitoユーザープールクライアントに許可されたログアウトURLリスト"
  type        = list(string)
  default     = []
}

variable "cognito_default_redirect_uri" {
  description = "Cognitoユーザープールクライアントで使用されるデフォルトのリダイレクトURI"
  type        = string

  validation {
    condition     = contains(var.cognito_callback_urls, var.cognito_default_redirect_uri)
    error_message = "デフォルトのリダイレクトURIはコールバックURLリストに含まれている必要があります。"
  }
}

variable "cognito_allowed_oauth_scopes" {
  description = "Cognitoユーザープールクライアントに付与されるOAuthスコープリスト"
  type        = list(string)
  default     = ["openid", "email", "profile"]
}

