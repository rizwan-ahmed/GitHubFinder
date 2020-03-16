//
//  GHImageService.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 15/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCompletionBlock = (_ image: UIImage?,_ error: String?)-> ()

struct GHImageService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}

// MARK: - API method

extension GHImageService {
    func fetchImage(_ imageURLPath: String, completion: @escaping ImageCompletionBlock) {
        let url = URL(string: APIConfig.image(path: imageURLPath).path)
        let urlRequest = URLRequest(url: url!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 3.0)
        
        let successHandler: (Data) -> Void = { (imagedata) in
            if let image = UIImage(data: imagedata) {
                completion(image, nil)
            } else
            {
                completion(nil, "Unabe to Load Image")
            }
        }
        let errorHandler: (String) -> Void = { (error) in
            completion(nil, error)
        }
        networkHandler
            .get(urlRequest: urlRequest, successHandler: successHandler, errorHandler: errorHandler)
    }
}
