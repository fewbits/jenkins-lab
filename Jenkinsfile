pipeline {
  agent any

  environment {
    PROJECT_NAME = 'jenkins-lab'
  }

  stages {
    stage('Quality') {
      steps {
        sh 'echo "[FAKE SONAR] This code is very good"'
      }
    }
    stage('Build') {
      steps {
        sh 'echo "[FAKE COMPILER] ./configure && make && make install"'
        sh 'sleep 2'
        sh 'echo "[FAKE COMPILER] Project compiled with 0 errors"'
      }
    }
    stage('Test') {
      steps {
        sh 'echo "[FAKE TESTER] says: This is the best project I have ever seen in my entire life and it never breaks and I think I gonna cry"'
      }
    }
    stage('Deploy - Development') {
      steps {
        sh 'echo "[FAKE MIDDLEWARE] Project deployed in Development"'
        slackSend channel: '#general',
                  color: 'good',
                  message: "Project $PROJECT_NAME deployed in Development."
      }
    }
    stage('Deploy - QA') {
      steps {
        input 'Proceed to QA?'
        sh 'echo "[FAKE MIDDLEWARE] Project deployed in QA"'
        slackSend channel: '#general',
                  color: 'good',
                  message: "Project $PROJECT_NAME deployed in QA."
      }
    }
    stage('Deploy - Staging') {
      steps {
        input 'Proceed to Staging?'
        sh 'echo "[FAKE MIDDLEWARE] Project deployed in Staging"'
        slackSend channel: '#general',
                  color: 'good',
                  message: "Project $PROJECT_NAME deployed in Staging."
      }
    }
    stage('Deploy - Production') {
      steps {
        input 'Proceed to Production?'
        sh 'echo "[FAKE MIDDLEWARE] Project deployed in Production"'
        slackSend channel: '#general',
                  color: 'good',
                  message: "Project $PROJECT_NAME deployed in Production."
      }
    }
  }
  post {
    always {
      echo 'This will always run'
      deleteDir()
    }
    success {
      echo 'This will run only if successful'
      slackSend channel: '#general',
                color: 'good',
                message: "The pipeline ${currentBuild.fullDisplayName} completed successfully :thumbsup:"
    }
    failure {
      echo 'This will run only if failed'
      slackSend channel: '#general',
                color: 'bad',
                message: "The pipeline ${currentBuild.fullDisplayName} has failed :thumbsdown:"
    }
    unstable {
      echo 'This will run only if unstable'
    }
    changed {
      echo 'This will run only if the state of the Pipeline has changed'
    }
  }
}
