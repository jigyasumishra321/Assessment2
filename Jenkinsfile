pipeline {
   agent any
   tools{
      maven 'mvn'
   }
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'ccd24821-35a0-44c7-8bcc-1e46bd490eae', url: 'https://github.com/jigyasumishra321/Assessment2.git']]])
                sh "mvn clean install"
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
                   withCredentials([string(credentialsId: 'jigyasumishra321', variable: 'dockerlogin')]){
                      sh 'docker login -u jigyasumishra321 -p ${dockerlogin}'
    
}
                   sh 'docker push jigyasumishra321/nginx'
                }
            }
        }
       stage('Deploy to k8s'){
            steps{
               dir ('/var/lib/jenkins/workspace/project3') {
  
                   sshagent(['kuberneteslogin']) {
                      sh " cd /var/lib/jenkins/workspace/project3 "
                      sh " ls -ltr "
                    sh "scp -o StrictHostKeyChecking=no k8s-chart ubuntu@54.221.36.44:"
                    script{
                            sh "ssh ubuntu@54.221.36.44 helm install k8schart k8s-chart"
                        }
                        }
                    }
    
}
                   
                    
                }
            }
        
        }

