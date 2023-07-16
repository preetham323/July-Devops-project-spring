pipeline {
    agent any
    stages {
        stage("AWS-Packer") {
            steps {
                withCredentials([
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_credential',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]) {
                    sh "aws s3 ls"
                }
            }
        }
        stage("Packer Init") {
            steps {
              echo "initiatlizing packer"
              sh "/usr/bin/packer version"
              sh "/usr/bin/packer init aws-ami-v1.pkr.hcl"
            }
        }
        stage("validating packer") {
            steps {
              echo "validating packer code"
              sh "/usr/bin/packer validate init aws-ami-v1.pkr.hcl"
            }
        }
        stage("Building AMI") {
            steps {
                withCredentials([
                    [
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_credential',
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]
                ]) {
                    echo "building AMI"
                    sh "packer build aws-ami-v1.pkr.hcl"
                }
            }
        }
    }
}
