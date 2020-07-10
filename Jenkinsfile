pipeline {
  agent any
  stages {
    stage('Terraform Init') {
      steps {
        sh "terraform init -input=false"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "terraform refresh"
        sh "terraform plan -out=tfplan -input=false"
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "terraform apply -input=false tfplan"
      }
    }
    stage('Deployments') {
      steps {
        input 'Deploy'
        sh "kubectl apply -f kubeclt/deployments.yaml"
        sh "kubectl apply -f kubeclt/service.yaml"
        sh "kubectl get services"
      }
    }
    stage('Test') {
      steps {
        script {
         def publicIp = sh returnStdout: true, script: "terraform output | grep public_ip_address | awk '/public_ip_address =/{ print \$3}'"
         build job: 'Test', parameters: [[$class: 'StringParameterValue', name: 'PUBLIC_IP', value: "$publicIp"]]
        }
      }
    }
    stage('Terraform Destroy') {
      steps {
        input 'Destroy Infrastructure'
        sh "terraform destroy -auto-approve"
      }
    }
  }
}
