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
      label 'jenkins-slave-all-node10'
    }
  }

  stages {
    stage('test') {
      steps {
        script {
          docker.image('folioorg/okapi:latest').withRun('', 'dev') { container -> def okapiIp = sh(returnStdout:true, script: "docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${container.id}").trim()

      
            def previewOpts = [ previewOkapiUrl: "http://${okapiIp}:9130" ]
            setupPreviewEnv(previewOpts)
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

