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

          def releasedModules = readJSON file: 'okapi-install.json'
          def customModules = readJSON file: 'custom-deps.json'
          releasedModules.each {
            def releasedMod = it.id
            echo "Released Mod: ${releasedMod}"
            customModules.each {
                echo "Custom Mod: ${it.id}"
              if( releasedMod != it.id ) {
                echo "Post $releasedMod"
              }
            }
          }    
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

