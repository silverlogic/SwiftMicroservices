# ProductService

The Product Service. This microservice manages a list of purchasable products.

## Accessing the Service

The base url of the scraper is `http://localhost:8081`.
There are four routes that are available:

* `GET /v1/products` This returns a list of products to purchase.
* `GET /v1/products/:productId` This returns a specific product to purchase.
* `POST /v1/products/:productId/purchase` This route purchases a product. You must provide a authorization token in order to access this route.

## Requirements

* Swift 4.0.*
* Swift Package Manager
* Make

## Setup

With the repo already cloned locally on your machine, perform the following command for setup and running the service: `$ make start_env`.
