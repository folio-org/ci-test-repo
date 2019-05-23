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
            def matches = (it.id =~ /^(.*?)\-(\d+.*)/)
            def customName = matches[0]
            //def customVer = matches[1]
            echo "Name: $customName"
            //echo "Version: $customVer"
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

