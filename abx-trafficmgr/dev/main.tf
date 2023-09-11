module "config" {
  source   = "../_config"
  settings = local.settings
}

module "global" {
  source   = "../_global"
  config = module.config.config
}
