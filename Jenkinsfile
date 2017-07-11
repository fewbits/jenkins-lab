pipeline {
  agent any

  environment {
    PROJECT_NAME = 'jenkins-lab'
  }

  stages {
    stage('Test') {
      steps {
        sh '/usr/bin/java -version'
        sh 'echo Project Name is: $PROJECT_NAME'
      }
    }
  }
  post {
    always {
      echo 'This will always run'
      deleteDir()
      slackSend channel: '#general',
                color: 'good',
                message: "The pipeline ${currentBuild.fullDisplayName} completed successfully."
    }
    success {
      echo 'This will run only if successful'
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
