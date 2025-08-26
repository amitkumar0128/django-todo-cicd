pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning the repo'
                git url: "https://github.com/amitkumar0128/django-todo-docker", branch: "main"
            }
        }

        stage('Infrastructure Provisioning') {
            steps {
                echo 'Provisioning Infrastructure with Terraform'

                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    dir('terraform') {
                        sh '''
                          pwd
                          ls
                          terraform init
                          terraform validate
                          terraform plan
                          terraform apply -auto-approve
                          terraform output -json > tf_outputs.json
                          jq -r '.web_server_ips.value[] | "[webservers]\\n" + . + " ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/todo-app-key.pem"' tf_outputs.json > ../ansible/inventory.ini
                          '''
                    }
                }
            }
        }
        stage('Wait for SSH') {
            steps {
                dir('terraform') {
                    sh '''
                    echo "Waiting for SSH to come up on provisioned instances..."
                    jq -r '.web_server_ips.value[]' tf_outputs.json | while read ip; do
                        echo "Waiting for SSH on $ip ..."
                        while ! nc -z -w5 $ip 22; do
                            echo "Still waiting for SSH on $ip..."
                            sleep 5
                        done
                        echo "SSH is ready on $ip"
                    done
                    '''
                }
            }
        }
        stage('Ansible') {
            steps {
                dir('ansible') {
                    sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini playbook.yml'
                }
            }
        }
        stage('Destroy Infrastructure') {
            steps {
                script {
                    def userInput = input(
                        id: 'DestroyConfirm', message: 'Destroy infrastructure?', parameters: [
                            [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Check to confirm destruction', name: 'Confirm']
                        ]
                    )
        
                    if (userInput == true) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                            dir('terraform') {
                                sh '''
                                  terraform destroy -auto-approve
                                '''
                            }
                        }
                    } else {
                        echo 'Skipping destruction...'
                    }
                }
            }
        }
    }
}
