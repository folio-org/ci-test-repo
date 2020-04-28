@Library ('folio_jenkins_shared_libs@FOLIO-2534-tenant-cleanup') _


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
      label 'jenkins-slave-all'
    }
  }

  stages {
    stage('test') {
      steps {
          previewTenantCleanup("-o https://okapi-preview.ci.folio.org")
        }    
      }
  } //end stages

  post {
    always {
      echo "Done"
    }
  }
}

