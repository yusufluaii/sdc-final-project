output "main_security_group_id" {
  value = module.main_sg.security_group_id
}

output "db_security_group_id" {
  value = module.db_sg.security_group_id
}