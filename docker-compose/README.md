# Overview 

This folder contains the script and files to start the dt-orders application using docker-compose.  

Once the application is running, see these repos for scripts that will create traffic against the running application
* [Browser traffic](https://github.com/dt-orders/browser-traffic)
* [Load traffic](https://github.com/dt-orders/load-traffic)

# Prerequisites

1 . Have a host with [docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/) installed on it

2 . Clone this repo 

# Monolith topology

## Start the application

Run `docker-compose -f docker-compose-monolith.yaml up -d` to start all the services.  It takes about 45 seconds to start, but then the application can be accessed

## Check that frontend and service containers are running

Verify pods with `docker-compose ps`

Open the front-end in a browser for the app `http://localhost` or the public IP of the host it was run on

## Stop the application

Run this command to stop `docker-compose -f docker-compose-monolith.yaml down`

# Microservices topology

## Start the application

Run `docker-compose up -d` to start all the services.  It takes about 45 seconds to start, but then the application can be accessed

## Check that frontend and service containers are running

Verify pods with `docker-compose ps`

Open the front-end in a browser for the app `http://localhost` or the public IP of the host it was run on

## Stop the application

Run this command to stop `docker-compose down`

## Change image versions

Edit the `docker-compose.yaml` and run `docker-compose up` again.
