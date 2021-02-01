output "app_name" {
  value       = local.app_name
  description = "App name, optionally includes prefix and suffix"
}

output "ecs_service_arn" {
  value       = aws_ecs_service.cwagent.id
  description = "Service ARN"
}

output "ecs_task_definition_arn" {
  value       = aws_ecs_task_definition.cwagent.arn
  description = "Task Definition ARN"
}

output "iam_cwagent_task_execution_role_arn" {
  value       = local.task_execution_role_arn
  description = "Task Execution Role ARN"
}

output "iam_cwagent_task_role_arn" {
  value       = local.task_role_arn
  description = "Task Role ARN"
}
