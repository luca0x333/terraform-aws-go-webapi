output "address" {
  value       = module.mysql.address
  description = "Connect to the database at this endpoint (This is a public address! destroy it after)"
}

output "port" {
  value       = module.mysql.port
  description = "The port the database is listening on"
}
