terraform {
  required_providers {
    kestra = {
      source  = "kestra-io/kestra"
      version = "~> 0.18.0"
    }
  }
}

provider "kestra" {
  url = "http://localhost:8080"
}

resource "kestra_flow" "flows" {
  for_each  = fileset(path.module, "flows/*.yml")
  flow_id   = yamldecode(templatefile(each.value, {}))["id"]
  namespace = yamldecode(templatefile(each.value, {}))["namespace"]
  content   = templatefile(each.value, {})
}

resource "kestra_namespace_file" "event" {
  namespace = "demo"
  filename  = "event.json"
  content   = file("event.json")
}
