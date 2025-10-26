resource "aws_ssm_parameter" "this" {
  for_each = var.parameters

  name        = each.value.name
  description = lookup(each.value, "description", null)
  type        = lookup(each.value, "type", "String")
  tier        = lookup(each.value, "tier", "Standard")
  data_type   = lookup(each.value, "data_type", "text")
  overwrite   = lookup(each.value, "overwrite", true)
  value       = each.value.value
  tags        = var.tags
}
