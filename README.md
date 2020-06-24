# udacity_capstone_project
Final project from Udacity Could DevOps course.

This project is to demonstrate the ability to build jenkins CI/CD pipelines with Kubernetes cluster.
In this project, the web application is a simple html served by Nginx. And it uses Blue|Green strategy to
deploy updates.

# Project requirements:
* Jenkins
* Blue Ocean Plugin in Jenkins
* Pipeline-AWS Plugin in Jenkins
* Docker, Docker Hub account
* Pip
* AWS Cli
* Eksctl
* Kubectl

# Project layout:

* /infrastructure : Pipeline to create a kubernetes cluster in AWS.
* /deploy : CloudFormation Script of replication controllers and Load balancer.
* /www : Web application with Nginx
* Jenkinsfile : Jenkinsfile for Creating Pipeline
* Dockerfile : Dockerfile for building the image

# Run the project
1. Install all requirements in the Jenkins EC2 Instance
2. Create cluster pipeline with this GitHub repository
3. Create deployment pipeline for deploying update.