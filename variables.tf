variable "instance_type" {
  type    = string // string type value
  default = "t2.micro"
}
#
#variable "ebs_optimized" {
#  type    = bool // boolean type value
#  default = true
#}
#
#variable "instance_tenancy" {
#  type    = list(string) // list type that accepts string values
#  default = ["default", "dedicated", "host"]
#}
#
#locals {
#  string_of_instance_tenancy = join(", ", var.instance_tenancy)
#}
#
#variable "security_group_ids" {
#  type    = set(string) // set type that accepts string values
#  default = ["sg-02ce123456e7893c7", "sg-02ce123456e7894c7", "sg-02ce123456e7893c7"]
#}
#
#variable "metadata_options" {
#  type    = map(string) // map type that accepts string keys and string values
#  default = {
#    http_endpoint               = "enabled"
#    http_tokens                 = "required"
#    http_put_response_hop_limit = "2"
#  }
#}
#
#variable "cidr_block" {
#  type    = string // string type value
#  default = "10.0.0.0/16"
#}
#
#variable "assign_generated_ipv6_cidr_block" {
#  type    = map(string) // map type that accepts string keys and string values
#  default = {
#    False = "false"
#    True  = "true"
#  }
#}
#
#variable "projectDuration" {
#  type    = number // number type value
#  default = 28
#}
#
#variable "number_of_instances" {
#  type    = number // number type value
#  default = 2
#}
#
#variable "associate_public_ip_address" {
#  type    = bool // number type value
#  default = true
#}
#
#variable "launchDate" {
#  type    = tuple([number, string]) // tuple type that accepts list which accepts two values, the a number and a string
#  default = [4, "September"]
#}
#
##variable "projectArchitecture" {
##  type = object({style = string, resourceNumber = number}) // object type that is expecting a string value and a number value
##  default = {
##    style = "Serverless"
##    resourceNumber = 7
##  }
##}
#
##variable "aws_name" {
##  type = string // string type variable
##  default = "my_vpc"
##}
#
#variable "control_plane_allowed_cidrs" {
#  type    = string  // string type value
#  default = "0.0.0.0/0"
#}
#
#variable "subnet_ids" {
#  type    = list(string)  // list of string type value
#  default = ["subnet-01234567890abcdef", "subnet-01234567891abcdef", ""]
#}
#
#variable "extra_subnet_ids" {
#  type    = list(list(string))  // list of string type value
#  default = [[""], ["subnet-01234567892abcdef"]]
#}
#
#variable "cluster_tags" {
#  type    = map(string)   // map of string type value
#  default = {
#    env           = "dev"
#    cluster-type  = "dedicated"
#    creation_date = ""
#  }
#}

#variable "eks_cluster_name" {
#  type    = string // string type value
#  default = "eks-cluster"
#}
#
#variable "eks_cluster_env" {
#  type    = string // string type value
#  default = "non-prod"
#}
#
#variable "attach_policies" {
#  type    = map(string)   // map of string type value
#  default = {
#    AmazonEKSClusterPolicy         = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
#    AmazonEKSVPCResourceController = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
#    AmazonEKSServicePolicy         = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
#  }
#}
#
#variable "list_of_objects" {
#  type = list(object({
#    name = string
#    type = string
#  }))
#  default = [
#    {
#      name = "Orange"
#      type = "Fruit"
#    },
#    {
#      name = "Potato"
#      type = "Vegetable"
#    }
#  ]
#}
#locals {
#  my_map = tomap({ for obj in var.list_of_objects : obj.name => obj })
#}


##variable "security_groups" {
##  type = list(object({
##    name = string
##    rules = list(object({
##      from_port   = number
##      to_port     = number
##      protocol    = string
##      cidr_blocks = list(string)
##    }))
##  }))
##  default = [
##    {
##      name = "eks-cluster-sg"
##      rules = [
##        {
##          from_port = 0
##          to_port   = -1
##          protocol  = "http"
##          cidr_blocks = [
##            "0.0.0.0/0", "255.255.255.255./255"
##          ]
##        }
##      ]
##    },
##  ]
##}
##
##resource "aws_security_group" "main" {
##  for_each = { for sg in var.security_groups : sg.name => sg }
##  name     = each.value.name
##  vpc_id   = "vpc-123abc"
##}
##
##locals {
##  security_group_rule_list = toset(flatten([
##    for sg in var.security_groups : [
##      for rule in sg.rules : {
##        sg_name     = sg.name
##        from_port   = rule.from_port
##        to_port     = rule.to_port
##        protocol    = rule.protocol
##        cidr_blocks = rule.cidr_blocks
##      }
##    ]
##  ]))
##}
#
##resource "aws_security_group_rule" "main" {
##  for_each = toset(flatten([
##  for sg in var.security_groups : [
##  for rule in sg.rules : {
##    sg_name     = sg.name
##    from_port   = rule.from_port
##    to_port     = rule.to_port
##    protocol    = rule.protocol
##    cidr_blocks = rule.cidr_blocks
##  }
##  ]
##  ]))
##
##  type              = each.value.type
##  from_port         = each.value.from_port
##  to_port           = each.value.to_port
##  protocol          = each.value.protocol
##  cidr_blocks       = each.value.cidr_blocks
##  security_group_id = aws_security_group.main[each.value.sg_name].id
##}
#
##In this example, the flatten function transforms a complex, nested list of security groups and their rules into a flat list of rules.This flattened list is then iterated over to create individual aws_security_group_rule resources for each rule, dynamically associating them with their respective security groups.
##
##This approach simplifies managing complex configurations, especially when dealing with resources that have multiple, nested configurations, showcasing the power and flexibility of the flatten function in Terraform.
#
##variable "user_policies" {
##  type = list(map(object({
##    name        = string
##    permissions = list(string)
##  })))
##  default = [
##    {
##      "assume_role_policy" = {
##        name        = "policy1"
##        permissions = ["sts:AssumeRole"]
##      }
##    },
##    {
##      "encryption_policy" = {
##        name        = "policy3"
##        permissions = ["s3:ListBucket"]
##      }
##    }
##  ]
##}
