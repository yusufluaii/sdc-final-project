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
                    sh "sonar-scanner -Dsonar.host.url=http://175.41.167.190:9000/ -Dsonar.login=16a7aa8a045a79bfeec0f7fe55f4c4ebb05cc383 -Dsonar.projectKey=sdc-final-project"
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

        stage('Deploy to kubernetes yaml manifest'){
            steps{
            }
        }
    }
}
