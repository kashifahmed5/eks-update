module "eks" {
  source          = "./eks"
  CLUSTER_NAME    = var.CLUSTER_NAME
  CLUSTER_VERSION = var.CLUSTER_VERSION
  WORKERS_SUBNETS = var.WORKERS_SUBNETS
  INSTANCE_TYPES  = var.INSTANCE_TYPES
  API_SUBNET      = var.API_SUBNET
  VPC_ID          = var.VPC_ID

}




resource "time_sleep" "wait_100s" {
  depends_on      = [module.eks]
  create_duration = "100s"
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.CLUSTER_ID

}

# resource "kubernetes_config_map_v1_data" "aws_auth" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }
#   data = {
#     "mapRoles" = yamlencode(module.eks.NODE_GROUP_ARN.mapRoles)
#     "mapUsers" = yamlencode(module.eks.NODE_GROUP_ARN.mapUsers)
#   }
#   force      = true
#   depends_on = [time_sleep.wait_100s]
# }
