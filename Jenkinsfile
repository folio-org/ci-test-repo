@Library ('folio_jenkins_shared_libs@FOLIO-2036') _


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
          def subModList = readJSON file: 'custom-deps.json'
          def okapiTenantModList = readJSON file: 'okapi-install.json'
          okapiTenantModList = subTenantMods(subModList,okapiTenantModList)
          writeJSON file: 'okapi-install.json', json: okapiTenantModList, pretty: 2
          sh 'cat okapi-install.json'
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

