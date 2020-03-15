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
    var publicRepos   = ""
    
    
    var userId :String  = ""
    var userService             = GHUserService.init(NetworkHandler())
    var imageService            = GHImageService.init(NetworkHandler())
    
    private var followerList    = [GHFollowerModel]()
    
    var userModel               :GHUserModel?
    var imageFetch              : ((UIImage?)->())?
    var followersFetch          : (([GHFollowerModel])->())?
    var dataFetchFailed         : ((String)->())?
}

extension GHUserDetailViewModel {
    func setUpUser() {
        userId = userModel?.login ?? ""
        userName        = "Name: \(userModel?.name ?? "")"
        userEmail       = "Email: \(userModel?.email ?? "")"
        publicRepos   = "Public repos: \(userModel?.publicRepos ?? 0)"
        fetchUsrerImge()
        if let followersCount = userModel?.followers, followersCount > 0 {
            fetchFollowers()
        }
    }
    
    func getNumberOfRows() -> Int {
        return followerList.count
    }
    
    func getFollower(atIndex index: Int) -> GHFollowerModel? {
        guard index >= 0 && index < followerList.count else { return nil }
        return followerList[index]
    }
}

extension GHUserDetailViewModel {
    func fetchUsrerImge() {
        guard let iamgePath = userModel?.avatarURL else { return }
        imageService.fetchImage(iamgePath) { [weak self] (image, error) in
            self?.imageFetch?(image)
        }
    }
    
    func fetchFollowers() {
        userService.fetchFollowers(userId) { [weak self] (followers, error) in
            if let error = error {
                self?.dataFetchFailed?(error)
            } else if let followers = followers{
                self?.followerList = followers
                self?.followersFetch?(followers)
            } else {
                self?.dataFetchFailed?("Unable to load data")
            }            
        }
    }
}
