
# Google Cloud Platform Kubernetes Cluster Terraform Module

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