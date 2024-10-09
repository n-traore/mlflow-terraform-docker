Set up an MLflow instance on your local machine using docker and terraform, with minio as artifact storage.

## Setup

### 1. Clone the repo
```bash
git clone https://github.com/n-traore/mlflow-terraform-docker.git && \
cd mlflow-terraform-docker
```

### 2. Source the setup_teraform script
```bash
source setup_terraform
```

### 3. Run terraform commands to create the instance
This will setup a MLflow tracking server, a postgres database and a S3-like bucket in minio for artifact storage.
```bash
terraform init

# to check the resources that will be created
terraform plan

# create
terraform apply --auto-approve
```
- Visit http://localhost:8090 for the MLflow UI
- Visit http://localhost:9100 for the minio UI
- You can find the minio bucket credentials at modules/mlflow/mounts/shares/creds_`YOUR_BUCKET_NAME`.txt (default bucket name is mlflow)

### 4. Clean-up
Delete the instance by running the following command:
```bash
terraform destroy --auto-approve
```
