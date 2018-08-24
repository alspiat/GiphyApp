//
//  APIService.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

enum APIServiceError {
    case NoDataReturned
    case InvalidDataFormat
    case ConnectionFailed(Error)
    
    var description: String {
        switch self {
        case .NoDataReturned:
            return "No data returned"
        case .InvalidDataFormat:
            return "Parsing was failed"
        case .ConnectionFailed(let error):
            return "Connection failed: \(error.localizedDescription)"
        }
    }
}

class APIService: NSObject {
    
    static let shared = APIService(apiKey: "4cuwERJ0LN5JjlzdZDdWe5DOSFN2Yj0o")
    
    private var apiKey: String?
        
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        return URLSession(configuration: config)
    }()
    
    private init(apiKey: String) {
        self.apiKey = apiKey
    }

    private func getFullURL(queryType: APIQueryType, offset: Int, limit: Int, rating: APIRatingType, searchString: String?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.giphy.com"
        urlComponents.path = "/v1/gifs/\(queryType.rawValue)"
        
        let apiKeyQuery = URLQueryItem(name: "api_key", value: self.apiKey)
        let offsetQuery = URLQueryItem(name: "offset", value: String(offset))
        let limitQuery = URLQueryItem(name: "limit", value: String(limit))
        let ratingQuery = URLQueryItem(name: "rating", value: rating.rawValue)
        
        if let searchString = searchString,
            queryType == .searching {
            let searchQuery = URLQueryItem(name: "q", value: searchString)
            urlComponents.queryItems = [apiKeyQuery, offsetQuery, limitQuery, ratingQuery, searchQuery]
        } else {
            urlComponents.queryItems = [apiKeyQuery, offsetQuery, limitQuery, ratingQuery]
        }
        
        return urlComponents.url
    }
    
    private func fetchData(url: URL, completionHandler: @escaping (Data?, APIServiceError?) -> Void) {
        
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return completionHandler(nil, .ConnectionFailed(error))
            }
            
            guard let data = data else {
                return completionHandler(nil, .NoDataReturned)
            }
            
            completionHandler(data, nil)
            
        }.resume()
    }
    
    public func trending(offset: Int = 0,
                         limit: Int = 25,
                         rating: APIRatingType = .unrated,
                         completionHandler: @escaping () -> Void) {
        
        guard let url = self.getFullURL(queryType: .trending, offset: offset, limit: limit, rating: rating, searchString: nil) else { return }
        
    }
    
    public func search(query: String,
                        offset: Int = 0,
                        limit: Int = 25,
                        rating: APIRatingType = .unrated,
                        completionHandler: @escaping () -> Void) {
        
        guard let url = self.getFullURL(queryType: .searching, offset: offset, limit: limit, rating: rating, searchString: query) else { return }
        
    }
    
}
