//
//  UserDetailViewModel.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 15/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation
import UIKit
class GHUserDetailViewModel {
    
    var userName        = ""
    var userEmail       = ""
    var userFollowers   = ""
    
    
    var userId :String  = ""
    var userModel   :GHUserModel?
    var userService     = GHUserService.init(NetworkHandler())
    var imageService    = GHImageService.init(NetworkHandler())
    var imageFetch      : ((UIImage?)->())?
    var dataFetch       : ((GHUserModel)->())?
    var dataFetchFailed : ((String)->())?
}

extension GHUserDetailViewModel {
    func setUpUser() {
        userId = userModel?.login ?? ""
        userName        = "Name: \(userModel?.name ?? "")"
        userEmail       = "Email: \(userModel?.email ?? "")"
        userFollowers   = "No. of Followers: \(userModel?.followers ?? 0)"
        fetchUsrerImge()
    }
    
    
    func fetchUsrerImge() {
        guard let iamgePath = userModel?.avatarURL else { return }
        imageService.fetchImage(iamgePath) { [weak self] (image, error) in
            self?.imageFetch?(image)
        }
    }
    
    
}
