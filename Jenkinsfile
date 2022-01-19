pipeline {
    agent any 
 
    stages {
           
           stage("Clone Repo"){
            steps{
                    git(url: 'https://github.com/yusufluaii/sdc-final-project.git', branch: 'main')
            }
        }

        stage('static code analysis') {
            agent {
                docker { image 'sonarsource/sonar-scanner-cli' }
            }
            steps {
                script {    
                 sh "sonar-scanner -Dsonar.host.url=http://18.138.81.183:9000/ -Dsonar.login=40541cfa9e0b304ca9eed3e8e27a483fee8dc547   -Dsonar.projectKey=todo-app"
                    }
            }
        }
        
        stage('Build Image'){
            steps{
                script{
                        commit_id = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
                        sh "docker build -t yusufluai/todo-app_client:$commit_id  ."
                        sh "docker build -t yusufluai/todo-app_server:$commit_id  backend"
                       
                    }
            }
        }
         stage("Push Image"){
            steps{
                script{
                commit_id = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
                sh "cat $HOME/creds.txt | docker login -u yusufluai --password-stdin"
                sh "docker push yusufluai/todo-app_client:$commit_id"
                sh "docker push yusufluai/todo-app_server:$commit_id"
                }
            }
        }
        
        stage("Clean Local Image"){
            steps{
                sh("docker image prune -a --force")
            }
        }
        
        stage("Change Image Tag"){
            steps{
                script{
                    commit_id = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
                    sh 'ls k8s/production/backend'
                    sh "sed -i 's/IMAGE_TAG/$commit_id/g' k8s/production/frontend/client-dpy.yaml"
                    sh "sed -i 's/IMAGE_TAG/$commit_id/g' k8s/production/backend/backend-dpy.yaml"
                    sh "sed -i 's/IMAGE_TAG/$commit_id/g' k8s/staging/frontend/client-dpy.yaml"
                    sh "sed -i 's/IMAGE_TAG/$commit_id/g' k8s/staging/backend/backend-dpy.yaml"
                }
               
            }
        }
        
        stage("Apply k8s Yaml Manifest To Cluster"){
            steps{
                sh("kubectl apply -f k8s/staging/frontend")
                sh("kubectl apply -f k8s/staging/backend")
            }
            post{
                success {
                    sh("kubectl apply -f k8s/production/frontend")
                    sh("kubectl apply -f k8s/production/backend")
                }
                always{
                    emailext body: 'Please accept input if the staging environment runs smoothly.', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'deploy to  production?'
                    input(message: 'Proceed or abort?', ok: 'Deploy to production')
                    
                }
                
            }
        }
        

    }
}