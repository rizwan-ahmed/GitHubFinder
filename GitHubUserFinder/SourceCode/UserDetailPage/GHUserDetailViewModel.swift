//
//  UserDetailViewModel.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 15/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation
class GHUserDetailViewModel {
    
    var userName        = ""
    var userEmail       = ""
    var userFollowers   = ""
    
    var userId :String  = ""
    var userModel   :GHUserModel?
    var userService     = GHUserService.init(NetworkHandler())
    var dataFetch       : ((GHUserModel)->())?
    var dataFetchFailed : ((String)->())?
}

extension GHUserDetailViewModel {
    func setUpUser() {        
        userName        = "Name: \(userModel?.name ?? "")"
        userEmail       = "Email: \(userModel?.email ?? "")"
        userFollowers   = "No. of Followers: \(userModel?.followers ?? 0)"
    }
    func fetchFollowers() {
        userService.fetchUser(userId) {[weak self] (user, error) in
            if let error = error {
                self?.dataFetchFailed?(error)
            } else if let user = user{
                self?.dataFetch?(user)
            } else {
                self?.dataFetchFailed?("Unable to load data")
            }            
        }
    }
}
