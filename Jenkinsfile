@Library ('folio_jenkins_shared_libs@delete-tenant-script') _


pipeline {

  environment {
    origin = 'ci-test-repo'
  }

  options {
    timeout(30)
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  agent {
    node {
      label 'jenkins-slave-all-node'
    }
  }

  stages {
    stage('test') {
      steps {
        script {
            deleteTenant("https://okapi-default.ci.folio.org", "platform_core_552_5")
          }    
        }
      }
    }
  } // end stages

  post {
    always {
      echo "Done"
    }
  }
}

