pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    environment {
        PATH = "/opt/apache-maven-3.9.4/bin:$PATH"
    }

    stages {
        stage('Build') {
            steps {

                // Run Maven on a Unix agent.
                sh 'mvn clean deploy'

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }

        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'dnd-sonar-scanner'
            }
            steps{
                    withSonarQubeEnv('dnd-sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
    }
}
