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
import PerfectCrypto
import LoggerAPI
import Kitura

/// A class that represents middleware for checking if an authorized token placed in the request.
public final class JWTMiddleware: RouterMiddleware {
    
    // MARK: - Private Instance Attributes
    private let publicKey = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDdlatRjRjogo3WojgGHFHYLugdUWAY9iR3fy4arWNA1KoS8kVw33cJibXr8bvwUAUparCwlvdbH6dvEOfou0/gCFQsHUfQrSDv+MuSUMAe8jzKE4qW+jK+xQU9a03GUnKHkkle+Q0pX/g6jXZ7r1/xAK5Do2kQ+X5xK9cipRgEKwIDAQAB\n-----END PUBLIC KEY-----\n"
    
    
    // MARK: - Initializers
    
    /// Initializes an instance of `JWTMiddleware`.
    public init() {}
    
    
    // MARK: - RouterMiddleware Methods
    public func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        
        /// Sends an authorization failure back to the client.
        func sendAuthorizationFailed() {
            do {
                Log.error("Authorization token not present")
                try response.status(.unauthorized).send("No Authorization token provided").end()
            } catch {
                Log.error("Failed to send unauthorized status: \(error)")
            }
        }
        
        guard let authorizationHeader = request.headers["Authorization"] else {
            Log.error("No Authorization Header found")
            sendAuthorizationFailed()
            return
        }
        let signedJWTToken = authorizationHeader.components(separatedBy: " ")[0]
        do {
            guard let jwtVerifier = JWTVerifier(signedJWTToken) else {
                Log.error("Failed to verify \(signedJWTToken)")
                sendAuthorizationFailed()
                return
            }
            let publicKeyAsPem = try PEMKey(source: publicKey)
            try jwtVerifier.verify(algo: .rs256, key: publicKeyAsPem)
            guard let _ = jwtVerifier.payload["issuer"] as? String,
                  let _ = jwtVerifier.payload["issuedAt"] as? Double,
                  let _ = jwtVerifier.payload["expiration"] as? Double else {
                    Log.error("Couldn't find issuer, issuedAt, and expiration in payload")
                    return
            }
            // @TODO: Should also check that the token has not expired
            // @TODO: Check that issuer and issuedAt values are correct
            Log.info("Token verified")
            next()
        } catch {
            Log.error("Failed to decode/validate \(signedJWTToken): \(error)")
        }
    }
}
