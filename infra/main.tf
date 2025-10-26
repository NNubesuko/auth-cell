data "aws_caller_identity" "current" {}

locals {
  resource_prefix = "${var.project_name}-${var.environment}"

  user_pool = {
    name            = "${local.resource_prefix}-user-pool"
    password_policy = var.cognito_user_pool_password_policy
  }

  user_pool_client = {
    name                 = "${local.resource_prefix}-spa-client"
    allowed_oauth_scopes = var.cognito_allowed_oauth_scopes
    callback_urls        = var.cognito_callback_urls
    default_redirect_uri = var.cognito_default_redirect_uri
    logout_urls          = var.cognito_logout_urls
  }

  parameter_store_prefix = "/${var.project_name}/${var.environment}/cognito"
}

module "cognito" {
  source = "./modules/cognito"

  tags             = var.default_tags
  user_pool        = local.user_pool
  user_pool_client = local.user_pool_client
}

# Cognito関連の情報をSSMパラメータストアに保存し、他のサービスから参照できるようにする
module "ssm_parameters" {
  source = "./modules/ssm"

  tags = var.default_tags
  parameters = {
    token_signing_key_url = {
      name        = "${local.parameter_store_prefix}/token_signing_key_url"
      description = "CognitoユーザープールのJWKSエンドポイント"
      type        = "String"
      value       = module.cognito.token_signing_key_url
    }
    user_pool_client_id = {
      name        = "${local.parameter_store_prefix}/user_pool_client_id"
      description = "SPAが使用するアプリクライアントID"
      type        = "String"
      value       = module.cognito.user_pool_client_id
    }
    user_pool_domain = {
      name        = "${local.parameter_store_prefix}/user_pool_domain"
      description = "CognitoホストUIに割り当てられたドメインプレフィックス"
      type        = "String"
      value       = module.cognito.user_pool_domain
    }
    user_pool_id = {
      name        = "${local.parameter_store_prefix}/user_pool_id"
      description = "Cognitoユーザープールの識別子"
      type        = "String"
      value       = module.cognito.user_pool_id
    }
  }
}
