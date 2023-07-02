remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
  }

  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
}

terraform {
  source = "../..///"
  extra_arguments "common_var" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]
  }
}

inputs = {
  region = "us-east-2"
  environment = "dev"
  emails = ["omers@aidoc.com"]
  raise_amount_percent = "100.0"
}