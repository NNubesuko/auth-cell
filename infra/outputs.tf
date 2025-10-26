output "cognito_user_pool_id" {
  description = "CognitoユーザープールのID"
  value       = module.cognito.user_pool_id
}

output "cognito_user_pool_client_id" {
  description = "SPAが使用するアプリクライアントID"
  value       = module.cognito.user_pool_client_id
}

output "cognito_user_pool_domain" {
  description = "CognitoホストUIに割り当てられたドメインプレフィックス"
  value       = module.cognito.user_pool_domain
}

output "ssm_parameters" {
  description = "SSMパラメータの名前とARN"
  value       = module.ssm_parameters.parameters
}
