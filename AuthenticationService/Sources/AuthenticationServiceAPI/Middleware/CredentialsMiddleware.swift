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
import CredentialsHTTP
import Credentials
import LoggerAPI

/// A class that represents middleware for handling authentication.
public final class CredentialsMiddleware {
    
    // MARK: - Private Instance Atttributes
    private let users = ["username": "password"]
    
    
    // MARK: - Public Instance Attributes
    
    /// The credentials middleware instance.
    public let credentials: Credentials
    
    
    // MARK: - Initializers
    
    /// Initializes an instance of `CredentialsMiddleware`.
    public init() {
        credentials = Credentials()
        let httpBasicCredentials = CredentialsHTTPBasic(verifyPassword: { userId, password, callback in
            guard let storedPassword = self.users[userId], storedPassword == password else {
                Log.error("\(userId) provided invalid credentials")
                callback(nil)
                return
            }
            let userProfile = UserProfile(id: userId, displayName: userId, provider: "HTTPBasic")
            callback(userProfile)
        })
        credentials.register(plugin: httpBasicCredentials)
    }
}
