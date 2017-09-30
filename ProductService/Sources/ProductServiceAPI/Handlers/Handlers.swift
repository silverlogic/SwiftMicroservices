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
import SwiftyJSON

/// A class that manages the different handlers for routes.
public final class Handlers {
    
    // MARK: - Private Instance Attributes
    private let productStore = ProductDataStore()
    
    
    // MARK: - Initializers
    
    /// Initializes an instance of `Handlers`.
    public init() {}
    
    
    // MARK: - Public Instance Attributes
    
    /// Handles the all products route.
    ///
    /// - Parameters:
    ///   - request: A `RouterRequest` representing the request that came in.
    ///   - response:  A `RouterResponse` representing the response to send.
    ///   - next: A closure that gets invoked when the handler completes.
    public func handleProducts(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        let products = productStore.allProducts()
        let json = products.flatMap { (product) -> JSON? in
            return product.toJSON()
        }
        response.send(json: JSON(json))
        next()
    }
    
    /// Handles the product route.
    ///
    /// - Parameters:
    ///   - request: A `RouterRequest` representing the request that came in.
    ///   - response: A `RouterResponse` representing the response to send.
    ///   - next: A closure that gets invoked when the handler completes.
    public func handleProduct(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        guard let id = request.parameters["productId"] else {
            Log.error("productId missing from url")
            response.status(.badRequest).send("'productId is missing from url'")
            next()
            return
        }
        guard let productId = Int(id) else {
            Log.error("Invalid type sent. Should be an integer.")
            response.status(.badRequest).send("Invalid type sent. Should be an integer.")
            next()
            return
        }
        guard let product = productStore.productById(productId) else {
            Log.error("Product not found with given productId")
            response.status(.notFound).send("Product not found with given productId")
            next()
            return
        }
        response.status(.OK).send(json: product.toJSON())
        next()
    }
    
    /// Handles the purchase product route.
    ///
    /// - Parameters:
    ///   - request: A `RouterRequest` representing the request that came in.
    ///   - response: A `RouterResponse` representing the response to send.
    ///   - next: A closure that gets invoked when the handler completes.
    public func handlePurchaseProduct(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        guard let id = request.parameters["productId"] else {
            Log.error("productId missing from url")
            response.status(.badRequest).send("'productId is missing from url'")
            next()
            return
        }
        guard let productId = Int(id) else {
            Log.error("Invalid type sent. Should be an integer.")
            response.status(.badRequest).send("Invalid type sent. Should be an integer.")
            next()
            return
        }
        guard let _ = productStore.productById(productId) else {
            Log.error("Product not found with given productId")
            response.status(.notFound).send("Product not found with given productId")
            next()
            return
        }
        response.status(.OK).send("Product purchased")
        next()
    }
}
