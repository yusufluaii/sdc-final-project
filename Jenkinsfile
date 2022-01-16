pipeline {
    agent any 
    triggers {
        pollSCM '* * * * *'
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Unit Testing') {
            agent {
                docker { image 'sonarsource/sonar-scanner-cli' }
            }
            steps {
                script {
                    sh "sonar-scanner -Dsonar.host.url=http://13.250.101.58/ -Dsonar.login=7a29496fa90a9a62f69e7dd765fa9dc06156d51d
                    -Dsonar.projectKey=todo-app"
                }
                 
            }
        }
        stage('Build Image & Push'){
            steps{
                sh('docker build -t yusufluai/todo-app_client:$BUILD_NUMBER .')
                sh('docker build -t yusufluai/todo-app_server:$BUILD_NUMBER backend')
                sh('cat $HOME/creds.txt | docker login -u yusufluai --password-stdin')
                sh('docker push yusufluai/todo-app_client:$BUILD_NUMBER')
                sh('docker push yusufluai/todo-app_server:$BUILD_NUMBER')
                
            }
        }

        stage('Deploy to Production environtment'){
            steps{
            }
        }
    }
}
