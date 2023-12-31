def registry = 'https://dhanushnd.jfrog.io'
def dockerImage = 'dhanushnd.jfrog.io/dnd-docker-local/ttrend'
def dockerVersion = '2.1.3'

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
                echo '<--------------- Start of Build --------------->'
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo '<--------------- End of Build --------------->'
            }
        }

        stage('Test'){
            steps {
                echo '<--------------- Start of Test --------------->'
                sh 'mvn surefire-report:report'
                echo '<--------------- End of Test --------------->'
            }
        }
        
        //   Commented to speed up the build
        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'dnd-sonar-scanner'
            }
            steps{
                    echo '<--------------- Start of Sonar Analysis --------------->'
                    withSonarQubeEnv('dnd-sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
                    echo '<--------------- End of Sonar Analysis --------------->'
                }
            }
        }

        stage("Quality Gate"){
            steps{
                script{
                    echo '<--------------- Start of Quality Gate --------------->'
                    timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
                        def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
                        if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                    echo '<--------------- End of Quality Gate --------------->'
                }
            }
        }

        stage("Jar Publish") {
            steps {
                script {
                    echo '<--------------- Start of Jar Publish --------------->'
                    def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog-artifactory"
                    def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                    def uploadSpec = """{
                        "files": [
                            {
                            "pattern": "jarstaging/(*)",
                            "target": "libs-release-local/{1}",
                            "flat": "false",
                            "props" : "${properties}",
                            "exclusions": [ "*.sha1", "*.md5"]
                            }
                        ]
                    }"""
                    def buildInfo = server.upload(uploadSpec)
                    buildInfo.env.collect()
                    server.publishBuildInfo(buildInfo)
                    echo '<--------------- End of Jar Publish --------------->'  
                }
            }   
        }

        stage('Build docker image') {
            steps {
                script{
                    echo '<--------------- Start of Build Docker Image --------------->'
                    app = docker.build(dockerImage+":"+dockerVersion)
                    echo '<--------------- End of Build Docker Image --------------->'
                }
            }
        }

        stage('Push docker image to Jfrog') {
            steps {
                script{
                    echo '<--------------- Start of Push docker image to Jfrog --------------->'
                    docker.withRegistry(registry, 'jfrog-artifactory'){
                        app.push()
                    }
                    echo '<--------------- End of Push docker image to Jfrog --------------->'
                }
            }
        }

        stage('Deploy in EKS'){
            steps{
                script{
                    echo '<--------------- Start of Deploy in EKS --------------->'
                    // sh './deploy.sh'
                    echo '<--------------- End of Deploy in EKS --------------->'
                }
            }
        }

        stage('Deploy on Helm '){
            steps{
                script{
                    echo '<--------------- Start of Deploy in Helm --------------->'
                    sh 'helm install ttrend ttrend-0.1.0.tgz'
                    echo '<--------------- End of Deploy in Helm --------------->'
                }
            }
        }
    }
}
