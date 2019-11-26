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
              def foliociLib = new org.folio.foliociCommands()
              env.tentant = 'diku'

              // Deal with PR Deps for preview mode
              if (fileExists('.pr-custom-deps.json'))  {
                def previewMods = readJSON file: '.pr-custom-deps.json'
                def installExtras  = readJSON file: 'install-extras.json'
                def newInstallExtras = foliociLib.subPreviewMods(previewMods,installExtras)

                writeJSON file: 'install-extras.json', json: newInstallExtras, pretty: 2
                sh 'cat install-extras.json'
              }

              // Add extra backend deps
              echo "Adding additional modules to stripes-install.json"
              sh 'mv stripes-install.json stripes-install-pre.json'
              sh 'jq -s \'.[0]=([.[]]|flatten)|.[0]\' stripes-install-pre.json install-extras.json > stripes-install.json'
              def stripesInstallJson = readFile('./stripes-install.json')
              platformDepCheck(env.tenant,stripesInstallJson)
              echo 'Generating backend dependency list to okapi-install.json'
              sh 'jq \'map(select(.id | test(\"mod-\"; \"i\")))\' install.json > okapi-install.json'
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

