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
        sh 'sudo dpkg --add-architecture i386'
        sh '''sudo apt-get update
'''
        sh 'sudo apt-get install -y lsb libfontconfig:i386 libxext6:i386 libxrender1:i386 libglib2.0-0:i386'
        sh 'wget https://s3-eu-west-1.amazonaws.com/drivers.automation-intelligence/VectorCAST/vcast.linux.2018.tar.gz'
        sh 'mkdir -p $VECTORCAST_DIR'
        sh 'tar -xvf vcast.linux.2018.tar.gz -C $VECTORCAST_DIR'
        sh '$VECTORCAST_DIR/clicast'
      }
    }
    stage('Build') {
      steps {
        sh 'test -f makefile && grep -v "# -pedantic" makefile > makefile2 && mv makefile2 makefile'
        sh 'make'
      }
    }
    stage('Build Snoop') {
      steps {
        sh 'make clean'
        sh '$VECTORCAST_DIR/vcshell --db=lua_vcdb.db make'
      }
    }
  }
  environment {
    VECTORCAST_DIR = '/tmp/vcast'
    VECTOR_LICENSE_FILE = '27000@18.205.131.82'
  }
}