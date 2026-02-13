variable "cluster_name" {
  default = "todo-eks"
}

variable "region" {
  default = "ap-south-1"
}

variable "node_instance_type" {
  default = "c7i-flex.large"
}

variable "desired_nodes" {
  default = 1
}
