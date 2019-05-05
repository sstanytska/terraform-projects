# Google Cloud Platform Service Account Terraform Module
Terraform module for creating a service account in Google Cloud Platform. The module supports granting multiple roles to the service account and creating a private key. 

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

