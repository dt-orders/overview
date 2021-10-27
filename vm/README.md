# Overview 

This folder contains the script and files to start and stops the dt-orders application using docker-compose. 

# Prerequisites

Have a Virtual machine that will host the application. See [VM SETUP README](VMSETUP.md) for details.

# Start the application 

There are two docker-compose files to run the `monolith` or `multi-services` topologies of the application.  For demos they typically are run on two separate hosts.

To support automation scripts, a set of unix shell scripts can be used to start and stop the applications.  Log files from these scripts are written to the `/tmp` directory.

If you are in Azure or installed to a path other than `/home/ubuntu` then you need to pass the folder where the scripts were cloned.

1. SSH into the virtual machine

1. Clone this repo 

    ```
    cd ~
    git clone https://github.com/dt-orders/overview.git
    ```

1. From the cloned repo, navigate to the virtual machine subfolder

    ```
    cd overview/vm
    ```

## Multiple services topology

1. Start the app 

    ```
    # with /home/ubuntu as the HOME
    sudo ./start-services.sh

    # or with azureuser home 
    sudo ./start-services.sh /home/azureuser
    ```

1. Verify app is running. You should see containers in `UP` status.

    ```
    sudo docker ps
    ```

1. It takes about 45 seconds to start, but then the application can be accessed.  To access the application, open the front-end in a browser for the app  `http://PUBLIC-IP` where `PUBLIC-IP` of the host running docker-compose.

1. If required, review any of the container logs with `sudo docker logs XXX -f`  where `XXX` is the container process ID from `sudo docker ps`

1. Stop the application

    ```
    # with /home/ubuntu as the HOME
    sudo ./stop-services.sh

    # or with azureuser home 
    sudo ./stop-services.sh /home/azureuser
    ```

## Monolith topology

1. Start the app 

    ```
    # with /home/ubuntu as the HOME
    sudo ./start-monolith.sh

    # or with azureuser home 
    sudo ./start-monolith.sh /home/azureuser
    ```

1. Verify app is running.  You should see containers in `UP` status.

    ```
    sudo docker ps
    ```

1. It takes about 45 seconds to start, but then the application can be accessed.  To access the application, open the front-end in a browser for the app  `http://PUBLIC-IP` where `PUBLIC-IP` of the host running docker-compose.

1. If required, review any of the container logs with `sudo docker logs XXX -f`  where `XXX` is the container process ID from `sudo docker ps`

1. Stop the application

    ```
    # with /home/ubuntu as the HOME
    sudo ./stop-monolith.sh

    # or with azureuser home 
    sudo ./stop-monolith.sh /home/azureuser
    ```
