@Library ('folio_jenkins_shared_libs@FOLIO-2011a') _


pipeline {

  environment {
    origin = 'ci-test-repo'
    folioRegistry = 'http://folio-registry.aws.indexdata.com'
    tenant = 'diku'
    releaseOnly = 'true'
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
        script {
          // okapi tokens
          withCredentials([usernamePassword(credentialsId: 'okapi-preview-superuser', passwordVariable: 'pass', usernameVariable: 'user')]) {
            writeFile file: 'getOkapiToken.sh', text: libraryResource('org/folio/getOkapiToken.sh')
            sh 'chmod +x getOkapiToken.sh'
            def okapiToken = sh(returnStdout: true, script: "./getOkapiToken.sh -t supertenant -o https://okapi-preview.ci.folio.org -u $user -p $pass").trim()
            echo "$okapiToken"
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

