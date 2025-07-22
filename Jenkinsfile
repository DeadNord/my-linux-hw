pipeline {
  agent any
  environment {
    REGION = 'eu-central-1'
    ECR_URL = "${ECR_URL}"
  }
  stages {
    stage('Build image') {
      steps {
        sh 'docker build -t $ECR_URL:$GIT_COMMIT app'
      }
    }
    stage('Push to ECR') {
      steps {
        sh '''aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URL
        docker push $ECR_URL:$GIT_COMMIT'''
      }
    }
    stage('Update chart') {
      steps {
        sh "sed -i 's/tag: \".*\"/tag: \"$GIT_COMMIT\"/' src/charts/django-app/values.yaml"
        sh 'git config user.email "jenkins@example.com"'
        sh 'git config user.name "jenkins"'
        sh 'git commit -am "Update image tag"'
        sh 'git push origin $GIT_BRANCH'
      }
    }
  }
}
