# AuthenticationService

The Authentication Service. This microservice manages authentication.

## Accessing the Service

To receive an Authorization Token to use for authenticated requests, access `GET http://localhost:8082/login` in a browser. A dialog will appear prompting for username and password. The username is `username` and the password is `password`. If entered successfully, you will receive a token.

## Requirements

* Swift 4.0.*
* Swift Package Manager
* Make

## Setup

With the repo already cloned locally on your machine, perform the following command for setup and running the service: `$ make start_env`.

