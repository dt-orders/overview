# Overview 

This folder contains the script and files to start the dt-orders application using docker-compose. 

# Prereqs

* VM running 16GB - for example (AWS = t3.xlarge and Azure = Standard_E2_v3)
* open port 80
* docker & docker-compose installed

# VM setup

Below are instructions for preparing to run the application on an AWS EC2 Linux OS but it can be adapted to run on Azure.

1. On the VM to run the application run the following 

    ```
    # general utilities
    sudo yum update -y
    sudo yum install git -y
    sudo yum install jq -y

    # docker
    # Reference:* https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html
    sudo yum update -y
    sudo yum install -y amazon-linux-extras
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo systemctl enable docker
    sudo usermod -a -G docker ec2-user

    # review commands
    sudo docker info
    sudo systemctl status docker

    # docker-compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
    sudo chmod +x /usr/bin/docker-compose
    docker-compose version
    ```

# Start the application 

There are two docker-compose files to run the `monolith` or `multi-services` topologies of the application.  Both can be run on the same host, but typically for demos they are run on two separate hosts.

1. Clone this repo `git clone https://github.com/dt-orders/overview.git`

1. From the cloned repo, navigate to the docker-compose subfolder

    ```
    cd overview/docker-compose
    ```

## Multiple services topology

1. Start the app 

    ```
    sudo docker-compose -f docker-compose-services.yaml up -d
    ```

1. Verify app is running

    It takes about 45 seconds to start, but then the application can be accessed

    ```
    sudo docker ps
    ```

1. Open the front-end in a browser for the app  `http://PUBLIC-IP` where `PUBLIC-IP` of the host running docker-compose.

1. If required, review any of the container logs with `sudo docker logs XXX -f`  where `XXX` is the container process ID from `sudo docker ps`

1. Stop the application

    ```
    docker-compose -f docker-compose-services.yaml down
    ```

## Monolith topology

1. Start the app 

    ```
    sudo docker-compose -f docker-compose-monolith.yaml up -d
    ```

1. Verify app is running

    It takes about 45 seconds to start, but then the application can be accessed

    ```
    sudo docker ps
    ```

1. Open the front-end in a browser for the app  `http://PUBLIC-IP` where `PUBLIC-IP` of the host running docker-compose.

1. If required, review any of the container logs with `sudo docker logs XXX -f`  where `XXX` is the container process ID from `sudo docker ps`

1. Stop the application

    ```
    docker-compose -f docker-compose-monolith.yaml down
    ```