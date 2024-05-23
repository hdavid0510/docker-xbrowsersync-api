pipeline{
	agent any

	environment {
		IMAGE_NAME="hdavid0510/xbrowsersync-api"
		IMAGE_TAG="1.1.13-node14"
		REGISTRY_CREDENTIALS=credentials('dockerhub-credential')
	}

	stages {
		stage('Init') {
			steps {
				echo 'Initializing.'
				sh 'echo $REGISTRY_CREDENTIALS_PSW | docker login -u $REGISTRY_CREDENTIALS_USR --password-stdin'
				echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
				echo "Building ${IMAGE_NAME} on branch ${IMAGE_TAG}"
			}
		}
		stage('Build/Push') {
			parallel {
				stage('Image build amd64') {
					steps {
						echo 'Building amd64 image and pushing to DockerHub.'
						sh 'docker buildx build --push --platform linux/amd64 -t $IMAGE_NAME:$IMAGE_TAG .'
					}
				}
				stage('Image build armv6') {
					steps {
						echo 'Building armv6 image and pushing to DockerHub.'
						sh 'docker buildx build --push --platform linux/arm/v6 -t $IMAGE_NAME:$IMAGE_TAG .'
					}
				}
				stage('Image build arm64') {
					steps {
						echo 'Building arm64 image and pushing to DockerHub.'
						sh 'docker buildx build --push --platform linux/arm64/v8 -t $IMAGE_NAME:$IMAGE_TAG .'
					}
				}
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}
}
