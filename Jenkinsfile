pipeline {
  agent {
    node {
      label 'BIG_LIN_WKR'
    }

  }
  stages {
    stage('Infrastructure') {
      steps {
        echo 'Setup Build Environment - $VECTORCAST_DIR'
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
                xterm \\
--no-install-recommends'''
        sh 'sudo rm -r /var/lib/apt/lists/*'
        echo 'Setup Tools'
        sh 'sudo dpkg --add-architecture i386'
        sh '''sudo apt-get update
'''
        sh 'sudo apt-get install -y lsb libfontconfig:i386 libxext6:i386 libxrender1:i386 libglib2.0-0:i386'
        sh 'wget https://s3-eu-west-1.amazonaws.com/drivers.automation-intelligence/VectorCAST/vcast.linux.$VERSION_VECTORCAST.tar.gz'
        sh 'mkdir -p $VECTORCAST_DIR'
        sh 'tar -xvf vcast.linux.$VERSION_VECTORCAST.tar.gz -C $VECTORCAST_DIR'
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
        sh 'mv lua_vcdb.db test/artefacts/'
      }
    }
    stage('Unit Test') {
      steps {
        dir(path: 'test/unit') {
          sh 'export LUA_ROOT=`pwd`../.. && $VECTORCAST_DIR/manage --project lua --build-execute --incremental --output inc_results.html'
          sh '''export LUA_ROOT=\'pwd\' && $VECTORCAST_DIR/manage --project lua --full-status=status.html
'''
          sh '''export LUA_ROOT=\'pwd\' && $VECTORCAST_DIR/manage --project lua --create-report=aggregate
'''
          sh '''export LUA_ROOT=\'pwd\' && $VECTORCAST_DIR/manage --project lua --create-report=metrics
'''
          sh '''export LUA_ROOT=\'pwd\' && $VECTORCAST_DIR/manage --project lua --create-report=environment
'''
          sh '''export LUA_ROOT=\'pwd\' && $VECTORCAST_DIR/manage --project lua --clicast-args report custom management
'''
          sh '''export LUA_ROOT=\'pwd\' && $VECTORCAST_DIR/manage --project lua --clicast-args report custom actual

'''
        }

      }
    }
    stage('Store Results') {
      steps {
        dir(path: 'test') {
          archiveArtifacts '*.html'
        }

      }
    }
  }
  environment {
    VECTORCAST_DIR = '/tmp/vcast'
    VECTOR_LICENSE_FILE = '27000@lic.automation-intelligence.com'
    VERSION_VECTORCAST = '2018sp3'
  }
}