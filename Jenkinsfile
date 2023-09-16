pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    // environment {
    //     PATH = "/opt/apache-maven-3.9.4/bin:$PATH"
    // }

    stages {
        stage('Build') {
            steps {

                // Run Maven on a Unix agent.
                sh "mvn clean deploy"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
    }
}
