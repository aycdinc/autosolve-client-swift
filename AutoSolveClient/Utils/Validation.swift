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
        let url = URL(string: "https://dash.autosolve.aycd.io/rest/\(accessToken)/verify/\(apiKey)?clientId=\(clientKey)")
        var timer = 0.0
        var statusCode: Int?
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                print("Error took place in AutoSolve validation \(error)")
                statusCode = 0
                return
            } else if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
            } else {
                statusCode = 0
            }
        }
        task.resume()
        repeat {
            timer += 0.1
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while statusCode == nil && timer < 30.0
        return statusCode!
    }
}
