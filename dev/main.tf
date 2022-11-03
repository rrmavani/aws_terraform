module dev_network {
  source = "../modules/network"

  vpc_cidr_block = var.vpc_cidr_block
  env = var.env
}