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
    stage('Setup') {
      steps {
        script {
          currentBuild.displayName = "#${env.BUILD_NUMBER}-${env.JOB_BASE_NAME}"
          dir("${env.WORKSPACE}/foo") {
            def foo = 'bar'
          }
          if (foo == 'bar') { 
            echo "bar"
          }
          else { 
            echo "foo"
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

