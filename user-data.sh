#! /bin/bash -x

### Git ###
# Everything AFTER https://github.com/. Do not include preceeding /.
# This is required as a github URL can be for a user or for an org
GIT_REPO_URL="https://github.com/stevenb919/s3-file-upload.git"
GIT_BRANCH="master"

START_SCRIPT_NAME="index.js"
LOCAL_CODE_PROJECT_NAME="nodejsapp"
CODE_PROJECT_LOCATION="/home/ec2-user/${LOCAL_CODE_PROJECT_NAME}"

NODE_VERSION="10.15.3"

# Update packages
yum update -y
yum install git -y

### Node.js ###
# Download, install, and configure node via Node Version Manager
echo "Installing nvm"
sudo -i -u ec2-user bash <<EOF
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
	. ~/.nvm/nvm.sh
	nvm install $NODE_VERSION
	nvm use $NODE_VERSION
	nvm alias default $NODE_VERSION
EOF

# Checkout the code and install node modules
# Setup cron job to run every 1 minute for debugging
# TODO, change this to every 24 hours
echo "Cloning project from ${GIT_REPO_URL} to ${LOCAL_CODE_PROJECT_NAME}"
sudo -i -u ec2-user bash -x <<EOF
	git clone --depth=1 --branch=$GIT_BRANCH $GIT_REPO_URL $LOCAL_CODE_PROJECT_NAME
	cd $CODE_PROJECT_LOCATION
	/home/ec2-user/.nvm/versions/node/v$NODE_VERSION/bin/npm i
	/home/ec2-user/.nvm/versions/node/v$NODE_VERSION/bin/node /home/ec2-user/$LOCAL_CODE_PROJECT_NAME/$START_SCRIPT_NAME
EOF