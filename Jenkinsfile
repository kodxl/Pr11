pipeline {
    agent any
    stages {
        stage('checkout') {
            steps{
                git url:'https://github.com/kodxl/Pr11.git',branch:'main'
            }
        }
        stage('deploy')
        {
            steps{
                sh 'docker run -d -p 8998:8080 -v $(pwd)/html:/usr/share/nginx/html:ro --name=web nginxinc/nginx-unprivileged'
                sh 'sleep 5'
            }
        }
        stage('test')
        {
            steps{
                script{
                    def md5_1 = sh(returnStdout: true, script:'curl -sL http://localhost:8998 | md5sum | cut -d " " -f 1')
                    def md5_2 = sh(returnStdout: true, script:'cat html/index.html | md5sum | cut -d " " -f 1')
                    if(md5_1 != md5_2){
                        echo "Error! MD5 summs are NOT equal"
                        echo "Remote: ${md5_1}"
                        echo "Local:'${md5_2}"
                        sh 'exit 1'
                    } else {
                        echo "OK! MD5 summs are equal ${md5_1}"
                    }
                
                    def code = sh(returnStdout: true, script:'curl -s -o /dev/null -w "%{http_code}" http://localhost:8998')
                    if(code != '200'){
                        echo "Error! Status code ${code}"
                        sh 'exit 1'
                    } else {
                        echo "OK! Status code is ${code}"
                    }
                }
            }
        }
        stage('clean')
        {
            steps{
                sh 'docker stop web'
                sh 'docker rm web'
            }
        }
    }
}
