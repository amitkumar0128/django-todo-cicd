@Library("Shared") _
pipeline {
    agent any
    stages {
        stage("Code") {
            steps {
                script {
                    clone("https://github.com/amitkumar0128/django-todo-docker.git","main")
                }
            }
        }
        stage("Build") {
            steps {
                script {
                    docker_build("akj49", "django-todo-app", "latest", ".")
                    docker_build("akj49", "django-nginx", "latest", "./nginx/")
                }
            }
        }
        stage("Push") {
            steps {
                script {
                    docker_push("akj49", "django-todo-app", "latest")
                    docker_push("akj49", "django-nginx", "latest")
                }
            }
        }
        stage("Deploy") {
            steps {
                script {
                    docker_deploy()
                }
            }
        }
    }
}
