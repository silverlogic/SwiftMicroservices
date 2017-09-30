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
import PerfectCrypto
import LoggerAPI

/// A class that manages the different handlers for routes.
public final class Handlers {
    
    // MARK: - Private Instance Attributes
    // NEVER DO THIS IN PRODUCTION! PRIVATE KEYS SHOULD BE KEPT SECURE!
    private let privateKey =  "-----BEGIN RSA PRIVATE KEY-----\nMIICWwIBAAKBgQDdlatRjRjogo3WojgGHFHYLugdUWAY9iR3fy4arWNA1KoS8kVw33cJibXr8bvwUAUparCwlvdbH6dvEOfou0/gCFQsHUfQrSDv+MuSUMAe8jzKE4qW+jK+xQU9a03GUnKHkkle+Q0pX/g6jXZ7r1/xAK5Do2kQ+X5xK9cipRgEKwIDAQABAoGAD+onAtVye4ic7VR7V50DF9bOnwRwNXrARcDhq9LWNRrRGElESYYTQ6EbatXS3MCyjjX2eMhu/aF5YhXBwkppwxg+EOmXeh+MzL7Zh284OuPbkglAaGhV9bb6/5CpuGb1esyPbYW+Ty2PC0GSZfIXkXs76jXAu9TOBvD0ybc2YlkCQQDywg2R/7t3Q2OE2+yo382CLJdrlSLVROWKwb4tb2PjhY4XAwV8d1vy0RenxTB+K5Mu57uVSTHtrMK0GAtFr833AkEA6avx20OHo61Yela/4k5kQDtjEf1N0LfI+BcWZtxsS3jDM3i1Hp0KSu5rsCPb8acJo5RO26gGVrfAsDcIXKC+bQJAZZ2XIpsitLyPpuiMOvBbzPavd4gY6Z8KWrfYzJoI/Q9FuBo6rKwl4BFoToD7WIUS+hpkagwWiz+6zLoX1dbOZwJACmH5fSSjAkLRi54PKJ8TFUeOP15h9sQzydI8zJU+upvDEKZsZc/UhT/SySDOxQ4G/523Y0sz/OZtSWcol/UMgQJALesy++GdvoIDLfJX5GBQpuFgFenRiRDabxrE9MNUZ2aPFaFp+DyAe+b4nDwuJaW2LURbr8AEZga7oQj0uYxcYw==\n-----END RSA PRIVATE KEY-----\n"
    
    
    // MARK: - Initializers
    
    /// Initiailizes an instance of `Handlers`.
    public init() {}
    
    
    // MARK: - Public Instance Attributes
    
    /// Handles the login route.
    ///
    /// - Parameters:
    ///   - request: A `RouterRequest` representing the request that came in.
    ///   - response: A `RouterResponse` representing the response to send.
    ///   - next: A closure that gets invoked when the handler completes.
    public func handleLogin(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        let jwtPayload: [String: Any] = [
            "issuer": "tsl.authenticationservice",
            "issuedAt": Date().timeIntervalSince1970,
            "expiration": Date().append(months: 1).timeIntervalSince1970
        ]
        guard let jwtCreator = JWTCreator(payload: jwtPayload) else {
            response.status(.internalServerError).send("Error creating token")
            next()
            return
        }
        do {
            let privateKeyAsPem = try PEMKey(source: privateKey)
            let signedJWTToken = try jwtCreator.sign(alg: .rs256, key: privateKeyAsPem)
            response.status(.OK).send(json: ["token": signedJWTToken])
            next()
        } catch {
            Log.error("Error generating signed JWTToken")
        }
    }
}
