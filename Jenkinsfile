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
          // if ( (env.CHANGE_ID) && (fileExists('.pr-custom-deps.json')) )  {
          def foliociLib = new org.folio.foliociCommands()
          if (fileExists('.pr-custom-deps.json'))  {
            // get pr deps
            def previewMods = readJSON file: '.pr-custom-deps.json'
            def installExtras  = readJSON file: 'install-extras.json'
            newInstallExtras = foliociLib.subPreviewMods(previewMods,installExtras)
         
            writeJSON file: 'install-extras-new.json', json: newInstallExtras
            echo "cat install-extras-new.json"
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

