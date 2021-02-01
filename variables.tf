variable "region" {
  type        = string
  description = "Target region"
}


variable "cluster_name" {
  type        = string
  description = "Target ECS Cluster from which you want to collect metrics"
}


variable "app_name" {
  type        = string
  description = "Assigned to Resources Names"
  default     = "cwagent"
}


variable "prefix" {
  type        = string
  default     = ""
  description = "Prefix all resources with this string, example: myapp"
}


variable "suffix" {
  type        = string
  default     = ""
  description = "Suffix all resources with this string, example: dev"
}


variable "task_role_arn" {
  type        = string
  default     = ""
  description = "Target ECS Task Role, if empty then the role is created as part of this module"
}


variable "execution_role_arn" {
  type        = string
  default     = ""
  description = "Target ECS Execution Role, if empty then the role is created as part of this module"
}


variable "task_cpu" {
  type        = number
  description = "CloudWatch Agent Task milli-CPU"
  default     = 128
}


variable "task_memory" {
  type        = number
  description = "CloudWatch Agent Task Memory (MB)"
  default     = 64
}


variable "image_tag" {
  type        = string
  description = "CloudWatch Agent Image Tag for amazon/cloudwatch-agent:{image_tag}"
  default     = "1.247347.3b250378"
}


data "template_file" "cwagent_container_mountpoints" {
  template = file("${path.module}/templates/cwagent-container-mountpoints.tpl")
}


data "template_file" "cwagent_task_volumes" {
  template = file("${path.module}/templates/cwagent-task-volumes.tpl")
}


locals {
  cluster_name = var.cluster_name
  aws_region   = var.region

  prefix         = var.prefix
  suffix         = var.suffix
  temp_app_name1 = var.app_name == "" ? "cwagent" : var.app_name
  temp_app_name2 = local.prefix == "" ? local.temp_app_name1 : "${local.prefix}-${local.temp_app_name1}"
  app_name       = local.suffix == "" ? local.temp_app_name2 : "${local.temp_app_name2}-${local.suffix}"

  cwagent_container_mountpoints = data.template_file.cwagent_container_mountpoints.rendered
  cwagent_image_tag             = var.image_tag
  cwagent_task_cpu              = var.task_cpu
  cwagent_task_memory           = var.task_memory
  cwagent_task_volumes          = jsondecode(data.template_file.cwagent_task_volumes.rendered)

  task_role_arn                  = var.task_role_arn == "" ? aws_iam_role.cwagent_task_role[0].arn : var.task_role_arn
  task_execution_role_arn        = var.execution_role_arn == "" ? aws_iam_role.cwagent_task_execution_role[0].arn : var.execution_role_arn
  create_iam_task_role           = var.task_role_arn == "" ? 1 : 0
  create_iam_task_execution_role = var.execution_role_arn == "" ? 1 : 0
}
