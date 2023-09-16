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
                echo '<<<<<<<<<<<<<Start of Build>>>>>>>>>>>>'
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo '<<<<<<<<<<<<<<End of Build>>>>>>>>>>>>>'
            }
        }

        stage('Test'){
            steps {
                echo '<<<<<<<<<<<<<Start of Test>>>>>>>>>>>>'
                sh 'mvn surefire-report:report'
                echo '<<<<<<<<<<<<<<End of Test>>>>>>>>>>>>>'
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
