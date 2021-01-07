# Overview 

This folder contains the script and chart files to deploy the dt-orders application using docker-compose.  

Once the application is running, see these repos to create traffic against the running application
* [Browser traffic](https://github.com/dt-orders/browser-traffic)
* [Load traffic](https://github.com/dt-orders/load-traffic)

# Prerequisites

1 . Have a host with [docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/) installed on it

2 . Clone this repo 

# Start the application

1. You can adjust the `docker-compose.yaml` for alternate ports and images names to meet your needs. But, you can just run `docker-compose up` to start all the services.  It takes about 45 seconds to start, but then the application can be accessed

    ```
    docker-compose up -d
    ```

2. For running the backend monolith setup, run this command

    ```
    docker-compose -f docker-compose-monolith.yaml up -d
    ```

# Check that frontend and service containers are running

1. Verify pods

    ```
    docker-compose ps
    ```

2. Open the front-end in a browser for the app `http://localhost` or the public IP of the host it was run on

# Stop the application

1. Run this command to stop

    ```
    docker-compose down
    ```

2. If ran the backend monolith setup, run this command

    ```
    docker-compose -f docker-compose-monolith.yaml down
    ```

# Change image versions

Edit the `docker-compose.yaml` and run `docker-compose up` again.
