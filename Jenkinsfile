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

        stage('static code analysis') {
            agent {
                docker { image 'sonarsource/sonar-scanner-cli' }
            }
            steps {
                script {
                sh "sonar-scanner -Dsonar.host.url=http://18.139.209.41:9000/ -Dsonar.login=42b7422f12d1e4d9f668e705cb1d98e661dc9257   -Dsonar.projectKey=todo-app"
                }
            }
        }
      
      stage('Build Image'){
            steps{
                sh('docker build -t yusufluai/todo-app_client:$BUILD_NUMBER .')
                sh('docker build -t yusufluai/todo-app_server:$BUILD_NUMBER backend')
            }
        }


      stage("Push Image"){
            steps{
                sh('cat $HOME/creds.txt | docker login -u yusufluai --password-stdin')
                sh('docker push yusufluai/todo-app_client:$BUILD_NUMBER')
                sh('docker push yusufluai/todo-app_server:$BUILD_NUMBER')
            }
        }

      stage("Apply k8s Yaml Manifest To Staging Environtment"){
          steps{

          }
      }

    }
}
