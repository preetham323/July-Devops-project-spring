pipeline {
  agent any
  stages {
    stage('Building Resources') {
      steps {
          echo "packer installed"
      }
    }
	stage("AWS AMI Creation") {
		steps {
			withCredentials([[
			$class: 'AmazonWebServicesCredentialsBinding',
   			accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
			credentialsId: 'aws_credential'
			]]) {
			sh 'packer init .'
			sh 'packer build aws-ami-v1.pkr.hcl'
      			}
    		}
  	}
}
}