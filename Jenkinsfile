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
    stage('Deploy') {
      steps {
        sh 'echo "[FAKE MIDDLEWARE] Project deployed in all the environment across the world - true story ;)"'
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
                message: "The project $PROJECT_NAME was succesfully executed."
    }
    failure {
      echo 'This will run only if failed'
    }
    unstable {
      echo 'This will run only if unstable'
    }
    changed {
      echo 'This will run only if the state of the Pipeline has changed'
    }
  }
}
