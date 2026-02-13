module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
  cluster_name = var.cluster_name
}

module "eks" {
  source = "./modules/eks"

  cluster_name        = var.cluster_name
  subnet_ids          = module.vpc.subnet_ids
  vpc_id              = module.vpc.vpc_id
  node_instance_type  = var.node_instance_type
  desired_nodes       = var.desired_nodes
  cluster_role_arn    = module.iam.cluster_role_arn
  node_role_arn       = module.iam.node_role_arn
}

module "alb" {
  source       = "./modules/alb"
  cluster_name = var.cluster_name

  depends_on = [module.eks]
}
module "rds" {
  source = "./modules/rds"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.subnet_ids   
}
