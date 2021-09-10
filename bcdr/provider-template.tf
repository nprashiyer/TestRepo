terraform {
  backend "remote" {
    organization = "prash-tf-test"

    workspaces {
      name = "WORKSPACE-NAME"
    }
  }
}