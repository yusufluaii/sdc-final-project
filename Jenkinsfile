pipeline {
    agent any 
 
    stages {
           
        stage("Clone Repo"){
            steps{
                    git(url: 'https://github.com/yusufluaii/sdc-final-project.git', branch: 'main')
                    script{
                        commit_id = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
                    }
                    
                
            }
        }

        stage('static code analysis') {
            agent {
                docker { image 'sonarsource/sonar-scanner-cli' }
            }
            steps {
                script {    
                 sh "sonar-scanner -Dsonar.host.url=http://13.212.184.179:9000/ -Dsonar.login=df0ed68381ea738cc506195d2cb5f9c677410516   -Dsonar.projectKey=todo-app"
                    }
            }
        }
        
        stage('Build Image'){
            steps{
                sh('docker build -t yusufluai/todo-app_client:${commit_id} .')
                sh('docker build -t yusufluai/todo-app_server:${commit_id} backend')
            }
        }


        // stage("Push Image"){
        //     steps{
        //         sh('cat $HOME/creds.txt | docker login -u yusufluai --password-stdin')
        //         sh('docker push yusufluai/todo-app_client:${commit_id}')
        //         sh('docker push yusufluai/todo-app_server:${commit_id}')
        //     }
        // }
            
        // stage("Change Image Tag"){
        //     steps{
        //         sh("sed 's/IMAGE_TAG/${commit_id}/' ")
        //     }
        // }
        // stage("Apply k8s Yaml Manifest To Staging Environtment"){
        //     steps{
        //         echo "Hello Staging"
        //     }
        // }

    }
}