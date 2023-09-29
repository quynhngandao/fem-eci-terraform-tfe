terraform {
  cloud {
    organization = "daoquynh29"

    workspaces {
      name = "fem-eci-workspace"
    }
  }
}