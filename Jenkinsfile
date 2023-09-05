def appEnvironmentImage = docker.image('golang:1.21.0');
def ecrRepoUrl;
def appImage;
def deploymentVersion = "${Calendar.instance.format("yyyy-MM-dd_HH-mm-ss")}.${env.BUILD_NUMBER}"

pipeline {
    agent any

    parameters {
        booleanParam(name: 'DEPLOY_ECR_AND_IMAGE', defaultValue: false, description: 'Deploy container repo & update lambda image?')
        booleanParam(name: 'DESTROY_APP', defaultValue: false, description: 'Destroy all application resources?')
    }

    stages {


        stage("Fetch Docker images") {
            when {
                expression {
                    return params.DEPLOY_ECR_AND_IMAGE == true
                }
            }

            steps {
                script {
                    appEnvironmentImage.pull()
                }
            }
        }

        stage("Run tests") {
            when {
                expression {
                    return params.DEPLOY_ECR_AND_IMAGE == true
                }
            }
            steps {
                script {
                    appEnvironmentImage.inside {
                        sh """
                            cd function
                            export GOCACHE=/tmp/.cache
                            make test
                        """
                    }
                }
            }
        }

        stage("Deploy container repository") {
            when {
                expression {
                    return params.DEPLOY_ECR_AND_IMAGE == true
                }
            }
            steps {
                script {
                    sh """
                        cd deployment/container_repository
                        terraform init
                        terraform apply -auto-approve                      
                    """
                    ecrRepoUrl = sh(script: """
                        cd deployment/container_repository
                        terraform output -raw fight_alerts_scraper_ecr_repo_url
                    """, returnStdout: true).trim()
                }
            }
        }

        stage("Bake image") {
            when {
                expression {
                    return params.DEPLOY_ECR_AND_IMAGE == true
                }
            }
            steps {
                script {
                    appImage = docker.build("${ecrRepoUrl}:${deploymentVersion}","function")
                }
            }
        }

        stage("Push image to container repository") {
            when {
                expression {
                    return params.DEPLOY_ECR_AND_IMAGE == true
                }
            }
            steps {
                script {
                    sh """
                        aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin ${ecrRepoUrl}
                        docker push ${ecrRepoUrl}:${deploymentVersion}
                    """
                }
            }
        }

        stage("Deploy application [DEV]") {
            when {
                expression {
                    return params.DESTROY_APP == false
                }
            }
            steps {
                script {
                    sh """
                        cd deployment/function
                        terraform init
                        terraform apply -auto-approve -var="environment=dev"
                    """
                }
            }
        }

        stage("Destroy application") {
            when {
                expression {
                    return params.DESTROY_APP == true
                }
            }
            steps {
                script {
                    sh """
                        cd deployment/function
                        terraform init
                        terraform destroy -auto-approve -var="environment=dev"
                    """
                }
            }
        }
    }
}