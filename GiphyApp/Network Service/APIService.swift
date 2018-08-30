//
//  APIService.swift
//  GiphyApp
//
//  Created by Алексей on 26.08.2018.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import UIKit

@objcMembers class APIService: NSObject {
    static let shared = APIService(apiKey: "dc6zaTOxFJmzC")
    
    private var apiKey: String
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 1
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        return URLSession(configuration: config)
    }()
    
    private init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func getFullURL(queryType: APIRequestType, offset: Int, limit: Int, rating: GifRatingType, searchString: String?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.giphy.com"
        urlComponents.path = "/v1/gifs/\(queryType.rawValue)"
        
        let apiKeyQuery = URLQueryItem(name: "api_key", value: self.apiKey)
        let offsetQuery = URLQueryItem(name: "offset", value: String(offset))
        let limitQuery = URLQueryItem(name: "limit", value: String(limit))
        let ratingQuery = URLQueryItem(name: "rating", value: rating.rawValue)
        
        urlComponents.queryItems = [apiKeyQuery, offsetQuery, limitQuery, ratingQuery]
        
        if let searchString = searchString,
            queryType == .search {
            let searchQuery = URLQueryItem(name: "q", value: searchString)
            urlComponents.queryItems?.append(searchQuery)
        }
        
        return urlComponents.url
    }
    
    private func fetchGifs<T: JSONDecodable>(url: URL, completionHandler: @escaping (APIResult<[T]>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return completionHandler(.Failure(.ConnectionFailed(error)))
            }
            
            guard let data = data else {
                return completionHandler(.Failure(.NoDataReturned))
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let dictionary = json as? JSON,
                let jsonData = dictionary["data"] as? [JSON] {
                
                var entities = [T]()
                
                for entityData in jsonData {
                    if let entity = T(JSON: entityData) {
                        entities.append(entity)
                    }
                }
                
                return completionHandler(.Success(entities))
            } else {
               return completionHandler(.Failure(.InvalidDataFormat))
            }
            
        }.resume()
    }
    
    @objc func fetchData(URL: URL?, completionHandler: @escaping (Data) -> Void) -> NetworkCancelable? {
        guard let url = URL else {
            return nil
        }
        
        let loadingDataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completionHandler(data)
            }
        }
        loadingDataTask.resume()
        
        return loadingDataTask
    }
    
    public func fetchSearch(query: String,
                       offset: Int = 0,
                       limit: Int = 25,
                       rating: GifRatingType = .unrated,
                       completionHandler: @escaping (APIResult<[GifEntity]>) -> Void) {
        
        guard let url = self.getFullURL(queryType: .search, offset: offset, limit: limit, rating: rating, searchString: query) else { return }
        
        self.fetchGifs(url: url, completionHandler: completionHandler)
        
    }
    
    public func fetchTrending(offset: Int = 0,
                              limit: Int = 25,
                              rating: GifRatingType = .unrated,
                              completionHandler: @escaping (APIResult<[GifEntity]>) -> Void) {
        
        guard let url = self.getFullURL(queryType: .trending, offset: offset, limit: limit, rating: rating, searchString: nil) else { return }
        
        self.fetchGifs(url: url, completionHandler: completionHandler)
    }
    
}
