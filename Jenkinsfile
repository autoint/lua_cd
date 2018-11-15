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
        sh 'mkdir /tmp/vcast'
        sh 'tar -xvf vcast.linux.2018.tar.gz -C /tmp/vcast'
        sh 'export VECTORCAST_DIR=/tmp/vcast && export VECTOR_LICENSE_FILE=27000@18.205.131.82 && $VECTORCAST_DIR/clicast'
      }
    }
  }
}