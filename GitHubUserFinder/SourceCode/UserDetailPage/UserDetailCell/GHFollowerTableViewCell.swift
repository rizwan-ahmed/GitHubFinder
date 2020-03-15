//
//  GHFollowerTableViewCell.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 15/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import UIKit

class GHFollowerTableViewCell: UITableViewCell {
    
    var viewModel : GHFollowerCellViewModel?
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image    = nil
        nameLabel.text    = ""
        emailLabel.text   = ""
    }
    
    func setupCell(index: Int, follower : GHFollowerModel) {
        viewModel = GHFollowerCellViewModel(follower)
        viewModel?.setUpUser()
        viewModel?.imageFetch = { [weak self] (image) in
            if let userImage = image {
                DispatchQueue.main.async {
                    self?.userImageView.image = userImage
                }
            }
        }
        viewModel?.fetchImage()
        indexLabel.text = "\(index + 1)"
        nameLabel.text = viewModel?.userName
        emailLabel.text = viewModel?.userEmail
        
    }
}
