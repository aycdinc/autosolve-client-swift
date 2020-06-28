//
//  AutoSolveTokenRequest.swift
//  swift-test
//
//  Created by Scott Kapelewski on 22.05.20.
//  Copyright © 2020 Scott Kapelewski. All rights reserved.
//

import Foundation

public class AutoSolveTokenRequest : AutoSolveRequest{
    public var taskId: String
    public var apiKey: String
    public var createdAt: Int
    public let url: String
    public let siteKey: String
    public let renderParameters: [String : String]
    public let version: Int
    public let action: String
    public let minScore: Double
    public let proxy: String
    public let proxyRequired: Bool
    public let userAgent: String
    public let cookies: String
    
    public init(taskId: String, url: String, siteKey: String, renderParameters: [String : String] = [:], version: Int = 0,
         action: String = "", minScore: Double = 0.3, proxy: String = "", proxyRequired: Bool = false, userAgent: String = "", cookies: String = "") {
        self.taskId = taskId
        self.apiKey = ""
        self.createdAt = Int(Date().timeIntervalSince1970.rounded())
        self.url = url
        self.siteKey = siteKey;
        self.renderParameters = renderParameters
        self.version = version
        self.action = action
        self.minScore = minScore
        self.proxy = proxy
        self.proxyRequired = proxyRequired
        self.userAgent = userAgent
        self.cookies = cookies
    }
    
    func type() -> String {
        return AutoSolveConstants.TokenRequest
    }
}
