// This pipeline requires the docker pipeline plugin and the use of
// a jenkins/jnlp-agent-docker agent. This agent must be run as user/group "jenkins:docker" (may need to use group ID instead of group name)
pipeline {
    agent { label 'docker' }

    stages {
        stage('Docker Build'){
            agent { label 'docker' }

            steps {
                checkout scm: [
                    $class: 'GitSCM',
                    branches: scm.branches,
                    extensions: [
                        [$class: 'SubmoduleOption',
                        disableSubmodules: false,
                        parentCredentials: false,
                        recursiveSubmodules: true,
                        reference: 'https://github.com/ByronBingham/mediaDB-DB.git',
                        shallow: true,
                        trackingSubmodules: false]
                    ],
                    submoduleCfg: [],
                    userRemoteConfigs: scm.userRemoteConfigs
                ]

                script {
                    def props = readProperties file: 'version'  // readProperties requires pipeline utility steps plugin
                    version = props.version
                }

                sh "docker build -t ${LOCAL_REG_URL}/bmedia_db:${version}_SNAPSHOT --build-arg ARG_VERSION=${version} ."
                sh "docker push ${LOCAL_REG_URL}/bmedia_db:${version}_SNAPSHOT"
            }            
        }
        stage('Test'){
            steps {
                echo "TODO..."
            }
        }
        stage('Deploy'){
            steps{
                echo "TODO"
            }            
        }
    }
}