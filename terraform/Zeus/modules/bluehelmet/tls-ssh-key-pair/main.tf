module "ssh_key_pair" {
  source                = "git::https://github.com/cloudposse/terraform-tls-ssh-key-pair.git?ref=master"
  namespace             = "cp"
  stage                 = "prod"
  name                  = "app"
  ssh_public_key_path   = "/secrets"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
  chmod_command         = "chmod 600 %v"
}