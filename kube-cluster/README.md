
# Google Cloud Platform Kubernetes Cluster Terraform Module

## Usage
## cluster with default node pool on preemptible

```ruby
module "primary-cluster" {
  name                   = "${terraform.workspace}"
  source                 = "russmedia/kubernetes-cluster/google"
  version                = "2.0.0"
  region                 = "${var.google_region}"
  zones                  = "${var.google_zones}"
  project                = "${var.project}"
  environment            = "${terraform.workspace}" 
  min_master_version     = "${var.master_version}"
}
```  
and in provider:

```ruby
provider "google" {
  credentials = "${file("${var.cpath}")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}
```

## Inputs

| Name                  | Description                                         |  Type  | Default | Required |
|:----------------------|:----------------------------------------------------|:------:|:-------:|:--------:|
| `name`                | The name of the cluster.                            | string |    -           |  yes   |
| `network`             | The name of the network                             | string |    -           |  yes   |
| `subnetwork`          | The name of the subnetwork.                         | string |    -           |  yes   |
| `zone`                | The name of the zone.                               | string |    -           |  yes   |
| `additional_zones`    | The names of the additional zones.                  | list   |    -           |  no    |
| `usrname`             | The username.                                       | string | "admin"        |  no    |	
| `passworde`	        | The password.	                                      | string | random         |  no    |
| `initial_node_count`	| The intial number of nodes.                         | string | "1"	        |  no    |
| `machine_type`	    | The machine type of the cluster's nodes.	          |string  |"n1-standard-1" |  no    |