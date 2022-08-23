pipeline {
   agent any
   tools{
      maven 'mvn'
   }
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'git', url: 'https://github.com/jigyasumishra321/projectmain.git']]])
                sh "mvn install"
                sh "mvn package -Production"
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t jigyasumishra321/nginx .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'jigyasumishra321', variable: 'dockerlogin')]) {
                      sh 'docker login -u jigyasumishra321 -p ${dockerlogin}'
    
}
                   sh 'docker push jigyasumishra321/nginx'
                }
            }
        }
       stage('Deploy to k8s'){
            steps{
               dir ('/var/lib/jenkins/workspace/project2') {
  
                   sshagent(['kuberneteslogin']) {
                      sh " cd /var/lib/jenkins/workspace/project2 "
                      sh " ls -ltr "
                    sh "scp -o StrictHostKeyChecking=no deploymentservice.yml ubuntu@100.26.43.116:"
                    script{
                        try{
                            sh "ssh ubuntu@100.26.43.116 kubectl apply -f deploymentservice.yml"
                        }catch(error){
                            sh "ssh ubuntu@100.26.43.116 kubectl create -f deploymentservice.yml"
                        }
                        }
                    }
    
}
                   
                    
                }
            }
        
        }
      }

