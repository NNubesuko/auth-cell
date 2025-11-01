project_name = "<PROJECT_NAME>"
environment  = "production"
aws_region   = "ap-northeast-1"

assume_role_arn = null

cognito_user_pool_password_policy = {
  minimum_length                   = 14
  require_lowercase                = true
  require_numbers                  = true
  require_symbols                  = true
  require_uppercase                = true
  temporary_password_validity_days = 7
}

cognito_callback_urls = [
  "<CALLBACK_URL>"
]

cognito_logout_urls = [
  "<LOGOUT_URL>"
]

cognito_default_redirect_uri = "<CALLBACK_URL>"

cognito_allowed_oauth_scopes = [
  "openid",
  "email",
  "profile"
]

default_tags = {
  Project     = "<PROJECT_NAME>"
  Environment = "production"
  IaC         = "terraform"
}

