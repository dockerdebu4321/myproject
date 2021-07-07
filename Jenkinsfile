
node{
/*
    stage('Git Clone'){
        git credentialsId: 'Github_Credential', branch: ${branch}, url: 'https://github.com/dockerdebu4321/myproject.git'
    }
    */
    stage('Maven Build'){
        def MavenHome = tool name: "Maven-3.8.1" , type: "maven"
        def mavenCmd = "${MavenHome}/bin/mvn "
        sh "${mavenCmd} clean package"
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
        sh "kubectl --insecure-skip-tls-verify apply -f k8s-deployment-manifest.yaml"
    }
}