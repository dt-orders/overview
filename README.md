# Overview

This application was built for demonstations of Dynatrace.  The front-end look like this.

<img src="images/orders.png" width="300"/>

There are two toplogies of the application
1. **monolith** - two Docker components: a frontend web UI and 1 backend services.  Once monitored by Dynatrace, a multi-tier call flow will be available such as shown below.

    <img src="images/dt-call-flow-monolith.png" width="500"/>

1. **microservices** - four Docker components: a frontend web UI and 3 backend services.  Once monitored by Dynatrace, a multi-tier call flow will be available such as shown below.

    <img src="images/dt-call-flow.png" width="500"/>

# Traffic generators

Once the application is running, the Docker images from these two repos can be used to create traffic against the running application:

* [Browser traffic](https://github.com/dt-orders/browser-traffic)
* [Load traffic](https://github.com/dt-orders/load-traffic)

# Deployment

Below are two option to deploy the application:
* See [docker-compose sub-folder README](docker-compose/README.md)
* See [K8 sub-folder README](k8/README.md)

# Problem Patterns

The dt-orders application has pre-built problems programmed within different versions that can be enabled as a `feature flag` using a URL.

Pre-built docker images are also published to [dockerhub](https://hub.docker.com/u/dtdemos) with the problem patterns ON or OFF if that approach of deploying a new container is desired.  The version is set as a Docker tag, for example: `dtdemos/customer-service:2` is the customer service version 2.

# Monolith App versions

| Service  | Version | Description |
|---|:---:|---|
| frontend | 1 | Normal behavior |
| backend-service | 1 | Normal behavior |

# Microservices App versions

| Service  | Version | Description |
|---|:---:|---|
| frontend | 1 | Normal behavior |
| catalog-service | 1 | Normal behavior |
| customer-service | 1 | Normal behavior |
| order-service | 1 | Normal behavior |
| customer-service | 2 | High Response time for /customer/list.html |
| order-service | 2 | 50% exception for /order/line URL and n+1 back-end calls for /order/form.html |
| customer-service | 3 | Normal behavior |
| order-service | 3 | Normal behavior |

# Microservices - Problem Scenarios

## Customer service version 2

<img src="images/usecase1.png" width="500"/>

## Order service version 2

Both these scenarios are enabled

<img src="images/usecase2.png" width="500"/>

and...

<img src="images/usecase3.png" width="500"/>

# Feature Flag

To set the version using the feature flag - you can use the URL in a browser or just make a GET request to the URL.

| Service | What | URL | Description |
|---|:---:|---|---|
| Customer | View current version | http://x.x.x.x/customer/version | Will just display a number |
| Customer | Set version | http://x.x.x.x/customer/setversion/X | X = value 1 or 2. |
| Catalog | View current version | http://x.x.x.x/catalog/version | Will just display a number |
| Catalog | Set version | http://x.x.x.x/catalog/setversion/X | X = value 1 or 2. |

After setting the version - the response message will say `Action was successful!`.  Also, the version number on the DT Orders home page will reflect the new version.

# Pre-built Docker Images

There is a `buildpush.sh` script in [customer service](https://github.com/dt-orders/customer-service/blob/master/buildpush.sh) and [order service](https://github.com/dt-orders/order-service/blob/master/buildpush.sh) repos that will just set an ENVIRONMENT that will run the services with that version. 

The version number on the DT Orders home page will reflect the service version.

The version can still be changed using the `Feature Flag` mentioned above.
