//
//  GHUserModel.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 14/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation

// MARK: - GHUserModel
struct GHUserModel: Codable {
    let login               : String?
    let avatarURL           : String?
    let url, followersURL   : String?
    let name, email         : String?
    let followers           : Int?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case url
        case followersURL = "followers_url"
        case name, email, followers
    }
}
