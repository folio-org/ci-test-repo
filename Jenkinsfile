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
   
          // def customList = sh(returnStdout: true,
          //                script: "jq -r '.[].id' custom-deps.json").split(' ')
          def customMods = readJSON file: 'custom-deps.json'
    
          customMods.each {
            echo it.id
            def modRegex = /^(.*?)\-\d+\.*/
            def customName = (it.id =~ /^(.*?)\-\d+.*/)
            echo "Name: $customName"
             
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

