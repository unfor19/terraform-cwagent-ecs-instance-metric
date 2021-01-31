data "template_file" "cwagent_container_definitions" {
  template = file("${path.module}/templates/cwagent-container-definitions.tpl")

  vars = {
    log_group_region = local.aws_region
    app_name         = local.app_name
    mount_points     = local.cwagent_container_mountpoints
    image_tag        = local.cwagent_image_tag
  }
}


resource "aws_ecs_task_definition" "cwagent" {
  family                = local.app_name
  container_definitions = data.template_file.cwagent_container_definitions.rendered

  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  task_role_arn            = local.task_role_arn
  execution_role_arn       = local.task_execution_role_arn

  cpu    = local.cwagent_task_cpu
  memory = local.cwagent_task_memory

  dynamic "volume" {
    for_each = [for v in local.cwagent_task_volumes : {
      name      = v.Name
      host_path = v.Host.SourcePath
    }]

    content {
      name      = volume.value.name
      host_path = volume.value.host_path
    }
  }

}


resource "aws_ecs_service" "cwagent" {
  name                = local.app_name
  cluster             = local.cluster_name
  task_definition     = aws_ecs_task_definition.cwagent.arn
  scheduling_strategy = "DAEMON"

  placement_constraints {
    type = "distinctInstance"
  }
}
