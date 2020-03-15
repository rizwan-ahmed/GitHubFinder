//
//  GHSearchUserService.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 15/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation

typealias UserFetchedBlock = (_ user: GHUserModel?,_ error: String?)-> ()
typealias FollowersFetchedBlock = (_ followers: [GHFollowerModel]? ,_ error: String?)-> ()

struct GHUserService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}

extension GHUserService {
    func fetchUser(_ userId: String, completion: @escaping UserFetchedBlock) {
        let urlString = APIConfig.searchUser(userName: userId).path
        let successHandler: (GHUserModel) -> Void = { (gitHUbUser) in
            print("*****  1  USER data : \(gitHUbUser)")
            completion(gitHUbUser, nil)
        }
        let errorHandler: (String) -> Void = { (error) in
            completion(nil, error)
        }
        networkHandler.fetch(urlString:urlString, successHandler: successHandler, errorHandler: errorHandler)
        
    }
    
    
    func fetchFollowers(_ userId: String, completion: @escaping FollowersFetchedBlock) {
        let urlString = APIConfig.followers(userName: userId).path
        let successHandler: ([GHFollowerModel]) -> Void = { (followers) in
            print("*****  1  USER data : \(followers)")
            completion(followers, nil)
        }
        let errorHandler: (String) -> Void = { (error) in
            completion(nil, error)
        }
        networkHandler.fetch(urlString:urlString, successHandler: successHandler, errorHandler: errorHandler)
        
    }
}
