@Library ('folio_jenkins_shared_libs@FOLIO-2011a') _


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
        script {
          withCredentials([usernamePassword(credentialsId: 'okapi-preview-superuser', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
            writeFile file: 'getOkapiToken.sh', text: libraryResource('org/folio/getOkapiToken.sh')
            sh 'chmod +x getOkapiToken.sh' 
            def okapiToken =  sh (returnStdout: true, script: "./getOkapiToken.sh -t supertenant -o $previewOkapiUrl -u $USER -p $PASS).trim()
          }
          echo "$okapiToken"
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

