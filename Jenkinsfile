pipeline {
    agent any

    environment {
        // AWS credentials stored securely in Jenkins
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

    stages {

        stage('Detect Branch & Select Environment') {
            steps {
                script {
                    echo "========================================"
                    echo "Git Branch Detected : ${env.BRANCH_NAME}"

                    if (env.BRANCH_NAME == 'develop') {
                        env.ENV_NAME    = 'dev'
                        env.TF_VAR_FILE = 'dev.tfvars'
                    }
                    else if (env.BRANCH_NAME == 'main') {
                        env.ENV_NAME    = 'prod'
                        env.TF_VAR_FILE = 'prod.tfvars'
                    }
                    else {
                        error("Unsupported branch: ${env.BRANCH_NAME}")
                    }

                    echo "Selected Environment : ${env.ENV_NAME}"
                    echo "Terraform Vars File  : ${env.TF_VAR_FILE}"
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
                script {
                    echo "Applying Terraform for ${env.ENV_NAME} environment"
                    bat "terraform apply -auto-approve -var-file=%TF_VAR_FILE%"
                }
            }
        }
    }
}
