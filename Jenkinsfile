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
          def okapiMods = readJSON file: 'okapi-install.json'
    
          customMods.each {
            def customMod = it.id
            def customModAction = it.action
            def matches = (it.id =~ /^(.*?)\-(\d+.*)/)
            def customModName = matches[0][1]
            def customModVer = matches[0][2]
          
            echo "Custom Mod: " + customMod
            echo "Custom Mod Action: " + customModAction
            echo "Name: " + customModName
            echo "Version: " + customModVer

            okapiMods.each {
              if (it.id.matches("${customModName}-(\d+.*)")) { 
                 it.id = customMod
                 it.action = customModAction
              }
            }
            echo "OKAPI MODS: " + okapiMods
                
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

