//
//  GHSearchUserViewModel.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 15/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation
class GHSearchUserViewModel {
    // MARK: - Class Variables
    var userId :String  = ""
    var userModel   :GHUserModel?
    var userService     = GHUserService.init(NetworkHandler())
    var dataFetch       : ((GHUserModel)->())?
    var dataFetchFailed : ((String)->())?
}

// MARK: - API calls
extension GHSearchUserViewModel {
    func fetchUsrer() {
        userService.fetchUser(userId) {[weak self] (user, error) in
            if let error = error {
                self?.dataFetchFailed?(error)
            } else if let user = user{
                self?.userModel = user
                self?.dataFetch?(user)
            } else {
                self?.dataFetchFailed?("Unable to load data")
            }            
        }
    }
}
