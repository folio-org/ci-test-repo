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
      label 'jenkins-slave-all'
    }
  }

  stages {
    stage('test') {
      steps {
          previewTenantCleanup("-o https://okapi-preview.ci.folio.org --dry-run")
        }    
      }
  } //end stages

  post {
    always {
      echo "Done"
    }
  }
}

