//
//  NetworkHandler.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 14/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case staging
    case production
    case development
}

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

enum NetworkResponse: String {
    case success
    case authenticationError    = "Authentication Error"
    case badRequest             = "Bad Request"
    case failed                 = "Network request Failed"
    case noData                 = "No Data Found"
    case unableToDecode         = "Decoding Error"
    case noInternet             = "No Internet Connectivity."
}

struct NetworkHandler {
    
    static let genericError = "Something went wrong. Please try again later"
    static let userNotFoundError = "User Not found"
    static let environment: NetworkEnvironment = .production
}


extension NetworkHandler {
    
    func fetchData(urlString: String, successHandler: @escaping (Data) -> Void,
                   errorHandler: @escaping ErrorHandler, cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData) {
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 3.0)
            get(urlRequest: urlRequest, successHandler: successHandler, errorHandler: errorHandler)
        }
    }
    
    func fetch<T: Decodable>(urlString: String, successHandler: @escaping (T) -> Void,
                             errorHandler: @escaping ErrorHandler, cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData) {
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 3.0)
            get(urlRequest: urlRequest, successHandler: successHandler, errorHandler: errorHandler)
        }
    }
    
    func get<T: Decodable>(urlRequest: URLRequest,
                           successHandler: @escaping (T) -> Void,
                           errorHandler: @escaping ErrorHandler) {
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(error.localizedDescription)
                return
            }
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(NetworkHandler.genericError)
                }
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    successHandler(responseObject)
                    return
                }
            } else if self.isUserNotFound(urlResponse){
                errorHandler(NetworkResponse.noData.rawValue)
                return
            }
            errorHandler(NetworkHandler.genericError)
        }
        URLSession.shared.dataTask(with: urlRequest,
                                   completionHandler: completionHandler)
            .resume()
    }
    
    func get(urlRequest: URLRequest,
             successHandler: @escaping (Data) -> Void,
             errorHandler: @escaping ErrorHandler) {
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(error.localizedDescription)
                return
            }
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response")
                    return errorHandler(NetworkHandler.genericError)
                }
                successHandler(data)
            }
            errorHandler(NetworkHandler.genericError)
        }
        URLSession.shared.dataTask(with: urlRequest,
                                   completionHandler: completionHandler)
            .resume()
    }
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
    
    private func isUserNotFound(_ statusCode: Int) -> Bool {
        return statusCode == 404
    }
    private func isUserNotFound(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isUserNotFound(urlResponse.statusCode)
    }
}
extension NetworkHandler {
    private func parseHTTPResponse(_ urlResponse:HTTPURLResponse) -> NetworkResponse {
        switch urlResponse.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .authenticationError
        case 501...600:
            return .badRequest
        default:
            return .failed
        }
    }
}
