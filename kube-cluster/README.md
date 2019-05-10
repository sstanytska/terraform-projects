
# Google Cloud Platform Kubernetes Cluster Terraform Module
Use this Terraform module to easily create a Kubernetes cluster on Google Cloud Platform (GCP)'s Google Kubernetes Engine (GKE).

# In order to do so we are going to create four files:

```kube-cluster.tf``` -- contains the definition of what we want to achieve

```variables.tf``` -- contains the variables definition.

```config.tfvars``` -- contains the values for variables.



# Variables

```variables.tf``` holds the definition of the elements that can be configured in your
deployment script.


From now on every time you run a ```terraform``` commands ```{plan|apply|destroy|...}``` you will need to provide the required variables. Without further information ```terraform``` will enter an interactive mode requesting each variables one by one at the prompt.

If you do not want to set these values on every run you can create a file called ```config.tfvars```

# Architecture

Now that we know what we want to build and also how we want to parametrize our script we are ready to build the ```kube-cluster.tf```  The code snippets below are extracted from this file.


# Initialize working directory.

The first command that should be run after writing a new Terraform configuration is the terraform init command in order to initialize a working directory containing Terraform configuration files. It is safe to run this command multiple times.
```
terraform init
```
# Configure  storage bucket name.

You must modify the Google Cloud Storage bucket name, region,namespace and environment  which is defined as an input variable bucket_name in variables.tf file.


Run command:

```terraform plan -var-file=config.tfvars```   Displays what would be executed

# Deploy the changes.

Run command:

```terraform apply  -var-file=config.tfvars```    Applies the changes

Test the deploy.

When the ```terraform apply``` command completes, use the ```Google Cloud console```, you should see the new ```Kubernetes Engine``` created one ```Cluster``` with 2 ```nodes```.


## Provider

```ruby
provider "google" {
  credentials = "${file("${var.cpath}")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}
```

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