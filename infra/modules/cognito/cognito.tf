resource "aws_cognito_user_pool" "this" {
  name = var.user_pool.name

  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  password_policy {
    minimum_length                   = var.user_pool.password_policy.minimum_length
    require_lowercase                = var.user_pool.password_policy.require_lowercase
    require_numbers                  = var.user_pool.password_policy.require_numbers
    require_symbols                  = var.user_pool.password_policy.require_symbols
    require_uppercase                = var.user_pool.password_policy.require_uppercase
    temporary_password_validity_days = var.user_pool.password_policy.temporary_password_validity_days
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    mutable             = true
    required            = true
  }

  mfa_configuration = "OFF"

  tags = var.tags
}

resource "aws_cognito_user_pool_client" "this" {
  name         = var.user_pool_client.name
  user_pool_id = aws_cognito_user_pool.this.id

  allowed_oauth_flows                  = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = var.user_pool_client.allowed_oauth_scopes

  callback_urls                 = var.user_pool_client.callback_urls
  default_redirect_uri          = var.user_pool_client.default_redirect_uri
  generate_secret               = false
  logout_urls                   = var.user_pool_client.logout_urls
  prevent_user_existence_errors = "ENABLED"
  supported_identity_providers  = ["COGNITO"]

  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]
}

resource "aws_cognito_user_pool_domain" "this" {
  domain                = replace(lower(aws_cognito_user_pool.this.id), "_", "")
  user_pool_id          = aws_cognito_user_pool.this.id
  managed_login_version = 2
}

resource "awscc_cognito_managed_login_branding" "default_style" {
  user_pool_id                = aws_cognito_user_pool.this.id
  client_id                   = aws_cognito_user_pool_client.this.id
  use_cognito_provided_values = true
}
