terraform {
  required_version = ">= 0.10.0"
}
data "github_repository" "kratos" {
  full_name = "hashicorp/terraform"
}



module "create_vpc" {
  source = "./modules/aws/create-vpc"
}

// -------------------------------------

module "http_c2" {
  source = "./modules/aws/http-c2"

  vpc_id = "${module.create_vpc.vpc_id}"
  subnet_id = "${module.create_vpc.subnet_id}"

  //install = ["./scripts/empire.sh"]
}

