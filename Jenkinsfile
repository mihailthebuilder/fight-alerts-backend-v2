def goImage = docker.image('golang:1.17.0');

pipeline {
    agent any

    stages {
        stage("Mirror image") {
            scripts {
                goImage.pull()
            }
        }

        stage("test") {
            steps {
                sh """
                    echo 'Hello world'
                """
            }
        }
    }
}