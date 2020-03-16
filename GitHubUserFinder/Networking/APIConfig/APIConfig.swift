//
//  APIConfig.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 15/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation
enum APIConfig {
    case searchUser(userName: String)
    case followers(userName: String)
    case image(path: String)
    
    private var envBaseURL: String {
        switch NetworkHandler.environment {
        case .production:
            return "https://api.github.com/users/"
        case .staging:
            return "https://api.github.com/users/"
        case .development:
            return "https://api.github.com/users/"
        }
    }
}

extension APIConfig {    
    var path: String {
        switch self {
        case .searchUser(let userName):
            return self.envBaseURL + userName
            
        case .followers(let userName):
            return self.envBaseURL + userName + "/followers"
            
        case .image(let path):
            return path
        }
    }    
}
