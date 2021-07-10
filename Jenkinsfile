pipeline {
    agent any
    parameters {
        choice(name: 'branch', choices: ['master', 'patch1'], description: 'Select Your Branch')
        choice(name: 'environment', choices: ['dev1', 'test1', 'prod'], description: 'Select Your Environment')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'Do you want to execute test-cases')
    }
    environment {
         SELECTED_BRANCH = "${env.branch}"
         SELECTED_ENVIRONMENT = "${env.environment}"
         GITHUB_URL = "https://github.com/dockerdebu4321/myproject.git"
         IS_TEST_TOEXECUTE = "${env.executeTests}"
         DOCKER_IMAGE_NAME = "dockerdebu4321/endtoend"
         DOCKER_REPO_USERNAME = "dockerdebu4321"
    }
    stages {
       stage('Git Clone'){
           steps {
               script {
                 git credentialsId: 'Github_Credential', branch: SELECTED_BRANCH, url: GITHUB_URL
                 echo "*********** taking code from :  ${SELECTED_BRANCH} with url :  ${GITHUB_URL} ***********"
               }
           }  
       }
       stage('Env Selection'){
        steps {
          script {
             switch (SELECTED_ENVIRONMENT) {
                case 'dev1':
                    env.SPRING_PROFILES_ACTIVE="dev1"
                    break
                case 'test1':
                     env.SPRING_PROFILES_ACTIVE="test1"
                    break
                case 'prod':
                    env.SPRING_PROFILES_ACTIVE="prod"
                    break
               }
                echo "***********  ${SELECTED_ENVIRONMENT} environment selected  ***********"
            }
        }
    }
    stage('Test Selection'){
        steps {
               script {
        switch (IS_TEST_TOEXECUTE) {
            case 'true':
                env.MVN_TEST_COMMAND="clean package"
                break
            case 'false':
                 env.MVN_TEST_COMMAND="clean package -DskipTests"
                break
        }
         echo "*********** selected mvn command : ${MVN_TEST_COMMAND} ***********"
       }
     }
    }
  
    stage('Maven Build'){
          steps {
               script {
        def MavenHome = tool name: "Maven-3.8.1" , type: "maven"
        def mavenCmd = "${MavenHome}/bin/mvn "
        sh "${mavenCmd} ${env.MVN_TEST_COMMAND}"
         echo "*********** executed mvn command : ${mavenCmd} ${env.MVN_TEST_COMMAND} Successfully.. ***********"
               }
          }
    }
    stage('Docker Build'){
        steps {
               script {
        sh "docker rmi -f ${DOCKER_IMAGE_NAME}"
        sh "docker build --no-cache -t ${DOCKER_IMAGE_NAME} ."
           echo "*********** created docker image Successfully.. ***********"
               }
        }
    }
    stage('Docker Push'){
        steps {
               script {
                    withCredentials([string(credentialsId: 'Docker_Hub_Credentials', variable: 'docker_hub_password')]) {
                    sh "docker login -u ${DOCKER_REPO_USERNAME} -p ${docker_hub_password}"
                   }
                    sh "docker push ${DOCKER_IMAGE_NAME}"
                    echo "*********** pushed docker image Successfully.. ***********"
               }
        }
    }
    stage('K8s Push'){
        steps {
               script {
                sh "kubectl --insecure-skip-tls-verify delete -f k8s-service-manifest.yaml"
                sh "kubectl --insecure-skip-tls-verify delete -f k8s-deployment-manifest.yaml"
                sh "kubectl --insecure-skip-tls-verify apply -f k8s-service-manifest.yaml"
                sh "env envsubst < k8s-deployment-manifest.yaml > deployment.yaml"	
                sh "kubectl --insecure-skip-tls-verify apply -f deployment.yaml"
                 echo "*********** Deployed Application in ${SELECTED_ENVIRONMENT} Successfully.. ***********"
               }
           }      
     }
   }
}
/*
#########    Environment Injector Plugin
***************************************************************************************************************************


node {
    stage('Git Clone'){
        sh "echo ${branch}"
        git credentialsId: 'Github_Credential', branch: "${branch}", url: 'https://github.com/dockerdebu4321/myproject.git'
    }
    stage('Env Selection'){
        switch (params.selectedenv) {
            case 'dev1':
                env.SPRING_PROFILES_ACTIVE="dev1"
                break
            case 'test1':
                 env.SPRING_PROFILES_ACTIVE="test1"
                break
             case 'prod':
                env.SPRING_PROFILES_ACTIVE="prod"
                break
        }
        echo "${env.SPRING_PROFILES_ACTIVE} environment selected.."
    }
    stage('Test Selection'){
        switch (params.selectedTest) {
            case 'with_test':
                env.MVN_TEST_COMMAND="clean package"
                break
            case 'with_out_test':
                 env.MVN_TEST_COMMAND="clean package -DskipTests"
                break
        }
    }    
    stage('Maven Build'){
        def MavenHome = tool name: "Maven-3.8.1" , type: "maven"
        def mavenCmd = "${MavenHome}/bin/mvn "
        sh "${mavenCmd} ${env.MVN_TEST_COMMAND}"
    }
    stage('Docker Build'){
        sh "docker rmi -f dockerdebu4321/endtoend"
        sh "docker build --no-cache -t dockerdebu4321/endtoend ."
    }
    stage('Docker Push'){
        withCredentials([string(credentialsId: 'Docker_Hub_Credentials', variable: 'docker_hub_password')]) {
        sh "docker login -u dockerdebu4321 -p ${docker_hub_password}"
       }
       
        sh "docker push dockerdebu4321/endtoend"
    }
    stage('K8s Push'){
        sh "kubectl --insecure-skip-tls-verify delete -f k8s-service-manifest.yaml"
        sh "kubectl --insecure-skip-tls-verify delete -f k8s-deployment-manifest.yaml"
        sh "kubectl --insecure-skip-tls-verify apply -f k8s-service-manifest.yaml"
        sh "env envsubst < k8s-deployment-manifest.yaml > deployment.yaml"	
        sh "kubectl --insecure-skip-tls-verify apply -f deployment.yaml"
   }
}
*/
