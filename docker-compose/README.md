# Overview 

This folder contains the script and files to start the dt-orders application using docker-compose.  

# Prereqs

Below are instructions for preparing to run the application 

1. The application runs on port 80 so ensure the VM had has a public IP and these ports open.

1. On the VM to run the application run the following on an AWS EC2 Linux OS

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

1. clone this repo `git clone https://github.com/dt-orders/overview.git`

# Start the application 

There are two docker-compose files to run a `monolith` and a `services` backend for the application.  

1. From the cloned repo, navigate to the app subfolder

    ```
    cd overview/docker-compose
    ```

2. Start the app 

    ```
    # for monolith
    sudo docker-compose -f docker-compose-monolith.yaml up -d

    # for services
    sudo docker-compose -f docker-compose-services.yaml up -d
    ```

# Verify app is running

It takes about 45 seconds to start, but then the application can be accessed

Verify pods with `sudo docker ps`

You can review any of the container logs with `sudo docker logs XXX -f`  where `XXX` is the container process ID from `sudo docker ps`

Open the front-end in a browser for the app  `http://PUBLIC-IP` 

# Stop the application

Run this command to stop the containers

```
# for monolith
docker-compose -f docker-compose-monolith.yaml down

# for services
docker-compose -f docker-compose-services.yaml down
```