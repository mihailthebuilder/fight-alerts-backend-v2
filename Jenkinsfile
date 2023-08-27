pipeline {
    agent any

    stages {
        def goImage = docker.image('golang:1.17.0');

        stage("Mirror image") {
            goImage.pull()
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