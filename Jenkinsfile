pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    stages {
        stage('Clone Code from GitHub') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/dhanushnd101/tweet-devops-project'

                // Run Maven on a Unix agent.
                // sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
    }
}
