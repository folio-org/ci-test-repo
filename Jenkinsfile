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
        script {
          def randomString = sh(returnStdout: true, 
                                script: 'cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w 32 | head -n 1')
                                
          sh "echo $randomString > foobar"
          sh 'cat foobar'
        }
      }
    }

    stage('Commit to master') {
      when { 
        branch 'master' 
      }
      steps {
        sh 'git checkout master'
        sh 'git add foobar'
        script {
           def commitStatus = sh(returnStatus: true,
                                 script: 'git commit -m "committing files: foobar"') 
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

