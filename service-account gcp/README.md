# Google Cloud Platform Service Account Terraform Module
Terraform module for creating a service account in Google Cloud Platform. The module supports granting multiple roles to the service account and creating a private key. 

# Setup

1st you have to create ```service-account.json``` inside the  ```credentials``` dir in the root directory before running which would contain your service ```Account Key```  file.

This contains your authentication required for Terraform to talk to the Google API.

You can get it under 
```
Google Cloud Platform -> API Manager -> Credentials -> Create Credentials -> Service account key.
```
For the Key type field chose JSON. Put the downloaded file right were your Terraform config file is and name it ```service-account.json```.

If you are using the gcs as the backend, you will need to give it the ```Service Account Admin``` role for the ```service-account``` permission.

# In order to do so we are going to create 3 files:

```main.tf``` -- contains the definition of what we want to achieve

```variables.tf``` -- contains the variables definition.  

```outputs.tf``` -- contains output with values and descriptions.



# Variables

```variables.tf``` holds the definition of the elements that can be configured in your
deployment script.


From now on every time you run a ```terraform``` commands ```{plan|apply|destroy|...}``` you will need to provide the required variables. Without further information ```terraform``` will enter an interactive mode requesting each variables one by one at the prompt.


# Initialize working directory.

The first command that should be run after writing a new Terraform configuration is the terraform init command in order to initialize a working directory containing Terraform configuration files. It is safe to run this command multiple times.
```
terraform init
```
# Configure  service account.

You must modify the Google Cloud , region,namespace and environment  which is defined as an input variable bucket_name in variables.tf file.


Run command:

```terraform plan ```   Displays what would be executed

# Deploy the changes.

Run command:

```terraform apply```    Applies the changes

Test the deploy.

When the ```terraform apply``` command completes, use the ```Google Cloud console```, you should see the new ```Google Service Account``` for create Kubernetes Engine Cluster.



## Usage

```ruby
module "service_account_for_cloud_sql" {
    source       = "git@github.com:tsadoklf/terraform-google-service-account.git?ref=master"
    account_id   = "my-service-account-for-cloud-sql"
    display_name = "my service account for cloud sql"
    roles        = ["roles/cloudsql.client", "roles/cloudsql.editor"]
}
```

if you need to create a Kubernetes Secret you can use the 'decoded_private_key' output as follows (note that you need to configure the 'kubernetes' provider): 

```ruby
provider "kubernetes" {
    ...
    ...
    ...
}
resource "kubernetes_secret" "cloudsql-instance-credentials" {
    depends_on      = ["module.service_account_for_cloud_sql"]
    metadata {
        name = "cloudsql-instance-credentials"
    }
    data {
        credentials.json = "${module.service_account_for_cloud_sql.decoded_private_key}"
    }
}

```

## Inputs

| Name                  | Description                                              |  Type  | Default | Required |
|:----------------------|:---------------------------------------------------------|:------:|:-------:|:--------:|
| `account_id`          | The service account ID.                                  | string |    -    |   yes    |
| `display_name`        | The display name for the service account.                | string |   ``    |   no     |
| `roles`               | The roles that will be granted.                          | list   |    -    |   no     |

## Outputs

| Name                  | Description                                              |
|:----------------------|:---------------------------------------------------------|
| `email`               | The e-mail address of the service account.               |
| `name`                | The fully-qualified name of the service account.         |
| `unique_id`           | The unique id of the service account.                    |
| `private_key`         | The private key that was create for the account.         |
| `decoded_private_key` | The base64 decoded private key.                          |

For change or add more roles,   
you can use this link:  
https://cloud.google.com/iam/docs/understanding-roles?&_ga=2.74084561.-2117374167.1545018634#kubernetes-engine-roles
