pipeline {
  agent {
    node {
      label 'BIG_LIN_WKR'
    }

  }
  stages {
    stage('Infrastructure') {
      steps {
        echo 'Setup Build Environment'
        sh 'sudo apt-get update'
        sh '''sudo apt-get install -y \\
		curl \\
		wget \\
		build-essential \\
		make \\
		gcc \\
		mingw-w64 \\
		libreadline-dev \\
		ca-certificates \\
		unzip \\
		libssl-dev \\
		git \\
		sudo \\
--no-install-recommends'''
        sh 'sudo rm -r /var/lib/apt/lists/*'
        echo 'Setup Tools'
        sh 'wget https://s3-eu-west-1.amazonaws.com/drivers.automation-intelligence/VectorCAST/vcast.linux.2018.tar.gz'
        sh 'wget https://s3-eu-west-1.amazonaws.com/drivers.automation-intelligence/VectorCAST/setupVcLinux.sh'
        sh 'sudo chmod a+x setupVcLinux.sh'
        sh 'sudo ./setupVcLinux.sh'
        sh 'mkdir -p $VECTORCAST_DIR'
        sh 'tar -xvf vcast.linux.2018.tar.gz -C $VECTORCAST_DIR'
        sh '$VECTORCAST_DIR/clicast'
      }
    }
  }
  environment {
    VECTORCAST_DIR = '/tmp/vcast'
    VECTOR_LICENSE_FILE = '27000@18.205.131.82'
  }
}