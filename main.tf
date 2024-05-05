#variable "autoscaling" {
#  type = tuple([string, string, string])
#  default = ["desired_size", "min_size", "max_size"]
#}
#
#locals {
#  autoscaling_object = tomap({
#  for autoscale in var.autoscaling:
#  autoscale => {size = "2"}
#  })
#}

#resource "aws_eks_node_group" "managed_nodes" {
#
#  cluster_name  = "eks"
#  node_role_arn = "arn"
#  subnet_ids    = ["id1", "id2"]
#
#  scaling_config {
#    min_size     = "1"
#    max_size     = "2"
#    desired_size = "1"
#  }
#}
#
#
#locals {
#  k8s_labels_keys = ["env", "app-group"]
#  k8s_labels_values = ["prod", "service"]
#}
#
#locals {
#  K8s_labels = tomap({
#  for index, key in local.k8s_labels_keys:
#  key => local.k8s_labels_values[index]
#  })
#}

#locals {
#  timeouts_key   = ["create", "update", "delete"]
#  timeouts_value = ["30m", "30m", "30m"]
#}
#
#locals {
#  eks_timeouts = tomap({
#  for index, key in local.timeouts_key :
#  key => local.timeouts_value[index]
#  })
#}


#locals {
#  map_of_values = values(var.assign_generated_ipv6_cidr_block)
#  map_of_keys = keys(var.assign_generated_ipv6_cidr_block)
#}

#locals {
#  list = flatten([
#    for key, value in var.assign_generated_ipv6_cidr_block:
#      [key, value]
#  ])
#}
#
#
#variable "root_block_device" {
#  type = object({
#    volume_type           = string,
#    volume_size           = number,
#    delete_on_termination = bool
#  })
#  // object type that is expecting a string, a number and a bool value
#  default = {
#    "volume_type"           = "gp2"
#    "volume_size"           = 20
#    "delete_on_termination" = true
#  }
#}

variable "access_key" {
  type = string
  default = ""
}
variable "secret_key" {
  type = string
  default = ""
}
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  # Account B credentials
  alias = "account_a"
}

resource "aws_instance" "ec2_instance" {
  provider      = aws.account_a
  ami           = "ami-051f8a213df8bc089"
  instance_type = var.instance_type
}

module "module" {
  source  = "./modules/"
}

#resource "aws_iam_role" "dev-role" {
#  provider = aws.account_a
#  assume_role_policy = ""
#}

#resource "aws_iam_role" "prod-role" {
#  provider = aws.account_a
#  assume_role_policy = jsonencode(
#    {
#      "Version" : "2012-10-17",
#      "Statement" : [
#        {
#          "Effect" : "Allow",
#          "Principal" : {
#            "Service" : "ec2.amazonaws.com"
#          },
#          "Action" : "sts:AssumeRole"
#        }
#      ]
#    }
#  )
#}


#locals {
#  remove_empty_from_values_of_map = compact(values(var.cluster_tags))
#  values_of_map                   = concat(local.remove_empty_from_values_of_map, [2024])
#  keys_of_map                     = keys(var.cluster_tags)
#}
#
#locals {
#  remove_empty_lists = coalescelist(var.subnet_ids, var.extra_subnet_ids)
#  subnet_ids         = compact(local.remove_empty_lists)
#}
#
#locals {
#  public_access_cidrs = tolist([var.control_plane_allowed_cidrs])
#}
#
#locals {
#  cluster_name_with_suffix = format("%s-%s", var.eks_cluster_name, var.eks_cluster_env)
#}
#
#resource "aws_eks_cluster" "cluster" {
#
#  name     = local.cluster_name_with_suffix
#  role_arn = "arn:aws:iam::123456789012:user/infra"
#
#  vpc_config {
#    endpoint_private_access = true
#    endpoint_public_access  = true
#    public_access_cidrs     = local.public_access_cidrs
#    subnet_ids              = local.subnet_ids
#  }
#
#  tags = {
#    cluster_type = local.values_of_map[0]
#    env          = local.values_of_map[1]
#    day          = local.values_of_map[2]
#  }
#  timeouts {
#    create = local.eks_timeouts["create"]
#    update = local.eks_timeouts["update"]
#    delete = local.eks_timeouts["delete"]
#  }
#}
#
#locals {
#  additional_policies = {
#    AmazonEKSCNIPolicy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy "
#  }
#}
#locals {
#  policies_to_be_attached = merge(var.attach_policies, local.additional_policies)
#}
#
#locals {
#  map_of_policies = tomap(local.policies_to_be_attached)
#}
#
#resource "aws_iam_role_policy_attachment" "managed_policy" {
#  for_each = {for k, v in local.policies_to_be_attached : k => v}
#
#  policy_arn = each.value
#  role       = "arn:aws:iam::123456789012:user/infra"
#}
#
#data "aws_iam_policy_document" "eks_control_plane_assume_role_policy" {
#  statement {
#    sid     = "EKSClusterAssumeRole"
#    actions = ["sts:AssumeRole"]
#    principals {
#      type        = "Service"
#      identifiers = ["eks.amazonaws.com"]
#    }
#  }
#}
