# =========================
# EKS CLUSTER
# =========================
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    var.cluster_role_arn
  ]
}

# =========================
# NODE GROUP
# =========================
resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_nodes
    max_size     = var.desired_nodes
    min_size     = 1
  }

  instance_types = [var.node_instance_type]

  depends_on = [
    aws_eks_cluster.eks
  ]
}
