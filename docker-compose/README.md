# Deployment using docker-compose

This will setup the application using docker-compose.

1 . Have a host with [Docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/) installed on it

2 . Clone this repo 

3 . Start the application

You can adjust the `docker-compose.yaml` for alternate ports and images names to meet your needs. But, you can just run `docker-compose up` to start all the services.  It takes about 45 seconds to start, but then the application can be accessed

```
docker-compose up -d
```

For running the backend monolith setup, run this command

```
docker-compose -f docker-compose-monolith.yaml up -d
```

4 . Check that frontend and service containers are running

```
docker-compose ps
```

5 . Open the front-end in a browser for the app `http://localhost`

6 . Stop the application

```
docker-compose down
```

If ran the backend monolith setup, run this command

```
docker-compose -f docker-compose-monolith.yaml down
```

7 . To change image versions, just edit the `docker-compose.yaml` and run `docker-compose up` again.
