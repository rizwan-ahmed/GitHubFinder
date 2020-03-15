//
//  GHFollowerCellViewModel.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 16/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation
import UIKit


class GHFollowerCellViewModel {
    
    var userName        = ""
    var userEmail       = ""
        
    var userId :String  = ""
    var followerModel   : GHFollowerModel?
    var imageService    :GHImageService
    var imageFetch      : ((UIImage?)->())?
    var dataFetchFailed : ((String)->())?
    
    private init(){
         imageService  = GHImageService.init(NetworkHandler())
     }
     convenience init(_ follower: GHFollowerModel) {
         self.init()
         self.followerModel = follower
     }
}

extension GHFollowerCellViewModel {
    
    func setUpUser() {
        userName        = "Name: \(followerModel?.login ?? "")"
        userEmail       = "Email: \(followerModel?.htmlURL ?? "")"
    }
    
    
    func fetchImage() {
        guard let iamgePath = followerModel?.avatarURL else { return }
        imageService.fetchImage(iamgePath) { [weak self] (image, error) in
            self?.imageFetch?(image)
        }
    }
}
