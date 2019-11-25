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
          // Concat custom backend deps as well here
          echo "Adding additional modules to stripes-install.json"
          sh 'mv stripes-install.json stripes-install-pre.json'
          sh 'jq -s \'.[0]=([.[]]|flatten)|.[0]\' stripes-install-pre.json install-extras.json > stripes-install.json'
          def stripesInstallJson = readFile('./stripes-install.json')
          platformDepCheck(env.tenant,stripesInstallJson)
          echo 'Generating backend dependency list to okapi-install.json'
          sh 'jq \'map(select(.id | test(\"mod-\"; \"i\")))\' install.json > okapi-install.json'
          sh 'cat okapi-install.json'

          //if ( (env.CHANGE_ID) && (fileExists('.pr-custom-deps.json')) )  {
          if (fileExists('.pr-custom-deps.json'))  {
            // get pr deps
            def customDeps = readJSON file: '.pr-custom-deps.json'
            def OkapiInstallList = readJSON file: 'okapi-install.json'
            def previewOkapiInstallList = foliociLib.subPreviewMods(customDeps,okapiInstallList)
            writeJSON file: 'okapi-install.json', json: previewOkapiInstallList, pretty: 2
            sh 'cat okapi-install.json'
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

