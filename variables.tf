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

variable "region" {
  type        = string
  description = "Insert the region to deploy in, defaults to current region"
}


variable "cluster_name" {
  type        = string
  description = "Enter the name of your ECS cluster from which you want to collect metrics"
}


variable "task_role_arn" {
  type        = string
  default     = ""
  description = "Enter the role arn you want to use as the ecs task role"
}


variable "execution_role_arn" {
  type        = string
  default     = ""
  description = "Enter the role arn you want to use as the ecs execution role"
}


variable "task_cpu" {
  type        = number
  description = "CloudWatch Agent task CPU"
  default     = 128
}


variable "task_memory" {
  type        = number
  description = "CloudWatch Agent task Memory"
  default     = 64
}

variable "image_tag" {
  type        = string
  description = "CloudWatch Agent image tag for amazon/cloudwatch-agent:{image_tag}"
  default     = "1.247347.3b250378"
}


data "template_file" "cwagent_container_mountpoints" {
  template = file("${path.module}/templates/cwagent-container-mountpoints.tpl")
}


data "template_file" "cwagent_task_volumes" {
  template = file("${path.module}/templates/cwagent-task-volumes.tpl")
}


locals {
  prefix        = var.prefix
  suffix        = var.suffix
  temp_app_name = local.prefix == "" ? "cwagent" : "${local.prefix}-cwagent"
  app_name      = local.suffix == "" ? local.temp_app_name : "${local.temp_app_name}-${local.suffix}"
  aws_region    = var.region

  cwagent_container_mountpoints = data.template_file.cwagent_container_mountpoints.rendered
  cwagent_task_cpu              = var.task_cpu
  cwagent_task_memory           = var.task_memory
  cwagent_image_tag             = var.image_tag

  cluster_name                   = var.cluster_name
  task_role_arn                  = var.task_role_arn == "" ? aws_iam_role.cwagent_task_role[0].arn : var.task_role_arn
  task_execution_role_arn        = var.execution_role_arn == "" ? aws_iam_role.cwagent_task_execution_role[0].arn : var.execution_role_arn
  create_iam_task_role           = var.task_role_arn == "" ? 1 : 0
  create_iam_task_execution_role = var.execution_role_arn == "" ? 1 : 0

  cwagent_task_volumes = jsondecode(data.template_file.cwagent_task_volumes.rendered)
}
