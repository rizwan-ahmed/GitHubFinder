//
//  GHFollowerModel.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 14/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation

// MARK: - GHFollowerModel
struct GHFollowerModel: Codable {
    let login       : String?
    let id          : Int?
    let avatarURL   : String?
    let htmlURL     : String?
    let type        : String?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case type
        
    }
}
