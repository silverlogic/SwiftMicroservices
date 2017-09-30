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
import SwiftyJSON

/// A struct that represents a product.
struct Product {
    let productId: Int
    let productName: String
    let productPrice: Double
    
    /// Returns a JSON representation of the instance.
    ///
    /// - Returns: A `JSON` representing the JSON version of the instance.
    func toJSON() -> JSON {
        return JSON([
            "id": productId,
            "name": productName,
            "price": productPrice
        ])
    }
}

/// A class that mimics a data store for storing instances of `Product`.
final class ProductDataStore {
    
    // MARK: - Private Instance Attributes
    private let products = [
        Product(productId: 1, productName: "⌚️", productPrice: 329),
        Product(productId: 2, productName: "📱", productPrice: 799),
        Product(productId: 3, productName: "💻", productPrice: 1399),
        Product(productId: 4, productName: "🖥", productPrice: 2999)
    ]
    
    
    // MARK: - Public Instance Methods
    
    /// Returns all avaliable products.
    ///
    /// - Returns: An `[Product]` representing a list of all available products.
    func allProducts() -> [Product] {
        return products
    }
    
    /// Returns a product based on a given id.
    ///
    /// - Parameter id: An `Int` representing the id of the product.
    /// - Returns: A `Product?` representing the product retirevied from the given id.
    func productById(_ id: Int) -> Product? {
        return products.first(where: { $0.productId == id })
    }
}
