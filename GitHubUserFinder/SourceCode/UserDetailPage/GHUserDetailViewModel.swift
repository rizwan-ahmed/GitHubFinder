//
//  UserDetailViewModel.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 15/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation
class GHUserDetailViewModel {
    var userId :String  = ""
    var userModel   :GHUserModel?
    var userService     = GHUserService.init(NetworkHandler())
    var dataFetch       : ((GHUserModel)->())?
    var dataFetchFailed : ((String)->())?
}

extension GHUserDetailViewModel {
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
