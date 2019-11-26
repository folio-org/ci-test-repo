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
          //if ( (env.CHANGE_ID) && (fileExists('.pr-custom-deps.json')) )  {
          if (fileExists('.pr-custom-deps.json'))  {
            // get pr deps
            def previewMods = readJSON file: '.pr-custom-deps.json'
            def mods = readJSON file: 'install-extras.json'
         
            // def previewMod
            // def previewModAction
            // def matches
            // def previewModName
            // def Boolean exists
            // def newEntry

            @NonCPS
            previewMods.each {
              def exists = false
              def previewMod = it.id
              def previewModAction = it.action
              def matches = (it.id =~ /^(.*?)\-(\d+.*)/)
              def previewModName = matches[0][1]

              echo "Substituting: " + previewModName + "-->" + previewMod
              echo "Action: " + previewModAction
            
              @NonCPS
              mods.each { 
                if (it.id ==~ /^${previewModName}-\d+.*/) {
                  it.id = previewMod
                  it.action = previewModAction
                  exists = true
                }
              }
              if (!exists) { 
                def newEntry = [:]
                newEntry.put('id', previewMod)
                newEntry.put('action', previewModAction)
                mods << newEntry
              }
            }
            writeJSON file: 'install-extras-new.json'
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

