//MIT License
//
//Copyright (c) 2017 Manny Guerrero
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import Foundation
import Kitura
import LoggerAPI
import HeliumLogger
import ProductServiceAPI

// Setup the middleware and routes avaliable for this service
let router = Router()
router.all("/*", middleware: LoggingMiddleware())
let handlers = Handlers()
router.get("/v1/products", handler: handlers.handleProducts)
router.get("/v1/products/:productId", handler: handlers.handleProduct)
router.post("/v1/products/:productId/purchase", handler: handlers.handlePurchaseProduct)
// Setup logging
Log.logger = HeliumLogger()
// Setup and start server
Kitura.addHTTPServer(onPort: 8081, with: router)
Kitura.run()
