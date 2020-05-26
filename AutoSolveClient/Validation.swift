//
//  Validation.swift
//  swift-test
//
//  Created by Scott Kapelewski on 22.05.20.
//  Copyright © 2020 Scott Kapelewski. All rights reserved.
//

import Foundation


class Validator {
    internal static func validateCredentials(accessToken: String, apiKey: String, clientKey: String) throws -> Bool {
        let statusCode = makeValidateRequest(accessToken: accessToken, apiKey: apiKey, clientKey: clientKey)
        switch statusCode {
        case AutoSolveConstants.InvalidClientKeyStatusCode:
            throw AutoSolveError.InvalidClientKey
        case AutoSolveConstants.InvalidCredentialsStatusCode:
            throw AutoSolveError.InvalidApiKeyOrToken
        case AutoSolveConstants.TooManyRequests:
            throw AutoSolveError.TooManyRequests
        default:
            return statusCode == 200
        }
    }
    
    private static func makeValidateRequest(accessToken: String, apiKey: String, clientKey: String) -> Int {
        let url = URL(string: "https://dashboard.autosolve.io/rest/\(accessToken)/verify/\(apiKey)?clientId=\(clientKey)")
        var statusCode: Int?
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place in AutoSolve validation \(error)")
                statusCode = 0
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
            }
            
        }
        task.resume()
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while statusCode == nil
        return statusCode!
    }
}
