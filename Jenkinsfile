def appEnvironmentImage = docker.image('golang:1.21.0');
def ecrRepoUrl;
def appImage;
def deploymentVersion = "${Calendar.instance.format("yyyy-MM-dd_HH-mm-ss")}.${env.BUILD_NUMBER}"

pipeline {
    agent any

    stages {
        // stage("Fetch Docker images") {
        //     steps {
        //         script {
        //             appEnvironmentImage.pull()
        //         }
        //     }
        // }

        // stage("Run tests") {
        //     steps {
        //         script {
        //             appEnvironmentImage.inside {
        //                 sh """
        //                     cd function
        //                     export GOCACHE=/tmp/.cache
        //                     make test
        //                 """
        //             }
        //         }
        //     }
        // }

        // stage("Deploy container repository") {
        //     steps {
        //         script {
        //             sh """
        //                 cd deployment/container_repository
        //                 terraform init
        //                 terraform apply -auto-approve                        
        //             """
        //             ecrRepoUrl = sh(script: """
        //                 cd deployment/container_repository
        //                 terraform output -raw fight_alerts_scraper_ecr_repo_url
        //             """, returnStdout: true).trim()
        //         }
        //     }
        // }

        // stage("Bake image") {
        //     steps {
        //         script {
        //             appImage = docker.build("${ecrRepoUrl}:${deploymentVersion}","function")
        //         }
        //     }
        // }

        // stage("Push image to container repository") {
        //     steps {
        //         script {
        //             sh """
        //                 aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin ${ecrRepoUrl}
        //                 docker push ${ecrRepoUrl}:${deploymentVersion}
        //                 docker tag ${ecrRepoUrl}:${deploymentVersion} ${ecrRepoUrl}:latest
        //                 docker push ${ecrRepoUrl}:latest
        //             """
        //         }
        //     }
        // }

        stage("Deploy serverless function") {
            steps {
                script {
                    sh """
                        cd deployment/function
                        terraform init
                        terraform apply -auto-approve
                    """
                }
            }
        }
    }
}