![build passing](https://travis-ci.org/elhowm/mr-shipper.svg)
![mainability](https://api.codeclimate.com/v1/badges/7eaae5a0f936c94953b8/maintainability)
[![codebeat badge](https://codebeat.co/badges/8a95de4f-790e-4b40-a2c3-1985549dd5b7)](https://codebeat.co/projects/github-com-elhowm-mr-shipper-master)

# mr-shipper
Easy going shipment for your docker-compose apps

## Install

` $ gem install mr-shipper`

## Configure

You need to create your own `shipper.yml` file with the content similar to:

```yaml
services:
  production:
    frontend:
      path: "./sample-fronted"
      before_build:
        - "yarn build"
      repo: "<dockerhub-nickname>/sample-fronted"
    backend:
      path: "./sample-backend"
      repo: "<dockerhub-nickname>/sample-backend"
hosts:
  production:
    ssh_entry: "user@host"
    location: "~/apps/sample"
```

## Use

- To ship all services in your `shipper.yml`

  `$ ship`

  Note: it ships production environment

- To specify the list of services which need to be shipped

  `$ ship production frontend super_api ...`

- To recreate containers on host

  `$ ship production restart`

- To specify custom ssh port

  `ssh_entry: "user@host:123`

And so.. that's all for now.
To be expanded with more cooler configurations for different hosts and so on..
