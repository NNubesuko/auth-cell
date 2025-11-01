output "parameters" {
  description = "SSMパラメータの名前とARN"
  value = {
    for key, param in aws_ssm_parameter.this :
    key => {
      arn  = param.arn
      name = param.name
    }
  }
}
