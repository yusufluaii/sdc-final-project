pipeline {
    agent any 
    triggers {
        pollSCM '* * * * *'
    }
    stages {
<<<<<<< HEAD
        stage('Checkout scm') {
            steps{
                git branch: 'master', url: 'https://github.com/yusufluaii/jenkins-study.git'
                
            }
            post{
                success{
                    echo "Checkout source code success"
                }
                failure{
                    echo "invalid url or credentials"
                }
            }
        }
=======
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
            

>>>>>>> 797cd464a81362303342f86194fc35ce606ca58b
        stage('Build Image & Push'){
            steps{
                sh('docker build -t yusufluai/mern-todo-app_client:$BUILD_NUMBER .')
                sh('docker build -t yusufluai/mern-todo-app_server:$BUILD_NUMBER backend')
                sh('cat $HOME/creds.txt | docker login -u yusufluai --password-stdin')
                sh('docker push yusufluai/mern-todo-app_client:$BUILD_NUMBER')
                sh('docker push yusufluai/mern-todo-app_server:$BUILD_NUMBER')
                
            }
        }
        stage('Deploy to Production environtment'){
            steps{
                echo("Hello Staging")
            }
        }
    }
}
