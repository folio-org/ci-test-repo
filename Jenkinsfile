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
          withCredentials([file(credentialsId: 'okapi-preview-supertenant', 
                                variable: 'SUPERTENANT_CREDS')]) {
            def tenantCredentials = readFile file: "$SUPERTENANT_CREDS"
            httpRequest acceptType: 'APPLICATION_JSON_UTF8', 
                      authentication: 'cd96210b-c06f-4f09-a836-f992a685a97a', 
                      consoleLogResponseBody: true, 
                      contentType: 'APPLICATION_JSON_UTF8', 
                      customHeaders: [[maskValue: false, name: 'X-Okapi-Tenant', value: 'supertenant']], 
                      
                      requestBody: tenantCredentials, 
                      httpMode: 'POST', 
                      responseHandle: 'NONE', 
                      url: 'https://okapi-preview.ci.folio.org/authn/login'
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

