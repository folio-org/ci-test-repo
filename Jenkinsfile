@Library ('folio_jenkins_shared_libs') _

pipeline {

  environment {
    origin = 'ci-test-repo'
  }

  options {
    timeout(30)
    buildDiscarder(logRotator(numToKeepStr: '30'))
  }

  agent {
    node {
      label 'jenkins-slave-all'
    }
  }

  stages {
    stage('Setup') {
      steps {
        script {
          currentBuild.displayName = "#${env.BUILD_NUMBER}-${env.JOB_BASE_NAME}"
        }
      }
    }

    stage('Create New Files') {
      steps {
        sh 'touch foo'
        sh 'touch bar'
      }
    }

    stage('Commit to master') {
      when { 
        branch 'master' 
      }
      steps {
        sh 'git checkout master'
        sh 'git add foo'
        sh 'git add bar'
        script {
           def commitStatus = sh(returnStatus: true,
                                 script: 'git commit -m "committing files: foo,bar"') 
            if (commitStatus == 0) { 
              sshGitPush(origin: env.origin, branch: 'master') 
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

