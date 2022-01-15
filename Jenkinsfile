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
            

        stage('Build Image & Push'){
            steps{
                sh('docker build -t yusufluai/mern-todo-app_client:$BUILD_NUMBER .')
                sh('docker build -t yusufluai/mern-todo-app_server:$BUILD_NUMBER backend')
                sh('cat $HOME/creds.txt | docker login -u yusufluai --password-stdin')
                sh('docker push yusufluai/mern-todo-app_client:$BUILD_NUMBER')
                sh('docker push yusufluai/mern-todo-app_server:$BUILD_NUMBER')
                
            }
        }

        stage('Deploy to staging environtment'){
            steps{
                echo("Hello Staging")
            }
        }
    }
}
