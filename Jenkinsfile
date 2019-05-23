@Library ('folio_jenkins_shared_libs') _


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
          def customList = sh(returnStdout: true,
                              script: "jq -r '.[].id' custom-deps.json")
          customList.each {
            echo it
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

