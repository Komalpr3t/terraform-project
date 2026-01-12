pipeline {
    agent any

    environment {
        // AWS credentials from Jenkins
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')

        TF_VAR_FILE = ""
        ENV_NAME    = ""
    }

    stages {

        stage('Detect Branch & Select Environment') {
            steps {
                script {
                    echo "========================================"
                    echo "Git Branch Detected : ${env.BRANCH_NAME}"

                    if (env.BRANCH_NAME == 'main') {
                        ENV_NAME    = 'prod'
                        TF_VAR_FILE = 'prod.tfvars'
                    } else if (env.BRANCH_NAME == 'develop') {
                        ENV_NAME    = 'dev'
                        TF_VAR_FILE = 'dev.tfvars'
                    } else {
                        error("Unsupported branch: ${env.BRANCH_NAME}")
                    }

                    echo "Selected Environment : ${ENV_NAME}"
                    echo "Terraform Vars File  : ${TF_VAR_FILE}"
                    echo "AWS Region           : us-east-1"
                    echo "========================================"
                }
            }
        }

        stage('Terraform Init') {
            steps {
                bat 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                bat "terraform plan -var-file=%TF_VAR_FILE%"
            }
        }

        stage('Terraform Apply') {
            steps {
                bat "terraform apply -auto-approve -var-file=%TF_VAR_FILE%"
            }
        }
    }
}
