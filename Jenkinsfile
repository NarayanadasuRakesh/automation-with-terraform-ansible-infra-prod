pipeline {
    agent {
        node { label 'node1' }
    }
    options {
        ansiColor('xterm')
    }
    stages {
        stage('VPC') {
            steps {
                sh '''
                    cd 01-vpc
                    terraform init -reconfigure
                    terraform apply -auto-approve
                '''
            }
        }
        stage('SG') {
            steps {
                sh '''
                    cd 02-sg
                    terraform init -reconfigure
                    terraform apply -auto-approve
                '''
            }
        }
        stage('VPN') {
            steps {
                sh '''
                    cd 03-vpn
                    terraform init -reconfigure
                    terraform apply -auto-approve
                '''
            }
        }
        stage('DB and APP-ALB') {
            input {
                message "Should we continue?"
                ok "Yes, we should"
            }
            parallel {
                stage('DB') {
                    steps {
                        sh '''
                            cd 04-databases
                            terraform init -reconfigure
                            terraform apply -auto-approve
                        '''
                    }
                }
                stage('APP-ALB') {
                    steps {
                        sh '''
                            cd 05-app-alb
                            terraform init -reconfigure
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
    }
}