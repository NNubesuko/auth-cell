output "token_signing_key_url" {
  description = "トークン署名キーURL"
  value       = "https://cognito-idp.${aws_cognito_user_pool.this.region}.amazonaws.com/${aws_cognito_user_pool.this.id}"
}

output "user_pool_client_id" {
  description = "ユーザープールクライアントID"
  value       = aws_cognito_user_pool_client.this.id
}

output "user_pool_id" {
  description = "ユーザープールのID"
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_arn" {
  description = "ユーザープールのARN"
  value       = aws_cognito_user_pool.this.arn
}

output "user_pool_domain" {
  description = "ユーザープールドメイン"
  value       = aws_cognito_user_pool_domain.this.domain
}
