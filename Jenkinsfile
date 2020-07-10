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
    stage('Deploy to cloud') {
      steps {
        input 'Deploy'
        sh "az aks get-credentials --resource-group spdemo-rg --name spdemo-aks  --overwrite-existing"
        sh "kubectl apply -f kubectl/deployments.yaml"
        sh "kubectl apply -f kubectl/service.yaml"
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
